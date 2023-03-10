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

    let repository: RecipesRepository = RecipesRepositoryMainMock()
    var viewModel: MainViewModelImp?
    var  useCase: RecipesUseCase!
    var expectation = XCTestExpectation(description: "MainViewModelTests")
    
    let statusExpected = "OK"    
        
    var nameResponse = ""
    var descriptionResponse = ""
    var ingredientesResponse = ""
    
    var recipesResponse: Recipe?
    
    override func setUpWithError() throws {       
        useCase = RecipesUseCaseImp(repository: repository)
        
        viewModel = MainViewModelImp(coordinator: self, recipesUseCase: useCase)
        viewModel?.recipesUseCase?.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() throws {
        
        let titleExpected = "receta1"
        let imagenExpected = "imagen1"
        
        viewModel?.viewDidLoad()
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(2, recipesResponse?.totalResults ?? 0, "Se espeeraban 2 resultados" )
        XCTAssertEqual(titleExpected, recipesResponse?.results[0].title, "se esperaba receta1")
        XCTAssertEqual(imagenExpected, recipesResponse?.results[0].image, "se esperaaba imagen1")
    }
    
    func testGetRecetas() throws {
        let titleExpected = "receta1"
        let imagenExpected = "imagen1"
        
        viewModel?.getRecipes(query: "receta1")
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(2, recipesResponse?.totalResults ?? 0, "Se espeeraban 2 resultados" )
        XCTAssertEqual(titleExpected, recipesResponse?.results[0].title, "se esperaba receta1")
        XCTAssertEqual(imagenExpected, recipesResponse?.results[0].image, "se esperaaba imagen1")
        
    }
                

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension MainViewModelTests: RecipesProtocol {
    func onSuccess(recipes: Recipe?) {
        recipesResponse = recipes
        expectation.fulfill()
    }
       
    func onError(title: String, message: String) {
        expectation.fulfill()
    }
    
}

extension MainViewModelTests: MainCoordiantorProtocol {
    func navigateToFavorites() {
    }
    
    func navigateToDetail(idRecipe: Int) {
        
    }
    
    func onShowAlertMessage(title: String?, message: String?) {
        
    }
    
    func navigateToRoot() {
        
    }
    
    func onBack() {
        
    }
    
}

class RecipesRepositoryMainMock: RecipesRepository {
        
    func getDetailRecipe(id: Int) -> Promise <RecipeDetail?> {
        let recipe = RecipeDetail()
        return Promise { seal in
            seal.resolve(recipe, nil)
        }
    }
    
    func saveFavorite(recipeDetailModel: RecipeDetailModel)  -> Bool {
        return true
    }
    
    func getRecipes(query: String) -> Promise <Recipe?> {
        return Promise { seal in
                        
            var result = [ResultRecipe]()
            
            result.append(ResultRecipe(id: 1, title: "receta1", image: "imagen1", imageType: "jpg"))
            result.append(ResultRecipe(id: 2, title: "receta2", image: "imagen2", imageType: "jpg"))
            
            let recipe = Recipe(results: result, offset: 0, number: 2, totalResults: 2)
                       
            
            seal.resolve(recipe, nil)
        }
    }
    
}



