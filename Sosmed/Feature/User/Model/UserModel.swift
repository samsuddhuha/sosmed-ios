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
    let address: Address

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case company = "company"
        case address = "address"
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

struct Address: Decodable {
    let street, city, suite, zipcode: String

    enum CodingKeys: String, CodingKey {
        case street = "street"
        case city = "city"
        case suite = "suite"
        case zipcode = "zipcode"
    }
}
