//
//  UserViewModel.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation
import SwiftyJSON

class UserViewModel: NSObject {
    
    var showLoading: ((Bool) -> Void)?
    var showErrorAlert: ((String) -> Void)?
    var successUserDetail: ((User) -> Void)?
    var successListAlbums: (([Album]) -> Void)?
    var successListPhoto: (([Photo]) -> Void)?
    
    func getUserDetail(id: Int) {
        self.showLoading?(true)
        CommonService.request(Common.userDetail(id: id), completion: {result in switch result {
        case .success(let response):
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()

                let dataMap = try JSONDecoder().decode(User.self, from: data.rawData())
                self.successUserDetail?(dataMap)
            } catch {
                self.showErrorAlert?(error.localizedDescription)
            }
            self.showLoading?(false)
        case .failure(let error):
            self.showErrorAlert?(error.localizedDescription)
            self.showLoading?(false)
        }})
    }
    
    
    func getUserAlbums(id: Int) {
        self.showLoading?(true)
        CommonService.request(Common.userAlbums(id: id), completion: {result in switch result {
        case .success(let response):
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()

                let dataMap = try JSONDecoder().decode([Album].self, from: data.rawData())
                self.successListAlbums?(dataMap)
            } catch {
                self.showErrorAlert?(error.localizedDescription)
            }
            self.showLoading?(false)
        case .failure(let error):
            self.showErrorAlert?(error.localizedDescription)
            self.showLoading?(false)
        }})
    }
    
    func getAlbumPhotos(id: Int) {
        self.showLoading?(true)
        CommonService.request(Common.albumPhotos(id: id), completion: {result in switch result {
        case .success(let response):
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()

                let dataMap = try JSONDecoder().decode([Photo].self, from: data.rawData())
                self.successListPhoto?(dataMap)
            } catch {
                self.showErrorAlert?(error.localizedDescription)
            }
            self.showLoading?(false)
        case .failure(let error):
            self.showErrorAlert?(error.localizedDescription)
            self.showLoading?(false)
        }})
    }

}
