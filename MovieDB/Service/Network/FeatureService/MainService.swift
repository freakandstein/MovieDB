//
//  MainService.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import Moya

enum MainService {
    case getCurrentPrice
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
        case .getCurrentPrice:
            return "/bpi/currentprice.json"
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
        return [:]
    }
}

