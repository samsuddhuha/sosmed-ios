//
//  HomeViewModel.swift
//  Sosmed
//
//  Created by Paxel on 06/05/22.
//

import Foundation
import SwiftyJSON

class HomeViewModel: NSObject {
    
    var showLoading: ((Bool) -> Void)?
    var showErrorAlert: ((String) -> Void)?
    var successGetPost: (([Post]) -> Void)?
    
    func getListPost() {
        self.showLoading?(true)
        CommonService.request(Common.listPost, completion: {result in switch result {
    
        case .success(let response):
            let data = JSON.init(response.data)
            
            do {
                _ = try response.filterSuccessfulStatusCodes()
                
                let dataMap = try JSONDecoder().decode([Post].self, from: data.rawData())
                self.successGetPost?(dataMap)
            } catch {
                self.showErrorAlert?(error.localizedDescription)
            }
            self.showLoading?(false)
        case .failure(let error):
            self.showErrorAlert?(error.localizedDescription)
            print(error)
            self.showLoading?(false)
        }})
    }
    
    func getCommentPost(id: Int) {
        self.showLoading?(true)
        CommonService.request(Common.commentPost(id: id), completion: {result in switch result {
        case .success(let response):
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()

//                let dataMap = try JSONDecoder().decode([Post].self, from: data.rawData())
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
