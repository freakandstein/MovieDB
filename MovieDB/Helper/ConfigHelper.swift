//
//  ConfigHelper.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

public enum ConfigKey: String {
    case APIKey
    case BaseURL
    case BaseURLImage
    
    var value: String {
        return self.rawValue
    }
}

public protocol ConfigHelperProtocol: AnyObject {
    func getValue(configKey: ConfigKey) -> String
}

public class ConfigHelper: ConfigHelperProtocol {
    
    public static let shared = ConfigHelper()
    private var dictionary: [String: Any]?
    
    public init() {
        dictionary = Bundle.main.infoDictionary
    }
    
    public func getValue(configKey: ConfigKey) -> String {
        guard let configValue = dictionary?[configKey.value] as? String else { return .empty }
        return configValue.replacingOccurrences(of: "\\", with: String.empty)
    }
}

