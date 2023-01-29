//
//  BaseViewController.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import UIKit
class BaseViewController: UIViewController, Storyboarded {
    let DESTROY = "destroy"
    let log  = Log(String(describing: "RECETAS APP"))
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeBackText()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !NetworkMonitor.shared.isReachable {
            onShowAlertMessage(title: "", message: Constants.intenetError)
        }
    }

    func onShowAlertMessage( title: String?, message: String?) {
        guard let title = title else { return }
        guard let message = message else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func addBackButtonItem() {
        let item = UIBarButtonItem(title: "Atrás", style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = item
    }
    
    func hideNavigationBar(){
        navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar(){
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func back() {
       self.dismiss(animated: true)
    }

    func changeBackText() {
        let backButton = UIBarButtonItem()
        backButton.title = "Atrás"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
     
    }

    func setTabletZero(_ tableView: UITableView) {
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
    }

    func registerCell(_ tableView: UITableView, nibName: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }

    func addBlurEffect() {
        // 1
        view.backgroundColor = .clear
        // 2
        let blurEffect = UIBlurEffect(style: .light)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)

        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: view.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
  
}
