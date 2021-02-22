//
//  LoginFlowCoordinator.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import UIKit

protocol LoginFlowCoordinatorDependencies {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func makeMovieListFlowCoordinator(navigationController: UINavigationController) -> MovieSearchFlowCoordinator
}

final class LoginFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: LoginFlowCoordinatorDependencies
    
    private weak var loginVC: LoginViewController?
    
    init(navigationController: UINavigationController,
         dependencies: LoginFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = LoginViewModelActions(showMovieList: showMovieList)
        let vc = dependencies.makeLoginViewController(actions: actions)
        self.navigationController?.pushViewController(vc, animated: true)
        self.loginVC = vc
    }
    
    private func showMovieList() {
        print(#function)
        let flowMovieList = dependencies.makeMovieListFlowCoordinator(navigationController: navigationController!)
        flowMovieList.start()
    }
}
