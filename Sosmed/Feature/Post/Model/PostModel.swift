//
//  PostModel.swift
//  Sosmed
//
//  Created by Paxel on 06/05/22.
//

import Foundation


struct Post: Decodable {
    let id, userId: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "userId"
        case title = "title"
        case body = "body"
    }
}
