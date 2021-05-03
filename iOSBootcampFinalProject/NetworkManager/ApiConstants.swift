//
//  ApiConstants.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

enum ApiConstants {
    
    case home(genre)
    case user
    
    enum genre: String, CaseIterable {
        
        case banner = "Banner"
        case popularity = "Popularity"
        case bestDrama = "Best Drama"
        case kidsMovies = "Kids Movies"
        case bestMovies = "Best Movies"
        
    }
    var finalUrl: String{
        return baseUrl + endUrl + apiKey
    }
    
    var baseUrl: String {
        switch self {
        case .home(_):
            return "https://api.themoviedb.org/3/"
        case .user:
            return ""
        
        }
    }
    var endUrl: String {
        switch self {
        case .home(let genre):
            switch  genre {
            case .banner:
                return "trending/movie/day?"
            case .popularity:
                return "discover/movie?sort_by=popularity.desc"
            case .bestDrama:
                return "discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10"
            case .kidsMovies:
                return "discover/movie?certification_country=US&certification.lte=G&sort_by=vote_average.desc"
            case .bestMovies:
                return "discover/movie?primary_release_year=2010&sort_by=vote_average.desc"
            }
        case .user:
            return ""
        
        }
    }
    var apiKey: String {
        
        switch self {
        case .home(_):
            return "&api_key=820016b7116f872f5f27bf56f9fdfb66"
        case .user:
            return ""
        
        }
    }
}
