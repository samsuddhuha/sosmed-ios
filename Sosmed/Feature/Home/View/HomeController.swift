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
    @IBOutlet weak var viewEmpty: UIView!
    
    private var viewModel : HomeViewModel!
    
    let refresh = UIRefreshControl()
    var listPost = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.backButtonDisplayMode = .minimal
        title = "Home"
        setupView()
        setupViewModel()
    }
    
    private func setupView(){
        tablePost.delegate = self
        tablePost.dataSource = self
        tablePost.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        
        refresh.tintColor = UIColor.lightGray
        refresh.transform = CGAffineTransform(scaleX: 1, y: 1)
        tablePost.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupViewModel() {
        viewModel = HomeViewModel()
        
        showLoadingView(state: true)
        viewModel.getListPost()
        viewModel.showLoading = { isLoading in
            self.showLoadingView(state: isLoading)
        }
        
        viewModel.showErrorAlert = { error in
            let alert = UIAlertController(title: "Oops! Something went wrong.", message: error, preferredStyle:UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.viewEmpty.isHidden = false
            self.refresh.endRefreshing()
        }
        
        viewModel.successGetPost = { dataPosts in
            self.listPost.removeAll()
            self.listPost = dataPosts
            self.tablePost.reloadData()
            self.viewEmpty.isHidden = true
            self.refresh.endRefreshing()
        }
    }
    
    @IBAction func btnReloadPage(_ sender: Any) {
        viewModel.getListPost()
    }
    
    @objc func refreshData(){
        viewModel.getListPost()
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
