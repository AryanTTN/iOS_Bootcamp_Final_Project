//
//  MovieDataModel.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

struct HomeData {
    let sectionTitle: String?
    let movieData: [MovieData]?
}

struct MainData: Decodable {
//    let page: Int?
    let results: [MovieData]?
//    let total_pages, total_results: Int?
}

// MARK: - Result
struct MovieData: Decodable {
//    let adult: Bool?
//    let backdrop_path: String?
//    let genre_ids: [Int]?
//    let id: Int?
//    let original_language: String?
//    let original_title, overview: String?
//    let popularity: Double?
    let poster_path, release_date, title: String?
//    let video: Bool?
//    let vote_average, vote_count: Int?
}


