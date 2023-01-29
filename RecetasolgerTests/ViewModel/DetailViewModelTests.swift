//
//  DetailViewModelTests.swift
//  RecetasolgerTests
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import XCTest
import PromiseKit

@testable import Recetasolger

class DetailViewModelTests: XCTestCase {

    let repository: DetailRepository = DetailRepositoryImp()
    var viewModel: DetailViewModelImp?
    var  useCase: DetailUseCase!
    
    var expectation = XCTestExpectation(description: "DetailViewModelTests")
        
        
    
    
    var recetaResponse = Receta()
    
    override func setUpWithError() throws {
        useCase = DetailUseCaseImp(repository: repository)
        
        viewModel = DetailViewModelImp(coordinator: self, detailUseCase: useCase, idReceta: 1)
        viewModel?.detailUseCase?.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    
    func testGetReceta() throws {
        let nameExpected = "receta1"
        let descriptionExpected = "description1"
        let ingredientesExpected = "ingredientes1"
        
        var recetas = [Receta]()
        recetas.append(Receta(id: 1, name: "receta1", image: "url", description: "description1", ubication: Ubication(latitude: 0, longitude: 0), ingredientes: "ingredientes1"))
        RecetaData.shared.recetas = recetas
        
        viewModel?.getReceta(1)
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(nameExpected, recetaResponse.name, "error nombre")
        XCTAssertEqual(descriptionExpected, recetaResponse.description, "error description")
        XCTAssertEqual(ingredientesExpected, recetaResponse.ingredientes, "error ingredientes")
        
    }
        
   

}

extension DetailViewModelTests: DetailProtocol {
    func onSuccess(receta: Receta) {
        recetaResponse = receta
        expectation.fulfill()
    }
    
    func onError(title: String, message: String) {
        expectation.fulfill()
    }
    
}

extension DetailViewModelTests: DetailCoordiantorProtocol {
    
    func navigateToMap(receta: Receta){
        
    }
    func onShowAlertMessage(title: String?, message: String?) {
        
    }
    
    func navigateToRoot() {
        
    }
    
    func onBack() {
        
    }
    
}


