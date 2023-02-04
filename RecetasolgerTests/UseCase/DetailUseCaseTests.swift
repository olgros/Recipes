//
//  DetailUseCaseTests.swift
//  RecetasolgerTests
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import Foundation
import XCTest
import PromiseKit

@testable import Recetasolger

class DetailUseCaseTests: XCTestCase {

    let repository: RecipesRepository = RecipesRepositoryMockDetail()
    var  useCase: DetailUseCase?
    
    var expectation = XCTestExpectation(description: "DetailUseCaseTests")
           
    var recetaResponse: RecipeDetail?
    
    override func setUpWithError() throws {
        useCase = DetailUseCaseImp(repository: repository)
        useCase?.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    
    func testGetReceta() throws {
        let titleExpected = "receta1"
        let summaryExpected = "resumen1"
        let imageExpected = "imagen1"
                 
        useCase?.getRecipeDetail(1)
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(titleExpected, recetaResponse?.title, "error nombre")
        XCTAssertEqual(summaryExpected, recetaResponse?.summary, "error resumen")
        XCTAssertEqual(imageExpected, recetaResponse?.image, "error imagen")
        
    }
        
   

}

extension DetailUseCaseTests: DetailProtocol {
    func onSuccess(recipeDetail: RecipeDetail) {
        recetaResponse = recipeDetail
        expectation.fulfill()
    }
    
    func onError(title: String, message: String) {
        expectation.fulfill()
    }
    
}



class RecipesRepositoryMockDetail: RecipesRepository {
        
    func getDetailRecipe(id: Int) -> Promise <RecipeDetail?> {
        var recipe = RecipeDetail()
        recipe.id = 1
        recipe.title = "receta1"
        recipe.summary = "resumen1"
        recipe.image = "imagen1"
       
        var ingredients = [ExtendedIngredient]()
        
        var ingredient1 = ExtendedIngredient()
        ingredient1.id = 1
        ingredient1.name = "ingrediente1"
        ingredient1.originalName = "originalName1"
        ingredient1.amount = 10.0
        ingredient1.unit = "lb"
        
        ingredients.append(ingredient1)
        
        recipe.extendedIngredients = ingredients
        
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


