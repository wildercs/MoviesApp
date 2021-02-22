//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import UIKit

final class AppCoordinator {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeLoginFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
