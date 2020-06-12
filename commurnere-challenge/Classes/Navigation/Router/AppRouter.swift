//
//  AppRouter.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit
import RouteComposer
import os.log

/// `AppRouter` the wrapper of `DefaultRouter` of RouteComposer.
struct AppRouter {
    
    /// the shared instance of `AppRouter`
    static let shared: AppRouter = {
        return AppRouter(logger: AppRouterLogger())
    }()

    private var router: DefaultRouter
    
    /// Constructor
    ///
    /// - Parameter logger: the instance of `RouterComposer.Logger` Abstract.
    init(logger: RouteComposer.Logger?) {
        self.router = DefaultRouter(logger: logger)
        self.router.add(NavigationDelayingInterceptor(strategy: .wait,logger: logger))
    }
    
    ////////////////////////////////////////////////////////////////
    // MARK: -
    // MARK: Interceptor Methods
    // MARK: -
    ////////////////////////////////////////////////////////////////
    
    /// Adds `RoutingInterceptor` instance
    ///
    /// - Parameter interceptor: The `RoutingInterceptor` instance to be executed by `Router` before routing to this step.
    mutating func add<RI: RoutingInterceptor>(_ interceptor: RI) where RI.Context == Any? {
        self.router.add(interceptor)
    }
    
    /// Adds ContextTask instance
    ///
    /// - Parameter contextTask: The `ContextTask` instance to be applied by a `Router` immediately after it will find
    ///   or create `UIViewController`.
    mutating func add<CT: ContextTask>(_ contextTask: CT) where CT.Context == Any? {
        self.router.add(contextTask)
    }
    
    /// Adds PostRoutingTask instance
    ///
    /// - Parameter postTask: The `PostRoutingTask` instance to be executed by a `Router` after routing to this step.
    mutating func add<PT: PostRoutingTask>(_ postTask: PT) where PT.Context == Any? {
        self.router.add(postTask)
    }
    
    ////////////////////////////////////////////////////////////////
    // MARK: -
    // MARK: Navigation Methods
    // MARK: -
    ////////////////////////////////////////////////////////////////
    
    /// Navigates the application to the view controller configured in `DestinationStep` with the `Context` provided.
    ///
    /// - Parameters:
    ///   - step: `DestinationStep` instance.
    ///   - context: `Context` instance.
    ///   - animated: if true - the navigation should be animated where it is possible.
    ///   - completion: completion block.
    func navigate<ViewController: UIViewController, Context>(to step: DestinationStep<ViewController, Context>,
                                                             with context: Context,
                                                             animated: Bool = true,
                                                             completion: ((_: RoutingResult) -> Void)? = nil) throws {
        
        try self.router.navigate(to: step,with: context, animated: animated, completion: completion)
    }
    
}
