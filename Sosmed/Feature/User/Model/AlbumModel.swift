//
//  AlbumModel.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation

struct Album: Decodable {
    let userId, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
    }
}
