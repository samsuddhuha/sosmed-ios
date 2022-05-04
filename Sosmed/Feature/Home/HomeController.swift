//
//  HomeController.swift
//  Sosmed
//
//  Created by Paxel on 03/05/22.
//

import Foundation
import UIKit


class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        title = "Home"
        setupView()
    }
    
    private func setupView(){
        
    }
    
    
    @IBAction func btnTes(_ sender: Any) {
        let viewController = PostController()
        viewController.titleToolbar = "Tess"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
