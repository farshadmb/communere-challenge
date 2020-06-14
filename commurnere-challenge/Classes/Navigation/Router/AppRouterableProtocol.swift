//
//  AppRoutableProtocol.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

/// Abstract `Routerable`
protocol Routerable {
    
    /// the router instance
    var router: AppRouter { get }
}

// MARK: - Default Router Provider
extension Routerable {
    
    var router: AppRouter {
        return AppRouter.shared
    }
    
}

// MARK: - UIViewController Routerable
extension Routerable where Self: UIViewController {
    
    /// the app router instance
    var router: AppRouter {
        return AppRouter.shared
    }
    
}

extension Routerable where Self: UIWindow {
    
    var router: AppRouter {
        return AppRouter.shared
    }
    
}

extension UIWindow: Routerable {}
