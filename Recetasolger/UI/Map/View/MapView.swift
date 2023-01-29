//
//  MapView.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift
import MapKit

class MapView: BaseViewController {
       
    @IBOutlet weak var map: MKMapView!
               
    var viewModel: MapViewModel?
    let disposeBag = DisposeBag()
         
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addObserverAnnotation()
        viewModel?.viewDidLoad()
       
    }
     
    func addObserverAnnotation() {
        viewModel?.recetaResponse.subscribe(onNext: { [weak self] annotation in
            let initialLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
           // self?.map.centerToLocation(initialLocation)
            self?.map.addAnnotation(annotation)
            self?.zoomCamera(location: initialLocation)
            self?.title = annotation.title
            
        }).disposed(by: disposeBag)
    }
       
    deinit {
        log.info(DESTROY)
    }
    
    func zoomCamera(location: CLLocation){
       // let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
            let region = MKCoordinateRegion(
              center: location.coordinate,
              latitudinalMeters: 5000,
              longitudinalMeters: 6000)
            map.setCameraBoundary(
              MKMapView.CameraBoundary(coordinateRegion: region),
              animated: true)
            
            let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        map.setCameraZoomRange(zoomRange, animated: true)
    }
}


private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
