//
//  PostController.swift
//  Sosmed
//
//  Created by Paxel on 02/05/22.
//

import UIKit

class PostController: UIViewController {
    
    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Post Detail"
        print("Tess \(post.title)")
    }


}

