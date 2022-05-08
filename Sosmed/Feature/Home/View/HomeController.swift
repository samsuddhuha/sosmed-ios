//
//  HomeController.swift
//  Sosmed
//
//  Created by Paxel on 03/05/22.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var tablePost: UITableView!
    
    private var viewModel : HomeViewModel!
    
    var listPost = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        title = "Home"
        setupView()
        setupViewModel()
    }
    
    private func setupView(){
        tablePost.delegate = self
        tablePost.dataSource = self
        tablePost.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }
    
    private func setupViewModel() {
        viewModel = HomeViewModel()
        viewModel.getListPost()
        showLoadingView(state: true)
        viewModel.showLoading = { isLoading in
            self.showLoadingView(state: isLoading)
        }
        
        viewModel.showErrorAlert = { error in
            let alert = UIAlertController(title: "Oops! Something went wrong.", message: error, preferredStyle:UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        viewModel.successGetPost = { dataPost in
            self.listPost.removeAll()
            self.listPost = dataPost
            self.tablePost.reloadData()
        }
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePost.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        let dataPost = listPost[indexPath.row]
        cell.setupViewCell(dataPost: dataPost)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataPost = listPost[indexPath.row]
        
        let viewController = PostController()
        viewController.post = dataPost
        navigationController?.pushViewController(viewController, animated: true)
    }
}
