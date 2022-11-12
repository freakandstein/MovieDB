//
//  ErrorModel.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

struct ErrorModel: Codable, Error {
    var errorCode: Int
    var message: String
}

extension Error where Self == ErrorModel {
    static func errorResponse(code: Int, message: String) -> ErrorModel {
        return ErrorModel(errorCode: code, message: message)
    }
    
    static func generalError() -> ErrorModel {
        return ErrorModel(errorCode: 000, message: "General Error")
    }
    
    static func saveError() -> ErrorModel {
        return ErrorModel(errorCode: 001, message: "Save Data Error")
    }
    
    static func loadError() -> ErrorModel {
        return ErrorModel(errorCode: 002, message: "Load Data Error")
    }
}

