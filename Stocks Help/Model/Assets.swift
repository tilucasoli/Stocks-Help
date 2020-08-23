//
//  assets.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 17/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

struct Asset: Codable, Equatable {
    let symbol: String
    var price: Double
    var qnty: Int
    var currentprice: Double = 0
    
    var changePercent: Double {
        (currentprice/price-1)*100
    }
    
    var totalInvested: Double {
        return price * Double(qnty)
    }
    
    var totalBalance: Double {
        return totalInvested * (1+changePercent/100)
    }
    
}

struct ListAssets {
    static var list: [Asset] = PlistManager().read()
    
    static func refreshCurrentPrice() {
        let listStockSymbols = ListAssets.list.map({$0.symbol})
        
        for index in 0..<listStockSymbols.count {
            ListAssets.list[index].currentprice = try! APIManager().requestPrice(assetCode: listStockSymbols[index])
        }
            
    }
    
    static var totalBalance: Double {
        get {
            let listTotalBalance = list.map {$0.totalBalance}
            return listTotalBalance.reduce(0, {$0+$1})
        }
    }
    
    static var totalInvested: Double {
        get {
            let listTotalInvested = list.map {$0.totalInvested}
            return listTotalInvested.reduce(0, {$0+$1})
        }
    }
}
