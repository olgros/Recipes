//
//  RecetasRepositoryImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import PromiseKit
import RealmSwift
class RecipesRepositoryImp: RecipesRepository {
    
    func getRecipes(query: String) -> Promise<Recipe?> {
        return NetworkManager.shared.request(EndPoint.recipes(query).resource)
    }
    
    func getDetailRecipe(id: Int) -> Promise<RecipeDetail?> {
        return NetworkManager.shared.request(EndPoint.detail(id).resource)
    }
    func saveFavorite(recipeDetailModel: RecipeDetailModel) -> Bool{
        let realm = try! Realm()
        
        let recipesObjs = realm.objects(RecipeDetailModel.self)
        
        let currentRecipe = recipesObjs.where {
            $0.idRecipe == recipeDetailModel.idRecipe
        }
        
        if currentRecipe.count ==  0 {
            try! realm.write {
                realm.add(recipeDetailModel)
               
            }
            return true
        }
        return false
    }
}
