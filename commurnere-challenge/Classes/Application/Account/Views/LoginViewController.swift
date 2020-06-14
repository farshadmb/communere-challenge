//
//  LoginViewController.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/14/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import MaterialComponents
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, AlertableView, Routerable {

    @IBOutlet weak var usernameTextField: MDCTextField!
    @IBOutlet weak var passwordTextField: MDCTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var controllers : [MDCTextInputControllerBase] = []
    
    var viewModel: LoginViewModel?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateUI()
        try? bindingViewModel()
        
        registerButton.rx.tap.bind {[unowned self] _  in
            try? self.router.navigate(to: AccountRoute.register, with: nil)
        }.disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func configurateUI() {
        usernameTextField.autocorrectionType = .no
        usernameTextField.returnKeyType = .next
        
        controllers += [MDCTextInputControllerUnderline(textInput: usernameTextField)]
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .go
        
        controllers += [MDCTextInputControllerUnderline(textInput: passwordTextField)]
        
        title = NSLocalizedString("Login", comment: "")
        
    }
    
    private func bindingViewModel() throws {
        
        guard let viewModel = viewModel else {
            return
        }
        
        usernameTextField.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        viewModel.isValid.drive(submitButton.rx.isEnabled).disposed(by: disposeBag)
        
        submitButton.rx.tap
            .flatMapLatest { _ in
                return viewModel.login()
            }
            .debug()
            .bind(onNext: {[unowned self] result in
                switch result {
                case .success(let value):
                    guard value else {
                        return
                    }
                    self.presentAlertView(withMessage: "Hello Dear User", actionTitle: "What's up", actionHandler: {
                        
                    })
                //TODO: Navigate to Next steps
                case .failure(let error):
                    self.presentAlertView(withMessage: error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
        
    }

}
