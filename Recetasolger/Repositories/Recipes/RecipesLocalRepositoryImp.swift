//
//  RecetasLocalRepositoryImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 31/01/23.
//

import Foundation
import PromiseKit
import RealmSwift

class RecipesLocalRepositoryImp: RecipesRepository {
    func getDetailRecipe(id: Int) -> Promise<RecipeDetail?> {
        return Promise { seal in
                        
            let realm = try! Realm()
            let recipesObjs = realm.objects(RecipeDetailModel.self)
            
            let currentRecipe = recipesObjs.where {
                $0.idRecipe == id
            }
            
            if currentRecipe.count > 0 {
                let recipeDetail =  RecipeDetail(recipeDetailModel: currentRecipe.first!)
                seal.resolve(recipeDetail, nil)
            }else{
                seal.resolve(RecipeDetail(), nil)
            }
             
        }
    }
        
    func getRecipes(query: String) -> Promise<Recipe?> {
       
        return Promise { seal in
            let realm = try! Realm()
            let recipesDetail = realm.objects(RecipeDetailModel.self)
            
            var recipe: Recipe?

            var resultsRecipes = [ResultRecipe]()
            for item in recipesDetail {
                resultsRecipes.append(ResultRecipe(id: item.idRecipe, title: item.title, image: item.image, imageType: "jpg"))               
            }
            recipe = Recipe(results: resultsRecipes, offset: 0, number:  recipesDetail.count, totalResults: recipesDetail.count)
            
            
             seal.resolve(recipe, nil)
        }        
    }
    
    func saveFavorite(recipeDetailModel: RecipeDetailModel) -> Bool{
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(recipeDetailModel)
        }
        
        return true
    }
}
