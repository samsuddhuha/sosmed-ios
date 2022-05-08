//
//  CommentModel.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation


struct Comment: Decodable {
    let id, postId : Int
    let name, body: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case postId = "postId"
        case name = "name"
        case body = "body"
    }
}
