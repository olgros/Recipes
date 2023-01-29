//
//  NetworkManager.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import Alamofire
import PromiseKit

class NetworkManager {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    let retryLimit = 1
    let restClient = RestClient()
    let acceptableStatusCodes: ClosedRange<Int> = 200...201
    var isUserSignedIn = true// esto debe llegar de inicio sesion
    let log  = Log(String(describing: NetworkManager.self))

    func validateAcceptableStatusCode(_ response: DataResponse<Any, AFError>) -> CustomError? {
        if NetworkManager.shared.acceptableStatusCodes.contains(response.response!.statusCode) {
            return nil
        } else {
            var customError = CustomError()
            switch response.result {
            case .success(let json):
                guard let jsonData = json as? [String: Any] else {
                    log.info("Error")
                    let message = Constants.serverError
                    let error = CustomError(message: message, code: response.response!.statusCode, statusCode: response.response!.statusCode)
                    return error
                }
                customError.errorDescription = (jsonData["message"] as? String) ?? "Error al consultar."
            case .failure:
                customError.statusCode = response.response?.statusCode ?? 500
                if let data = response.data {
                    if let error = self.getCustomError(data){
                        customError = error
                        customError.statusCode = response.response?.statusCode ?? 500
                    }
                }
            }
            return (customError)
        }
    }
    func createRequest(_ route: String, method: HTTPMethod = .get, parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil,
                       interceptor: RequestInterceptor? = nil, _ url: String = "") -> Promise<DataRequest> {
        log.info(String(describing: parameters))
        let promise = Promise<DataRequest> { seal in

            if !NetworkMonitor.shared.isReachable {
                var customError = CustomError()
                customError.message = Constants.intenetError
                seal.reject(customError)
            } else {

                let urlReady = "\(url.trimmingCharacters(in: .whitespacesAndNewlines))\(route)"
                log.info(urlReady)
                let request = isUserSignedIn ? AF.request(urlReady, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor ?? self).validate() : AF.request(urlReady, method: method, parameters: parameters, encoding: encoding, headers: headers)

                request.responseJSON { response in
                    switch response.result {
                    case .success:
                        if let errorInvalidCode = self.validateAcceptableStatusCode(response) {
                            seal.reject(errorInvalidCode)
                            return
                        }
                        seal.resolve(request, nil)
                    case .failure:
                        var customError = CustomError()
                        customError.statusCode = response.response?.statusCode ?? 500
                        self.log.error(String(describing: response))
                        if let data = response.data {
                            if let error = self.getCustomError(data){
                                customError = error
                                customError.statusCode = response.response?.statusCode ?? 500
                            }
                        }
                        seal.reject(customError)
                    }
                }
            }
        }
        return promise
    }

    func arrayRequest<Result: Codable, T: Codable> (_ resource: EndpointResurce, parameters: T? = nil, encoding: ParameterEncoding = JSONEncoding.default, url: String = "") -> Promise<[Result]> {
        let codableDictionary = try? DictionaryEncoder().encode(parameters) as? Parameters
        return createRequest(resource.route, method: resource.method, parameters: codableDictionary, encoding: encoding, headers: nil, interceptor: nil, url.isEmpty ? restClient.baseURL : url ).then { request in
            return Promise { seal in
                request.responseDecodable { (result: DataResponse<[Result], AFError>) -> Void in
                    if let _ = result.error {
                        var customError = CustomError()
                        customError.statusCode = result.response?.statusCode ?? 500
                        if let data = result.data {
                            if let error = self.getCustomError(data){
                                customError = error
                                customError.statusCode = result.response?.statusCode ?? 500
                            }
                        }
                        seal.reject(customError)
                    } else {
                        seal.resolve(result.value, nil)
                    }
                }
            }
        }
    }

    func arrayRequest<Result: Codable>(_ resource: EndpointResurce, encoding: ParameterEncoding = JSONEncoding.default, url: String = "") -> Promise<[Result]> {
        return createRequest(resource.route, method: resource.method, parameters: nil, encoding: encoding, headers: nil, interceptor: nil, url.isEmpty ? restClient.baseURL : url ).then { request in
            return Promise { seal in
                request.responseDecodable { (result: DataResponse<[Result], AFError>) -> Void in
                    if let _ = result.error {
                        var customError = CustomError()
                        customError.statusCode = result.response?.statusCode ?? 500
                        if let data = result.data {
                            if let error = self.getCustomError(data){
                                customError = error
                                customError.statusCode = result.response?.statusCode ?? 500
                            }
                        }
                        seal.reject(customError)
                    } else {
                        seal.resolve(result.value, nil)
                    }
                }
            }
        }
    }

