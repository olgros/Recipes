//
//  DetailView.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift
import AlamofireImage

class DetailView: BaseViewController {
       
    @IBOutlet weak var imageReceta: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientesLabel: UILabel!
    
    
    var viewModel: DetailViewModel?
    let disposeBag = DisposeBag()
    var receta: Receta?
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addObserverReceta()
        viewModel?.viewDidLoad()
    }
     
    func addObserverReceta() {
        viewModel?.recetaResponse.subscribe(onNext: { [weak self] receta in
            self?.receta = receta
            self?.title = receta.name
            self?.descriptionLabel.text = receta.description
            self?.ingredientesLabel.text = receta.ingredientes
                     
            guard  let urlImage = receta.image else { return }
            guard let url = URL(string: urlImage ) else { return }

            
            let placeholderImage = UIImage(named: "placeholder")!

            guard let uiImage = self?.imageReceta else { return }
            
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: uiImage.frame.size,
                radius: 20.0
            )

            uiImage.af.setImage(
                withURL: url,
                placeholderImage: placeholderImage,
                filter: filter
            )
            
        }).disposed(by: disposeBag)
    }
       
    deinit {
        log.info(DESTROY)
    }
    
    @IBAction func onNavigateToMap(_ sender: Any){
        viewModel?.navigateToMap(receta: receta)
    }
}
