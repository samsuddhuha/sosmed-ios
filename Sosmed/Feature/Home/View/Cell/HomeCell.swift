//
//  HomeCell.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBody: UILabel!
    
    private var viewModel : UserViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewModel()
    }
    
    func setupViewModel(){
        viewModel = UserViewModel()
        viewModel.successUserDetail = { dataUser in
            self.labelName.text = dataUser.name
            self.labelCompany.text = "Company: \(dataUser.company.name)"
        }
    }
    
    func setupViewCell(dataPost: Post) {
        labelTitle.text = dataPost.title
        labelBody.text = dataPost.body
        viewModel.getUserDetail(id: dataPost.userId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
