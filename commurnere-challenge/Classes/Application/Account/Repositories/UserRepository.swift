//
//  UserRepository.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift

/// <#Description#>
class UserRepository: BaseDataRepository<User> {
    
}

// MARK: - UserRepositoryUseCases Implementation.
extension UserRepository: UserRepositoryUseCases {
    
    func fetchAllUser() -> Observable<[User]> {
        return fetch(type: User.self, sort:(key: "id", ascending:true))
    }
    
    func save(user: User) -> Single<Result<String, Error>> {
        return save(object: user)
            .flatMap({ (string) -> PrimitiveSequence<SingleTrait, Result<String,Error>> in
                return .just(.success(string))
            })
            .catchError({ (error) -> PrimitiveSequence<SingleTrait, Result<String, Error>> in
                return .just(.failure(error))
            })
    }
    
    func update(user: User) -> Single<Result<String, Error>> {
        return update(object: user)
            .flatMap({ (string) -> PrimitiveSequence<SingleTrait, Result<String,Error>> in
                return .just(.success(string))
            })
            .catchError({ (error) -> PrimitiveSequence<SingleTrait, Result<String, Error>> in
                return .just(.failure(error))
            })
    }
    
    func delete(user: User) -> Single<Result<String, Error>> {
        return delete(object: user)
            .flatMap({ (string) -> PrimitiveSequence<SingleTrait, Result<String,Error>> in
                return .just(.success(string))
            })
            .catchError({ (error) -> PrimitiveSequence<SingleTrait, Result<String, Error>> in
                return .just(.failure(error))
            })
    }
    
    func find(username: String) -> Observable<User?> {
        return fetchAllUser()
            .flatMapLatest({[weak self] (users) -> Observable<User?> in
                return self?.find(username: username, in: users) ?? .just(nil)
            })
    }
    
    private func find(username: String,in users: [User]) -> Observable<User?> {
        return Observable.create { (observer) -> Disposable in
            
            observer.onNext(users.first(where: { $0.username.lowercased() == username.lowercased() }))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    
}
