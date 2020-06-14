//
//  UserRepositoryUseCases.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryUseCases {
    
    /// Fetch All User
    ///
    /// - Returns: The `Obseravable` Type of list of `Users`
    func fetchAllUser() -> Observable<[User]>
    
    /// Save and Add an new `User` object into storage
    ///
    /// - Parameter user: the user object that will be stored.
    /// - Returns: an `Single` type of `Result<String,Error>` indicate that the save operation success or not.
    func save(user: User) -> Single<Result<String,Error>>
    
    /// Update `User` object data into storage
    ///
    /// - Parameter user: the user object that will be updated.
    /// - Returns: an `Single` type of `Result<String,Error>` indicate that operation success or not with User Friendly Message.
    func update(user: User) -> Single<Result<String,Error>>
    
    /// Delete an new `User` object from storage
    ///
    /// - Parameter user: the user object that will be stored.
    /// - Returns: an `Single` type of `Result<String,Error>` indicate that operation success or not with User Friendly Message.
    func delete(user: User) -> Single<Result<String,Error>>
    
    /// Find and return a `User` object if the user exist. otherwise return nil
    ///
    /// - Parameter username: the username that must be found.
    /// - Returns: return a `User` object if the user exist. otherwise return nil
    func find(username: String) -> Observable<User?>
}
