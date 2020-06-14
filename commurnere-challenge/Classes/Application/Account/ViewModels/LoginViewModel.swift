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

/// <#Description#>
class LoginViewModel {

    /// <#Description#>
    let username = PublishRelay<String?>()
    
    /// <#Description#>
    let password = PublishRelay<String?>()
    
    var isValid: Driver<Bool> {
        return Observable.combineLatest(username.asObservable(),password.asObservable(), resultSelector: { (username, password) -> Bool in
            return !username.isEmptyOrBlank && !password.isEmptyOrBlank
        }).asDriver(onErrorJustReturn: false)
    }
    
    let userRepository: Any?
    
    /// <#Description#>
    ///
    /// - Parameter usersRepository: <#usersRepository description#>
    init(usersRepository: Any?) {
        self.userRepository = usersRepository
    }
    
    func login() -> Observable<Result<Bool,Error>> {
        //TODO
        fatalError()
    }
    
    
}
