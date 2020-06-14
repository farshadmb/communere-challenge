//
//  URL+ApplicationPath.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

extension URL {
    
    static func applicationSupportDirectoryURL() throws -> URL {
       return try getSearchingPath(for: .applicationSupportDirectory)
    }
    
    static func documentDirectoryURL() throws -> URL {
        return try getSearchingPath(for: .documentDirectory)
    }
    
    static func cacheDirectoryURL() throws -> URL {
        return try getSearchingPath(for: .cachesDirectory)
    }
    
    static func getSearchingPath(for searchingPath : FileManager.SearchPathDirectory = .applicationSupportDirectory) throws -> URL {
        guard let path = FileManager.default.urls(for: searchingPath, in: .userDomainMask).first else {
            throw POSIXError(.ENOENT)
        }
        
        return path
    }
    
}
