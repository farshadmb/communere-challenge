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
                //uncomment this code and build and run for create admin user
//                let adminUser = User(id: 1, username: "admin", password: "deb058ddc1029e214f4ac76ff25df3c4",
//                                     role: .admin, fullName: "Admin", imagePath: nil)
//                let userRepository = UserRepository(createAdminUser: adminUser, manager: RealmDataManager.default)
                guard !viewController.isViewLoaded else { return }
                let userRepository = UserRepository(manager: RealmDataManager.default)
                viewController.viewModel = LoginViewModel(usersRepository: userRepository)
            })
            .using(UINavigationController.push())
            .from(singleStep)
            .using(GeneralAction.replaceRoot())
            .assemble(from: GeneralStep.current())
    }()
    
    //
    static let register: DestinationStep<UIViewController,Any?> = {
/** StoryboardFactory<UIViewController,Any?>(name: .account,
 identifier: UIViewController.className)
 */
        return StepAssembly(finder: NilFinder(),
                            factory: ClassFactory<UIViewController,Any?>())
            .adding(InlineContextTask<UIViewController,Optional> { viewController, context in
                print(viewController,context)
                //FIXME: remove this template code.
                viewController.view.backgroundColor = .white
                viewController.title = "Sign up"
            })
            .using(UINavigationController.push())
            .assemble(from: AccountRoute.login.expectingContainer())
    }()
    
    
}
