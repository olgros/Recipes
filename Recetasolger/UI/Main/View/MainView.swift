//
//  MainView.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import UIKit
import RxSwift

class MainView: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: MainViewModel?
    let disposeBag = DisposeBag()
    var recetasList = [Receta]()
    var VIEW_CELL = "RecetaTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        addObserverRecetas()
        viewModel?.viewDidLoad()
        searchBar.delegate = self
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
        viewModel?.recetasResponse.subscribe(onNext: { [weak self] recetas in
            self?.recetasList.removeAll()
            self?.recetasList.append(contentsOf: recetas)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
       
    deinit {
        log.info(DESTROY)
    }
}


extension MainView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetasList.count
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
            cell.receta =  recetasList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let receta =  recetasList[indexPath.row]
        guard let id = receta.id else { return }
        viewModel?.naviteToDetail(idReceta: id)

    }
}


extension MainView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        viewModel?.searchRecetas(value: searchText)
    }
}
