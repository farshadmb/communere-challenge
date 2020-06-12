//
//  Route.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit
import RouteComposer

/// Abstract `Route`
protocol Route {}

extension Route {
    
    static var navigationStep: SingleContainerStep<NilFinder<UINavigationController, Any?>, NavigationFactory<Any?>> {
        return SingleContainerStep(finder: NilFinder(),
                                   factory: NavigationFactory<Any?>(configuration: { (navigation: UINavigationController) in
                                    navigation.navigationBar.isTranslucent = false
                                   }))
    }
}
