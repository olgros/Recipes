//
//  ExtendedIngredientModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 4/02/23.
//

import Foundation
import RealmSwift
class IngredientModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var originalName: String
    @Persisted var amount: Double
    @Persisted var unit: String
     
    convenience init(extendedIngredient: ExtendedIngredient  ) {
        self.init()        
        self.name = extendedIngredient.name ?? ""
        self.originalName = extendedIngredient.originalName ?? ""
        self.amount = extendedIngredient.amount
        self.unit = extendedIngredient.unit
   }
}
