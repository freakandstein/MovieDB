//
//  ErrorModel.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

struct ErrorModel: Codable, Error {
    var statusCode: Int
    var statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

extension Error where Self == ErrorModel {
    static func errorResponse(code: Int, message: String) -> ErrorModel {
        return ErrorModel(statusCode: code, statusMessage: message)
    }
    
    static func generalError() -> ErrorModel {
        return ErrorModel(statusCode: 000, statusMessage: "General Error")
    }
    
    static func saveError() -> ErrorModel {
        return ErrorModel(statusCode: 001, statusMessage: "Save Data Error")
    }
    
    static func loadError() -> ErrorModel {
        return ErrorModel(statusCode: 002, statusMessage: "Load Data Error")
    }
}

