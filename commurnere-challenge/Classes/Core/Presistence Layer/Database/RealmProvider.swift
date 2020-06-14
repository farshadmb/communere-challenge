//
//  RealmProvider.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmProviderProtocol {
    var realm: Realm? { get }
}

/// `RealmProvider` class, this class resposibility just is configurate realm and provide the realm database instance.
struct RealmProvider: RealmProviderProtocol {
    
    /// the realm configuration value
    let configuration: Realm.Configuration
    
    var realm: Realm? {
        do {
            return try Realm(configuration: configuration)
        }catch let error {
            Logger.errorLog("error occured : \(error)", tag: "RealmProvider")
            return nil
        }
    }
    
    static let `default` : RealmProvider = {
        var config = Realm.Configuration(inMemoryIdentifier: "com.test.realm.memory", schemaVersion: 1)
        if let filePath = try? URL.applicationSupportDirectoryURL().appendingPathComponent("realm.db") {
            config.fileURL = filePath
        }
        
        return RealmProvider(configuration:config)
    }()
    
    /// Constructor
    ///
    /// - Parameter configuration: the realm database configuration object.
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    
    
}

