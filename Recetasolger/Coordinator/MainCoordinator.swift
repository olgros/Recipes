//
//  MainCoordinator.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import UIKit
class MainCoordinator: Coordinator {
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    let log  = Log(String(describing: MainCoordinator.self))

    init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

    func start() {
        goToMain()              
    }
    
    func goToMain() {
        let view  =  MainView.instantiate("Main")
        let useCase = RecipesUseCaseImp(repository:RecipesRepositoryImp())
        let viewModel  = MainViewModelImp(coordinator: self, recipesUseCase: useCase)
        view.viewModel = viewModel
        push(view)
    }
    
    func push(_ view: UIViewController) {
        navigationController.pushViewController(view, animated: true)
    }    
    
}


extension MainCoordinator: MainCoordiantorProtocol {
    func navigateToFavorites() {
        let favoritesCoordiantor = FavoritesCoordinator(navigationController: navigationController)
        favoritesCoordiantor.start()
    }
    
    func navigateToDetail(idRecipe: Int) {
        let view  =  DetailView.instantiate("Detail")
        let useCase = DetailUseCaseImp(repository: RecipesRepositoryImp())
        let viewModel  = DetailViewModelImp(coordinator: self, detailUseCase: useCase, idRecipe: idRecipe)
        view.viewModel = viewModel
        push(view)
    }    
}


extension MainCoordinator: DetailCoordiantorProtocol {    
    
}


extension MainCoordinator: CommonCoordiantorProtocol {
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
