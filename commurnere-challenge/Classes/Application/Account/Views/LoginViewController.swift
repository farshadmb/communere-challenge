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
    
    var viewModel: LoginViewModel?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateUI()
        try? bindingViewModel()
        
        registerButton.rx.tap.bind {[unowned self] _  in
            //TODO: navigate to sign up view
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
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .go
        
    }
    
    private func bindingViewModel() throws {
        
        guard let viewModel = viewModel else {
            return
        }
        
        usernameTextField.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        viewModel.isValid.drive(submitButton.rx.isEnabled).disposed(by: disposeBag)
        
        submitButton.rx.tap
            .flatMapLatest(viewModel.login)
            .subscribeOn(DriverSharingStrategy.scheduler)
            .subscribe(onNext: {[unowned self] (result) in
                switch result {
                case .success(let value):
                    guard value else {
                        return
                    }
                //TODO: Navigate to Next steps
                case .failure(let error):
                    self.presentAlertView(withMessage: error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
        
    }

}
