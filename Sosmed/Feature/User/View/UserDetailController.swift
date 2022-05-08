//
//  UserDetailController.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation
import UIKit


class UserDetailController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var tableAlbum: UITableView!
    
    private var viewModel : UserViewModel!
    
    var userId: Int!
    var listAlbum = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Detail"
        setupView()
        setupViewModel()
    }
    
    private func setupView(){
        tableAlbum.dataSource = self
        tableAlbum.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        
    }
    
    private func setupViewModel(){
        viewModel = UserViewModel()
        viewModel.getUserDetail(id: userId)
        showLoadingView(state: true)
        viewModel.getUserAlbums(id: userId)
        
        viewModel.successUserDetail = { dataUser in
            self.labelName.text = dataUser.name
            self.labelEmail.text = dataUser.email
            self.labelAddress.text = "\(dataUser.address.street), \(dataUser.address.city)"
            self.labelCompany.text = dataUser.company.name
        }
        
        viewModel.successListAlbums = { dataAlbums in
            self.listAlbum.removeAll()
            self.listAlbum = dataAlbums
            self.tableAlbum.reloadData()
        }
        
        viewModel.showLoading = { isLoading in
            self.showLoadingView(state: isLoading)
        }
        viewModel.showErrorAlert = { error in
            let alert = UIAlertController(title: "Oops! Something went wrong.", message: error, preferredStyle:UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
}

extension UserDetailController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableAlbum.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumCell
        let dataAlbum = listAlbum[indexPath.row]
        cell.setupViewCell(dataAlbum: dataAlbum)
    
        return cell
    }
}
