//
//  MainView.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import UIKit
import RxSwift
import RealmSwift

class MainView: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var svSearch: UIStackView!
    
    var viewModel: MainViewModel?
    let disposeBag = DisposeBag()
    var recipesList = [ResultRecipe]()
    var VIEW_CELL = "RecetaTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        addObserverRecetas()
        viewModel?.viewDidLoad()
        initControls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
    
    func initControls(){
        if viewModel?.isFavorite() ?? false {
            title = "Mis Favoritos"
            svSearch.isHidden = true
        }else{            
            addFavoritesButtonItem()
        }
    }
    
    func initTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: VIEW_CELL, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: VIEW_CELL)
    }
    
    func addObserverRecetas() {
        viewModel?.recetasResponse.subscribe(onNext: { [weak self] recipe in
            self?.recipesList.removeAll()
            self?.recipesList.append(contentsOf: recipe.results)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
       
    deinit {
        log.info(DESTROY)
    }
    
    
    func addFavoritesButtonItem() {
        let item = UIBarButtonItem(title: "Favoritos", style: .plain, target: self, action: #selector(onFavorite))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc func onFavorite() {
        viewModel?.navigateToFavorites()
    }
    
    @IBAction func onSearch(_ sender: Any){
        viewModel?.searchRecipes(value: txtSearch.text!)
    }
    
}


extension MainView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCell(withIdentifier: VIEW_CELL, for: indexPath)
        if let cell = cellView as? RecetaTableViewCell {
            cell.resultRecipe =  recipesList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe =  recipesList[indexPath.row]   
        viewModel?.naviteToDetail(idRecipe: recipe.id)

    }
}
