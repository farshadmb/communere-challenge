//
//  BaseDataRepository.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxRealm
import RxSwift
import RxSwiftExt
import Realm

/// <#Description#>
class BaseDataRepository <T> {
    
    /// <#Description#>
    let dbManager: Storage
    
    /// <#Description#>
    ///
    /// - Parameter manager: <#manager description#>
    required init(manager: Storage) {
        dbManager = manager
    }
    
    /// <#Description#>
    typealias SortOption = Storage.Sort
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - type: <#type description#>
    ///   - predicate: <#predicate description#>
    ///   - sort: <#sort description#>
    /// - Returns: <#return value description#>
    open func fetch <T>(type: T.Type, predicate: NSPredicate? = nil, sort: SortOption? = nil) -> Observable<[T]> where T: Storable {
        
        let storage = dbManager
        let publishSubject = ReplaySubject<[T]>.create(bufferSize: 1)
        
        do {
            try storage.fetch(type:type, predicate: predicate, sort: sort, completion: { (list) in
                publishSubject.onNext(list)
            })
        }catch let error {
            publishSubject.onError(error)
        }
        
        return publishSubject
        
    }
    
    
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Returns: <#return value description#>
    func save(object: Storable) -> Single<String> {
        
        let storage = dbManager
        return perform {
            try storage.save(object: object)
            return "Saved Successfully."
            }.asSingle()
        
    }
    
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Returns: <#return value description#>
    func update(object: Storable) -> Single<String> {
        let storage = dbManager
        return perform {
            try storage.save(object: object)
            return "Updated Successfully."
            }.asSingle()
    }
    
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Returns: <#return value description#>
    func delete(object: Storable) -> Single<String> {
        let storage = dbManager
        return perform {
            try storage.delete(object: object)
            return "Deleted Successfully."
            }.asSingle()
    }
    
    /// <#Description#>
    ///
    /// - Parameter type: <#type description#>
    /// - Returns: <#return value description#>
    func deleteAll<S>(type: S.Type) -> Single<String> where S : Storable {
        let storage = dbManager
        return perform {
            try storage.deleteAll(type)
            return "Deleted Successfully."
            }.asSingle()
    }
    
    /// <#Description#>
    ///
    /// - Parameter modelType: <#modelType description#>
    /// - Returns: <#return value description#>
    func create<T>(modelType: T.Type) -> Single<T> where T: Storable {
        let storage = dbManager
        let publishSubject = ReplaySubject<T>.create(bufferSize: 1)
        
        do {
            try storage.create(modelType, completion: { (object) in
                publishSubject.onNext(object)
                publishSubject.onCompleted()
            })
        }catch let error {
            publishSubject.onError(error)
        }
        
        return publishSubject.asSingle()
    }
    
    /// <#Description#>
    ///
    /// - Parameter block: <#block description#>
    /// - Returns: <#return value description#>
    func perform <R> (block:@escaping () throws -> R ) -> Observable<R> {
        
        let operationObserver = Observable<R>.create { observer in
            
            do {
                let genericObj = try block()
                observer.on(.next(genericObj))
                observer.onCompleted()
            }catch let error {
                observer.on(.error(error))
            }
            
            return Disposables.create {
                
            }
        }
        
        return operationObserver
        
    }
    
    
}
