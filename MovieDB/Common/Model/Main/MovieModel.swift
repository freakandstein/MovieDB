//
//  MovieModel.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

struct MovieModel: Codable {
    let page: Int
    let results: [MovieDetailModel]
    let totalPage: Int
    let totalResult: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPage = "total_page"
        case totalResult = "total_result"
    }
    
}

struct MovieDetailModel: Codable {
    let id: Int
    let overview: String
    let title: String
    let posterPath: String
    let backdropPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
