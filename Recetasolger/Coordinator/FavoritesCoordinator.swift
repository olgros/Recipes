//
//  LocalCoordinator.swift
//  Recetasolger
//
//  Created by Olger Rosero on 4/02/23.
//

import Foundation
import UIKit
class FavoritesCoordinator: Coordinator {
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    let log  = Log(String(describing: FavoritesCoordinator.self))

    init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

    func start() {
        goToFavorites()       
    }
    
    func goToFavorites() {
        let view  =  MainView.instantiate("Main")
        let useCase = RecipesUseCaseImp(repository: RecipesLocalRepositoryImp())
        let viewModel  = MainViewModelImp(coordinator: self, recipesUseCase: useCase)
        view.viewModel = viewModel
        push(view)
    }
    func push(_ view: UIViewController) {
        navigationController.pushViewController(view, animated: true)
    }
}


extension FavoritesCoordinator: MainCoordiantorProtocol {
    func navigateToFavorites() {        

    }
    
    func navigateToDetail(idRecipe: Int) {
        let view  =  DetailView.instantiate("Detail")
        let useCase = DetailUseCaseImp(repository: RecipesLocalRepositoryImp())
        let viewModel  = DetailViewModelImp(coordinator: self, detailUseCase: useCase, idRecipe: idRecipe)
        view.viewModel = viewModel
        push(view)
       
    }
}

extension FavoritesCoordinator: DetailCoordiantorProtocol {
    
}

extension FavoritesCoordinator: CommonCoordiantorProtocol {
    func onShowAlertMessage(title: String?, message: String?) {
        guard let title = title else { return }
        guard let message = message else { return }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        
        self.navigationController.present(alertController, animated: true, completion: nil)
        
    }
    func navigateToRoot(){
        self.navigationController.popToRootViewController(animated: true)
    }
    func onBack(){
        self.navigationController.popViewController(animated: true)
    }
}
