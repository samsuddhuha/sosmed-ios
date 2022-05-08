//
//  UserModel.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name, username, email: String
    let company: Company

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case company = "company"
    }
}

struct Company: Decodable {
    let name, catchPhrase, bs: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}
