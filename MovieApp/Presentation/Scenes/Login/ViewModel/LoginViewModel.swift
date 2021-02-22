//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

struct LoginViewModelActions {
    let showMovieList: () -> Void
}

protocol LoginViewModelInput {
    func login()
    func updateCredentials(username: String, password: String)
    func credentialsInput() -> DefaultLoginViewModel.CredentialsInputStatus
    func goToMovieList()
}

protocol LoginViewModelOutput {
    var credentialsInputErrorMessage: Observable<String> { get }
    var loginInputErrorMessage: Observable<String> { get }
    var isLoginSuccess: Observable<Bool> { get }
}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput {}

final class DefaultLoginViewModel: LoginViewModel {
    
    private let loginUseCase: LoginUseCase
    private let actions: LoginViewModelActions?
    
    private var username: String = ""
    private var password: String = ""
    
    // MARK: - OUTPUT
    let credentialsInputErrorMessage: Observable<String> = Observable("")
    let loginInputErrorMessage: Observable<String> = Observable("")
    var isLoginSuccess: Observable<Bool> = Observable(false)
    
    init(loginUseCase: LoginUseCase, actions: LoginViewModelActions? = nil) {
        self.loginUseCase = loginUseCase
        self.actions = actions
    }
    
    private func login(username: String, password: String) {
        loginUseCase.execute(username: username, password: password, completion: { result in
            switch result {
            case .success:
                self.isLoginSuccess.value = true
            case .failure(let error):
                self.loginInputErrorMessage.value = error.localizedDescription
            }
        })
    }
}

// MARK: - INPUT. View event methods
extension DefaultLoginViewModel {
    
    func updateCredentials(username: String, password: String) {
            self.username = username
            self.password = password
    }
    
    func login() {
        login(username: username, password: password)
    }
    
    func credentialsInput() -> CredentialsInputStatus {
        if username.isEmpty && password.isEmpty {
            credentialsInputErrorMessage.value = "Please provide username and password."
            return .Incorrect
        }
        
        if username.isEmpty {
            credentialsInputErrorMessage.value = "Username field is empty."
            return .Incorrect
        }
        if password.isEmpty {
            credentialsInputErrorMessage.value = "Password field is empty."
            return .Incorrect
        }
        return .Correct
    }
    
    func goToMovieList() {
        self.actions?.showMovieList()
    }
}

extension DefaultLoginViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}
