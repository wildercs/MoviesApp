//
//  LoginRepository.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

protocol LoginRepository {
    
    func fetchLogin(username: String, password: String,
                         completion: @escaping (Result<Bool, Error>) -> Void)
}
