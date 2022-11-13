//
//  NetworkService.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import Moya

protocol NetworkServiceProtocol: AnyObject {
    func request<T: TargetType, M: Decodable>(target: T, model: M.Type,
                                              completion: @escaping (Result<M, Error>) -> Void)
}

class Provider: NetworkServiceProtocol {
    
    private var provider: MoyaProvider<MultiTarget>?
    private var isDebug: Bool
    
    init(isDebugMode: Bool = false) {
        isDebug = isDebugMode
        if isDebug {
            provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin()])
        } else {
            provider = MoyaProvider<MultiTarget>()
        }
    }
    
    public func request<T, M>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void) where T : TargetType, M : Decodable {
        self.provider?.request(MultiTarget(target)) { (result) in
            switch result {
            case .success(let response):
                do {
                    if response.statusCode != 200 {
                        let errorResult = try response.map(ErrorModel.self)
                        completion(.failure(errorResult))
                    } else {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let result = try filteredResponse.map(model)
                        completion(.success(result))
                    }
                } catch {
                    let errorMessage = "Decoding Error"
                    completion(.failure(.errorResponse(code: response.statusCode, message: errorMessage)))
                }
            case .failure(let error):
                let errorMessage = "Unknown Error"
                completion(.failure(.errorResponse(code: error.errorCode, message: errorMessage)))
            }
        }
    }
}

class NetworkService {
    static var shared = NetworkService()
    private var delegate: NetworkServiceProtocol?
    
    init(networkServiceProtocol: NetworkServiceProtocol = Provider()) {
        self.delegate = networkServiceProtocol
    }
    
    public func request<T: TargetType, M: Decodable>(target: T, model modelType: M.Type, completion: @escaping (Result<M, Error>) -> Void ){
        self.delegate?.request(target: target, model: modelType, completion: completion)
    }
}
