//
//  LoginViewModel.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CryptoSwift

/// <#Description#>
class LoginViewModel {

    /// <#Description#>
    let username = BehaviorRelay<String?>(value: nil)
    
    /// <#Description#>
    let password = BehaviorRelay<String?>(value:nil)
    
    var isValid: Driver<Bool> {
        return Observable.combineLatest(username.asObservable(),password.asObservable(), resultSelector: { (username, password) -> Bool in
            return !username.isEmptyOrBlank && !password.isEmptyOrBlank
        }).asDriver(onErrorJustReturn: false)
    }
    
    /// the user repository stored property.
    let userRepository: UserRepositoryUseCases
    
    /// <#Description#>
    ///
    /// - Parameter usersRepository: <#usersRepository description#>
    init(usersRepository: UserRepositoryUseCases) {
        self.userRepository = usersRepository
    }
    
    func login() -> Observable<Result<Bool,Error>> {
        guard let usernameValue = username.value, let passwordValue = password.value?.md5() else {
            return .just(Result.success(false))
        }
        
        return userRepository
            .find(username: usernameValue)
            .map { user -> Result<Bool,Error> in
                guard let pass = user?.password, pass == passwordValue else {
                    return .failure(LoginError.invalidCreditional)
                }
                
                return .success(true)
            }
        
    }
    
    
}

extension LoginViewModel {
    
    enum LoginError: Error {
        case invalidCreditional
        case passwordLenghtIsLessThanRequired
    }
    
}

extension LoginViewModel.LoginError : LocalizedError {
    
    var errorDescription: String? {
        return localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .invalidCreditional:
            return "Username or password is incorrect. try again."
        case .passwordLenghtIsLessThanRequired:
            return "Password length is 8 Characters and more ..."
            
        }
    }
    
}
