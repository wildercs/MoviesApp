//
//  LoginViewController.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var viewModel: LoginViewModel!
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let view = LoginViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(to: viewModel)
    }
    
    private func bind(to viewModel: LoginViewModel) {
        viewModel.credentialsInputErrorMessage.observe(on: self) { [weak self] in self?.showAlert($0) }
        viewModel.isLoginSuccess.observe(on: self) { [weak self] in self?.goToMovieList($0) }
        viewModel.loginInputErrorMessage.observe(on: self) { [weak self] in self?.showAlert($0) }
    }

    @IBAction func doLoginAction(_ sender: Any) {
        viewModel.updateCredentials(username: usernameTextField.text!, password: passwordTextField.text!)
        switch viewModel.credentialsInput() {
        case .Correct:
                login()
        case .Incorrect:
            return
        }
    }
    
    func login() {
        viewModel.login()
    }
    
    func goToMovieList(_ isLogin: Bool) {
        if isLogin {
            viewModel.goToMovieList()
        }
    }
    
    func showAlert(_ message: String) {
        guard !message.isEmpty else { return }
        showAlert(message: message)
    }
}

extension LoginViewController: StoryboardInstantiable, Alertable {}
