//
//  LoginUseCase.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

protocol LoginUseCase {
    func execute(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultLoginUseCase: LoginUseCase {
    
    private let loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
    }
    
    func execute(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        return loginRepository.fetchLogin(username: username, password: password, completion: { result in
            completion(result)
        })
    }
}
