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
}

let commonClosure = { (target: Common) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    switch target {
    case .listPost, .commentPost, .userDetail:
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listPost, .commentPost, .userDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var data = [String:Any]()
        
        switch self {
        case .listPost, .commentPost , .userDetail:
            return .requestParameters(parameters: data, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

