//
//  NetworkManager.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

class NetworkManager {
    
    
    func fetchTheMovieDBData(urlType: ApiConstants, completion: @escaping (Result<MainData,Error>) -> Void){
        let url = URL(string: urlType.finalUrl)!
        APICall().request(url, for: MainData.self) {
            completion($0)
        }
    }
    
    func fetchUserData(urlType: ApiConstants, completion: @escaping (Result<[Int],Error>) -> Void){
        let url = URL(string: urlType.finalUrl)!
        APICall().request(url, for: [Int].self) {
            completion($0)
        }
    }
}
