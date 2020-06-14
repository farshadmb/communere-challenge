//
//  AccountRoute.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RouteComposer

/// The Struct defined Account Route Configuration
struct AccountRoute: Route {
    
    static let login: DestinationStep<LoginViewController,Any?> = {
        
        let singleStep = SingleContainerStep(finder: NilFinder(),factory: NavigationFactory<Any?>(configuration: { (_) in
            
        }))
        
        return StepAssembly(finder: ClassFinder(options: .fullStack),
                            factory: StoryboardFactory<LoginViewController,Any?>(name: .account,
                                                                                 identifier: LoginViewController.className))
            .adding(InlineContextTask<LoginViewController,Optional> { viewController, context in
                viewController.viewModel = LoginViewModel(usersRepository: UserRepository(manager: RealmDataManager.default))
            })
            .using(UINavigationController.push())
            .from(singleStep)
            .using(GeneralAction.replaceRoot())
            .assemble(from: GeneralStep.current())
    }()
    
    //
    static let register: DestinationStep<UIViewController,Any?> = {
        return StepAssembly(finder: NilFinder(),
                            factory: StoryboardFactory<UIViewController,Any?>(name: .account,
                                                                              identifier: UIViewController.className))
            .adding(InlineContextTask<UIViewController,Optional> { viewController, context in
                print(viewController,context)
            })
            .using(UINavigationController.push())
            .assemble(from: AccountRoute.login.expectingContainer())
    }()
    
    
}
