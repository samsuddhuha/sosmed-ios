//
//  PhotoModel.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation

struct Photo: Decodable {
    let albumId, id: Int
    let title, url, thumbnailUrl: String

    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}
