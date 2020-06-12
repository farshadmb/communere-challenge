//
//  AnyDestionationStep.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit
import RouteComposer

typealias AnyGenericDestinationStep<T> = DestinationStep<UIViewController,T>
typealias AnyDestinationStep = AnyGenericDestinationStep<Any?>

// MARK: Helper methods where the Context is Any?

/// A step that has a context type Optional(Any) can be build with any type of context passed to the router.
extension DestinationStep where DestinationStep.Context == Any? {
    
    /// Allows to avoid container view controller check. This method is available only for the steps that are
    /// able to accept any type of context.
    ///
    /// *NB:* Developer guaranties that it will be there in the runtime.
    
    func anyDestination() -> AnyDestinationStep {
        return anyGenericDestionation()
    }
    
}

extension DestinationStep {
    
    /// Allows to avoid container view controller check.This method is available only for the steps that are
    /// able to accept any type of context.
    ///
    /// *NB:* Developer guaranties that it will be there in the runtime.
    func anyGenericDestionation() -> AnyGenericDestinationStep<DestinationStep.Context> {
        return unsafelyRewrapped()
    }
    
}