    public func request<Result: Codable> (_ resource: EndpointResurce, captchaToken: String? = "", encoding: ParameterEncoding = JSONEncoding.default, url: String = "") -> Promise<Result?> {
        let headers = restClient.defaultHeader
    
        return createRequest(resource.route, method: resource.method, parameters: nil, encoding: encoding, headers: headers, interceptor: nil, url.isEmpty ? restClient.baseURL : url ).then { request in
            return Promise { seal in
                request.responseDecodable { (result: DataResponse<Result, AFError>) -> Void in
                    if let _ = result.error {
                        var customError = CustomError()
                        customError.statusCode = result.response?.statusCode ?? 500
                        if let data = result.data {
                            if let error = self.getCustomError(data){
                                customError = error
                                customError.statusCode = result.response?.statusCode ?? 500
                            }
                        }
                        seal.reject(customError)
                    } else {
                        seal.resolve(result.value, nil)
                    }
                }
            }
        }
    }

    func request<Result: Codable, T: Codable> (_ resource: EndpointResurce, parameters: T? = nil, captchaToken: String? = "", encoding: ParameterEncoding = JSONEncoding.default, url: String = "") -> Promise<Result?> {
        let codableDictionary = try? DictionaryEncoder().encode(parameters) as? Parameters
        let headers = restClient.defaultHeader
  
        return createRequest(resource.route, method: resource.method, parameters: codableDictionary, encoding: encoding, headers: headers, interceptor: nil, url.isEmpty ? restClient.baseURL : url ).then { request in

            return Promise { seal in
                request.responseDecodable { (result: DataResponse<Result, AFError>) -> Void in
                    if let error = result.error {
                        print(error)
                        var customError = CustomError()
                        customError.statusCode = result.response?.statusCode ?? 500
                        if let data = result.data {
                            if let error = self.getCustomError(data){
                                customError = error
                                customError.statusCode = result.response?.statusCode ?? 500
                            }
                        }
                        seal.reject(customError)
                    } else {
                        seal.resolve(result.value, nil)
                    }
                }
            }
        }
    }

    func upload<Result: Codable>(_ resource: EndpointResurce, image: UIImage) -> Promise<Result> {
        return Promise { seal in
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(image.jpegData(compressionQuality: 0.7)!, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
                },
                to: restClient.baseURL + resource.route,
                method: resource.method,
                headers: restClient.defaultHeader, interceptor: self
            ).validate().uploadProgress(queue: .main, closure: { progress in
                // Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseDecodable { (result: DataResponse<Result, AFError>) -> Void in
                if let _ = result.error {
                    var customError = CustomError()
                    customError.statusCode = result.response?.statusCode ?? 500
                    if let data = result.data {
                        if let error = self.getCustomError(data){
                            customError = error
                            customError.statusCode = result.response?.statusCode ?? 500
                        }
                    }
                    seal.reject(customError)
                } else {
                    seal.resolve(result.value, nil)
                }
            }
        }
    }

    func requestString<T: Codable>(_ resource: EndpointResurce, parameters: T? = nil, captchaToken: String? = "", encoding: ParameterEncoding = JSONEncoding.default, url: String = "") -> Promise<String?> {
        let codableDictionary = try? DictionaryEncoder().encode(parameters) as? Parameters
        let headers = restClient.defaultHeader

        let promise = Promise<String?> { seal in

            if !NetworkMonitor.shared.isReachable {
                var customError = CustomError()
                customError.message = Constants.intenetError
                seal.reject(customError)
            } else {
                let baseURL = url.isEmpty ? restClient.baseURL :  url
                let urlReady = "\(baseURL.trimmingCharacters(in: .whitespacesAndNewlines))\(resource.route)"
                log.info(urlReady)
                let request =  AF.request(urlReady, method: resource.method, parameters: codableDictionary, encoding: encoding, headers: headers, interceptor: self).validate()

                request.response { response in
                    switch response.result {
                    case .success:
                        seal.resolve("OK", nil)
                    case .failure:
                        var customError = CustomError()
                        customError.statusCode = response.response?.statusCode ?? 500
                        self.log.error(String(describing: response))
                        if let data = response.data {
                            if let error = self.getCustomError(data){
                                customError = error
                                customError.statusCode = response.response?.statusCode  ?? 500
                            }
                        }
                        
                        seal.reject(customError)
                    }
                }
            }
        }
        return promise

    }
    
    func getCustomError(_ data: Data) -> CustomError? {
        do {
            let decoder = JSONDecoder()
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let jsonData = try JSONSerialization.data(withJSONObject: json)
                let  customError = try decoder.decode(CustomError.self, from: jsonData)
                return customError
            }
        } catch {
            self.log.error("Error al decoder CustomError")
        }
        return nil
    }

}
extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
