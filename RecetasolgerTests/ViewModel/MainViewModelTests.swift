//
//  MainViewModelTest.swift
//  RecetasolgerTests
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import XCTest
import PromiseKit

@testable import Recetasolger

class MainViewModelTests: XCTestCase {

    let repository: RecetasRepository = RecetasRepositoryMock()
    var viewModel: MainViewModelImp?
    var  useCase: RecetasUseCase!
    var expectation = XCTestExpectation(description: "MainViewModelTests")
    
    let statusExpected = "OK"    
        
    var nameResponse = ""
    var descriptionResponse = ""
    var ingredientesResponse = ""
    
    var recetasResponse = [Receta]()
    
    override func setUpWithError() throws {       
        useCase = RecetasUseCaseImp(repository: repository, repositoryLocal: repository)
        
        viewModel = MainViewModelImp(coordinator: self, recetasUseCase: useCase)
        viewModel?.recetasUseCase?.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() throws {
        let nameExpected = "receta1"
        let descriptionExpected = "description1"
        let ingredientesExpected = "ingredientes1"
        
        viewModel?.viewDidLoad()
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(nameExpected, recetasResponse[0].name, "error nombre")
        XCTAssertEqual(descriptionExpected, recetasResponse[0].description, "error description")
        XCTAssertEqual(ingredientesExpected, recetasResponse[0].ingredientes, "error ingredientes")
        
    }
    
    func testGetRecetas() throws {
        let nameExpected = "receta1"
        let descriptionExpected = "description1"
        let ingredientesExpected = "ingredientes1"
        
        viewModel?.getRecetas()
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(nameExpected, recetasResponse[0].name, "error nombre")
        XCTAssertEqual(descriptionExpected, recetasResponse[0].description, "error description")
        XCTAssertEqual(ingredientesExpected, recetasResponse[0].ingredientes, "error ingredientes")
        
    }
    
    func testSearchIngredienteRecetas() throws {
        
        let nameExpected2 = "receta2"
        let descriptionExpected2 = "description2"
        let ingredientesExpected2 = "ingredientes2"
        
        viewModel?.searchRecetas(value: "ingredientes2")
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        
        XCTAssertEqual(nameExpected2, recetasResponse[0].name, "error nombre")
        XCTAssertEqual(descriptionExpected2, recetasResponse[0].description, "error description")
        XCTAssertEqual(ingredientesExpected2, recetasResponse[0].ingredientes, "error ingredientes")
        
    }
    
    func testSearchNameRecetas() throws {
        
        let nameExpected2 = "receta2"
        let descriptionExpected2 = "description2"
        let ingredientesExpected2 = "ingredientes2"
        
        viewModel?.searchRecetas(value: "receta2")
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        
        XCTAssertEqual(nameExpected2, recetasResponse[0].name, "error nombre")
        XCTAssertEqual(descriptionExpected2, recetasResponse[0].description, "error description")
        XCTAssertEqual(ingredientesExpected2, recetasResponse[0].ingredientes, "error ingredientes")
        
    }

    func testSearchAll() throws {
            
        let totalexpected = 2
        viewModel?.searchRecetas(value: "")
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(totalexpected, recetasResponse.count, "error nombre")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension MainViewModelTests: RecetasProtocol {
    func onSuccess(recetas: [Receta]) {
        recetasResponse = recetas
        expectation.fulfill()
    }
    
    func onError(title: String, message: String) {
        expectation.fulfill()
    }
    
}

extension MainViewModelTests: MainCoordiantorProtocol {
    func navigateToDetail(idReceta: Int) {
        
    }
    
    func onShowAlertMessage(title: String?, message: String?) {
        
    }
    
    func navigateToRoot() {
        
    }
    
    func onBack() {
        
    }
    
}

class RecetasRepositoryMock: RecetasRepository {
    func getRecetas() -> Promise<[Receta]> {
        return Promise { seal in
            var recetas = [Receta]()
            recetas.append(Receta(id: 1, name: "receta1", image: "url", description: "description1", ubication: Ubication(latitude: 0, longitude: 0), ingredientes: "ingredientes1"))
            recetas.append(Receta(id: 2, name: "receta2", image: "url", description: "description2", ubication: Ubication(latitude: 0, longitude: 0), ingredientes: "ingredientes2"))
            
            seal.resolve(recetas, nil)
        }
    }
}

