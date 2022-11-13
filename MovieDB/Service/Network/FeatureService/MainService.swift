//
//  MainService.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import Moya

enum MainService {
    case getUpcomingMovie(page: Int)
    case getPopularMovie(page: Int)
    case getNowPlayingMovie(page: Int)
    case getTopRatedMovie(page: Int)
}

extension MainService: TargetType {
    
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: URL {
        let _baseURL = ConfigHelper.shared.getValue(configKey: .BaseURL)
        return URL(string: _baseURL)!
    }
    
    var path: String {
        switch self {
        case .getUpcomingMovie:
            return "3/movie/upcoming"
        case .getPopularMovie:
            return "3/movie/popular"
        case .getNowPlayingMovie:
            return "3/movie/now_playing"
        case .getTopRatedMovie:
            return "3/movie/top_rated"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var parameter: [String: Any] {
        let apiKey = ConfigHelper.shared.getValue(configKey: .APIKey)
        switch self {
        case .getUpcomingMovie(let page),
             .getPopularMovie(let page),
             .getTopRatedMovie(let page),
             .getNowPlayingMovie(let page):
            return [
                "api_key": apiKey,
                "page": page
            ]
        }
    }
}

