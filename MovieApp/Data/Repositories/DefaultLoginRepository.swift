//
//  DefaultLoginRepository.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

final class DefaultLoginRepository: LoginRepository {

    init(){}
    
    func fetchLogin(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        if username == "Admin" && password == "Password*123." {
            completion(.success(true))
        } else {
            completion(.failure(NSError(domain: "username or password incorrect!", code: 403, userInfo: nil)))
        }
    }
}
