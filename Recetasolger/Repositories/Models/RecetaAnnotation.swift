//
//  RecetaAnotation.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import MapKit

class RecetaAnnotation: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

    init(receta: Receta){
        title = receta.name
        locationName = receta.name
        discipline = "Receta"
        
        let lat = Double(receta.ubication?.latitude ?? 0 )
        let lon = Double(receta.ubication?.longitude  ?? 0)
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        super.init()
    }
    
 
  var subtitle: String? {
    return locationName
  }
}
