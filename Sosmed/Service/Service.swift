//
//  Service.swift
//  Sosmed
//
//  Created by Paxel on 06/05/22.
//

import Foundation
import Moya
import SwiftyJSON

enum Common: Equatable {
    case listPost
    case commentPost(id: Int)
    case userDetail(id: Int)
    case userAlbums(id: Int)
    case albumPhotos(id: Int)
}

let commonClosure = { (target: Common) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    switch target {
    case .listPost, .commentPost, .userDetail, .userAlbums, .albumPhotos:
        return defaultEndpoint
    }
}

let CommonService = MoyaProvider<Common>(endpointClosure: commonClosure)

extension Common: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .listPost:
            return "/posts"
        case .commentPost(let id):
            return "/posts/\(id)/comments"
        case .userDetail(let id):
            return "/users/\(id)"
        case .userAlbums(let id):
            return "/users/\(id)/albums"
        case .albumPhotos(let id):
            return "/albums/\(id)/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listPost, .commentPost, .userDetail, .userAlbums, .albumPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var data = [String:Any]()
        
        switch self {
        case .listPost, .commentPost , .userDetail, .userAlbums, .albumPhotos:
            return .requestParameters(parameters: data, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

