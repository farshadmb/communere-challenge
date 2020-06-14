//
//  Storage.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

/// <#Description#>
protocol CreatableStorage {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - model: <#model description#>
    ///   - completion: <#completion description#>
    /// - Throws: <#throws value description#>
    func create<T: Storable>(_ model: T.Type, completion:@escaping (T) -> Void) throws
}


/// <#Description#>
protocol SavableStorage {
    
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Throws: <#throws value description#>
    func save(object: Storable) throws
}

/// <#Description#>
protocol UpdatableStorage {
    
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Throws: <#throws value description#>
    func update(object: Storable) throws
}


/// <#Description#>
protocol DeletableStorage {
    
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Throws: <#throws value description#>
    func delete(object: Storable) throws
    
    
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Throws: <#throws value description#>
    func delete(object: [Storable]) throws
    
    /// <#Description#>
    ///
    /// - Parameter model: <#model description#>
    /// - Throws: <#throws value description#>
    func deleteAll<T: Storable> (_ model: T.Type) throws
}

protocol FetchableStorage {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - type: <#type description#>
    ///   - predicate: <#predicate description#>
    ///   - completion: <#completion description#>
    /// - Throws: <#throws value description#>
    func fetch<T: Storable> (type: T.Type, predicate: NSPredicate?, completion: ([T]) -> ()) throws
}

typealias Storage = CreatableStorage & SavableStorage & UpdatableStorage & DeletableStorage & FetchableStorage
