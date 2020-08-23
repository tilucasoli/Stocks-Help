//
//  Double.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 20/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

extension Double {
    func stringFormatter() -> String {
        let str = String(format: "%0.2f", self).replacingOccurrences(of: ".", with: ",")
        var array = Array(str)
        
        var numberCharacters = array.count - 3
        for _ in 0..<array.count {
            numberCharacters -= 3
            if numberCharacters > 0 {
                array.insert(".", at: numberCharacters)
            }
        }
        
        return String(array)
    }
}
