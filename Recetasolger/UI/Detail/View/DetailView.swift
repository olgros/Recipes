//
//  DetailView.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift
import AlamofireImage
import UIKit

class DetailView: BaseViewController {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var viewModel: DetailViewModel?
    let disposeBag = DisposeBag()
    var recipeDetail: RecipeDetail?
    var IMAGE_VIEW_CELL = "ImageViewCell"
    var SUMMARY_VIEW_CELL = "SummaryViewCell"
    var INGREDIENTS_VIEW_CELL = "IngredientViewCell"
    var TITLE_VIEW_CELL = "TitleViewCell"
    
    
    var NUM_CELL = 3
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addObserverReceta()
        initTable()
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
            title = "Mis favoritos"
            btnFavorite.isHidden = true
        }else{
            title = "Recetas"
        }
    }
    
    
    func initTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: IMAGE_VIEW_CELL, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: IMAGE_VIEW_CELL)
        
        let nibSummary = UINib(nibName: SUMMARY_VIEW_CELL, bundle: nil)
        tableView.register(nibSummary, forCellReuseIdentifier: SUMMARY_VIEW_CELL)
       
        let nibIngredients = UINib(nibName: INGREDIENTS_VIEW_CELL, bundle: nil)
        tableView.register(nibIngredients, forCellReuseIdentifier: INGREDIENTS_VIEW_CELL)
        
        let nibTitle = UINib(nibName: TITLE_VIEW_CELL, bundle: nil)
        tableView.register(nibTitle, forCellReuseIdentifier: TITLE_VIEW_CELL)
        
    }
     
    func addObserverReceta() {
        viewModel?.recipeResponse.subscribe(onNext: { [weak self] recipeDetail in
            self?.recipeDetail = recipeDetail
            self?.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }
       
    deinit {
        log.info(DESTROY)
    }
    
    @IBAction func onSaveFavorite(_ sender: Any){
        viewModel?.saveFavorite(recipeDetail: recipeDetail)        
    }
}


extension DetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ?  NUM_CELL :  (recipeDetail?.extendedIngredients?.count ?? 0)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            switch(indexPath.row){
              
            case 0:
                let cellView = tableView.dequeueReusableCell(withIdentifier: TITLE_VIEW_CELL, for: indexPath)
                if let cell = cellView as? TitleViewCell {
                    cell.title =  recipeDetail?.title
                    cell.selectionStyle = .none
                    return cell
                }
            case 1:
                let cellView = tableView.dequeueReusableCell(withIdentifier: IMAGE_VIEW_CELL, for: indexPath)
                if let cell = cellView as? ImageViewCell {
                    cell.urlImage =  recipeDetail?.image
                    cell.selectionStyle = .none
                    return cell
                }
            case 2:
                let cellView = tableView.dequeueReusableCell(withIdentifier: SUMMARY_VIEW_CELL, for: indexPath)
                if let cell = cellView as? SummaryViewCell {
                    cell.summary =  recipeDetail?.summary
                    cell.selectionStyle = .none
                    return cell
                }
            default:
                return UITableViewCell()
            }
        }else{
            let cellView = tableView.dequeueReusableCell(withIdentifier: INGREDIENTS_VIEW_CELL, for: indexPath)
            if let cell = cellView as? IngredientViewCell {
                cell.ingredient =  recipeDetail?.extendedIngredients?[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "" : "Ingredients"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
