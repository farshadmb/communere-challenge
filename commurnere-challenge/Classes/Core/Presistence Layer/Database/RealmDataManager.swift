//
//  RealmDataManager.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RealmSwift

/// The `RealmDataManager` class extended and implemented `Storage` abstract.
/// The Default DataManager of this application.
class RealmDataManager: Storage {
    
    /// Rhe default instace of `RealmDataManager`
    static let `default` = RealmDataManager(provider:RealmProvider.default)
    
    /// The Stored Provider object.
    private let provider: RealmProviderProtocol
    
    /// <#Description#>
    private var token: NotificationToken?
    
    /// Constructor
    ///
    /// - Parameter provider: an object is conformed `RealmProviderProtocol` abstract.
    init(provider: RealmProviderProtocol) {
        self.provider = provider
    }
    
    deinit {
        token?.invalidate()
        token = nil
    }
    
    // MARK: - Storage Implementation methods
    
    func create<T>(_ model: T.Type, completion: @escaping (T) -> Void) throws where T : Storable {
        guard let realm = provider.realm,
            let model = model as? Object.Type else {
                throw Error.eitherRealmIsNilOrNotRealmSpecificModel
        }
        
        try self.safeWrite {
            let newObject = realm.create(model, value: [], update: .error) as! T
            completion(newObject)
        }
    }
    
    func save(object: Storable) throws {
        guard let realm = provider.realm,
            let object = object as? Object else {
                throw Error.eitherRealmIsNilOrNotRealmSpecificModel
        }
        
        try self.safeWrite {
            realm.add(object)
        }
    }
    
    func update(object: Storable) throws {
        guard let realm = provider.realm,
            let object = object as? Object else {
                throw Error.eitherRealmIsNilOrNotRealmSpecificModel
        }
        
        try self.safeWrite {
            realm.add(object, update: .modified)
        }
    }
    
    func delete(object: Storable) throws {
        guard let realm = provider.realm,
            let object = object as? Object else {
                throw Error.eitherRealmIsNilOrNotRealmSpecificModel
        }
        
        try safeWrite {
            realm.delete(object)
        }
    }
    
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        guard let realm = provider.realm,
            let model = model as? Object.Type else {
                throw Error.eitherRealmIsNilOrNotRealmSpecificModel
        }
        
        try safeWrite {
            realm.delete(realm.objects(model))
        }
    }
    
    func fetch<T>(type: T.Type, predicate: NSPredicate?, sort: Sort?, completion: @escaping ([T]) -> ()) throws where T : Storable {
        
        guard let realm = provider.realm,
            let model = type as? Object.Type else {
                throw Error.eitherRealmIsNilOrNotRealmSpecificModel
        }
        
        var objects = realm.objects(model)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sort = sort {
            objects = objects.sorted(byKeyPath: sort.key, ascending: sort.ascending)
        }
        
        token?.invalidate()
        
        token = objects.observe { changeset in
            
            switch changeset {
            case let .initial(values),
                 .update(let values, _, _, _):
                completion(values.compactMap { $0 as? T } )
                
            case let .error(error):
                Logger.errorLog("error occured: \(error)",tag: "RealmDataManager")
                return
            }
        }
        
    }
    
    /// Safe Write into realm writing process. if realm current state is write, try write with other write operation.
    ///
    /// - Parameter block: the block should be run.
    /// - Throws: throw and `RealmDataManager.Error.realmIsNil` if realm provider does not contain realm object.
    private func safeWrite(_ block: () throws -> Void) throws {
       
        guard let realm = provider.realm else {
            throw Error.realmIsNil
        }
        
        guard realm.isInWriteTransaction else {
            try realm.write(block)
            return
        }
        
        try block()
        
    }
    
}

extension RealmDataManager {
    
    /** Enum that describes the error.
     happening when RealmDataManager operation failed or meet error.
     
       - eitherRealmIsNilOrNotRealmSpecificModel: Error Thrown by RealmDataManager if the both realm object and the realm specific model not definded or nil.
       - realmIsNil: Error Thrown by RealmDataManager if the both realm object in provider is nil.
    */
    enum Error: Swift.Error {
        /// Error Thrown by RealmDataManager if the both realm object and the realm specific model not definded or nil.
        case eitherRealmIsNilOrNotRealmSpecificModel
        /// Error Thrown by RealmDataManager if the both realm object in provider is nil.
        case realmIsNil
    }
    
}

extension Object: Storable {}
