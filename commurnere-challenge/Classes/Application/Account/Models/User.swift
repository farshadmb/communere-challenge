//
//  User.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RealmSwift

/// <#Description#>
@objc
class User: Object {
    
    
    /// <#Description#>
    ///
    /// - admin: <#admin description#>
    /// - regular: <#regular description#>
    @objc enum Role: Int  {
        case admin
        case regular
    }
    
    /// <#Description#>
    @objc dynamic var id: Int = 0
    
    /// <#Description#>
    @objc dynamic var username: String = ""
    
    /// <#Description#>
    @objc dynamic var password: String = ""
    
    @objc dynamic var roleValue: Int = 1
    
    /// <#Description#>
    var role : Role {
    
        get {
            return Role(rawValue: roleValue) ?? .regular
        }
        
        set {
            roleValue = role.rawValue
        }
    }
    
    
    /// <#Description#>
    @objc dynamic var fullName: String?
    
    /// <#Description#>
    @objc dynamic var imagePath: String?
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - username: <#username description#>
    ///   - password: <#password description#>
    ///   - role: <#role description#>
    ///   - fullName: <#fullName description#>
    ///   - imagePath: <#imagePath description#>
    convenience init(id: Int,
                     username: String, password: String,
                     role : Role = .regular,
                     fullName: String?, imagePath: String?) {
        self.init()
        self.id = id
        self.username = username
        self.password = password
        self.role = role
        self.fullName = fullName
        self.imagePath = imagePath
    }
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
}
