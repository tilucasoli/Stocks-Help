//
//  PlistManager.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 19/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

class PlistManager {
    let plistURL: URL = {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("AssetsData.plist")
    }()
    
    func write() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        if let data = try? encoder.encode(ListAssets.list) {
            if FileManager.default.fileExists(atPath: plistURL.path) {
                
                try? data.write(to: plistURL)
            } else {
                FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
            }
        }
    }
    
    func read() -> [Asset] {
        let decoder = PropertyListDecoder()
        
        do {
            let infoPlistData = try Data(contentsOf: plistURL)
            if let arr = try? decoder.decode([Asset].self, from: infoPlistData) as [Asset] {
                
                return arr
            }
        } catch {
            print(error)
        }
        return []
    }
}
