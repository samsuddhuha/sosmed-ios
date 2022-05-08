//
//  PostController.swift
//  Sosmed
//
//  Created by Paxel on 02/05/22.
//

import UIKit

class PostController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBody: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelComment: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var tableComment: UITableView!
    
    private var userViewModel : UserViewModel!
    private var postViewModel : PostViewModel!
    
    var post: Post!
    var listComment = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Post Detail"
        setupView()
        setupViewModel()
    }
    
    private func setupView(){
        labelBody.text = post.body
        labelTitle.text = post.title
        
        tableComment.delegate = self
        tableComment.dataSource = self
        tableComment.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    }
    
    private func setupViewModel(){
        userViewModel = UserViewModel()
        postViewModel = PostViewModel()
        userViewModel.getUserDetail(id: post.userId)
        userViewModel.successUserDetail = { dataUser in
            self.labelName.text = dataUser.name
            self.labelCompany.text = "Company: \(dataUser.company.name)"
        }
        
        showLoadingView(state: true)
        postViewModel.getCommentPost(id: post.id)
        postViewModel.successGetComment = { dataComment in
            self.listComment.removeAll()
            self.listComment = dataComment
            self.labelComment.text = "\(self.listComment.count) Comments"
            self.tableComment.reloadData()
        }
        postViewModel.showLoading = { isLoading in
            self.showLoadingView(state: isLoading)
        }
        postViewModel.showErrorAlert = { error in
            let alert = UIAlertController(title: "Oops! Something went wrong.", message: error, preferredStyle:UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func toUserDetail(_ sender: Any) {
        
    }

}

extension PostController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableComment.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let dataComment = listComment[indexPath.row]
        cell.setupViewCell(dataComment: dataComment)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataComment = listComment[indexPath.row]
        
    }
}

