//
//  APIManager.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 19/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

enum APIRequestErrors: Error {
    case assetCodeDoesntExist
    case invalidJsonConverter
}

extension APIRequestErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .assetCodeDoesntExist:
            return NSLocalizedString("Essa ação não existe", comment: "")
        case .invalidJsonConverter:
            return NSLocalizedString("Essa ação não existe", comment: "S")
        }
    }
}

class APIManager {
    let urlStr = "https://api.hgbrasil.com/finance/"
    
    func getJSON(assetCode: String) throws -> [String: Any] {
        let key = "stock_price?key=4b32c714"
        let operation = "&symbol="
        
        let consultAssetURL = URL(string: urlStr + key + operation + assetCode)!
        
        let data = try Data(contentsOf: consultAssetURL)
        
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw APIRequestErrors.invalidJsonConverter
        }
        
        return json
    }
    
    func requestPrice(assetCode: String) throws -> Double {
        let json = try getJSON(assetCode: assetCode)
        
        let results = json["results"] as? [String: Any]
        let assetResults = results?[assetCode] as? [String: Any]
        
        guard let price = assetResults?["price"] as? Double else {
            throw APIRequestErrors.assetCodeDoesntExist
        }
        
        return price
    }
    
}
