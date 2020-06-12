//
//  StoryboardFactory+NamingConstructor.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit
import RouteComposer

// MARK: - <#Description#>
extension StoryboardFactory {
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - storyboardName: The name of a storyboard file
    ///   - bundle: The `Bundle` instance if needed
    ///   - identifier: The `UIViewController` identifier in the storyboard. If it is not set, the `Factory` will try
    ///     to create the storyboards initial `UIViewController`
    ///   - configuration: A block of code that will be used for the extended configuration of the created `UIViewController`. Can be used for
    ///                    a quick configuration instead of `ContextTask`.
    init(name storyboardName: UIStoryboard.Name,
         bundle: Bundle? = nil,
         identifier: String? = nil,
         configuration: ((_: VC) -> Void)? = nil) {
        self.init(name: storyboardName.rawValue,
                  bundle: bundle,
                  identifier: identifier,
                  configuration: configuration)
    }
    
}

/// Default `NavigationFactory` Type
typealias NavigationFactory<C> = NavigationControllerFactory<UINavigationController,C>
