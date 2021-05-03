//
//  HomeViewModel.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var homeApiData: [HomeData] = []
    
    func fetchHomeApiData(completion: @escaping (Bool,String) -> Void){
        
        homeApiData.removeAll()
        for genre in ApiConstants.genre.allCases {
            NetworkManager().fetchTheMovieDBData(urlType: .home(genre)) { (result) in
                switch result{
                case .success(let data):
                    if genre == .banner {
                        self.homeApiData.insert(HomeData(sectionTitle: genre.rawValue, movieData: data.results), at: 0)
                    } else {
                        self.homeApiData.append(HomeData(sectionTitle: genre.rawValue, movieData: data.results))
                    }
                    completion(true, "")
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
}
