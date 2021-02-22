//
//  MoviesSceneDIContainer.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import UIKit

final class MoviesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeLoginUseCase() -> LoginUseCase {
        return DefaultLoginUseCase(loginRepository: makeLoginRepository())
    }
    
    func makeSearchMovieUseCase() -> SearchMovieUseCase {
        return DefaultSearchMovieUseCase(moviesRepository: makeMovieRepository())
    }
    
    // MARK: - Repositories
    func makeLoginRepository() -> LoginRepository {
        return DefaultLoginRepository()
    }
    
    func makeMovieRepository() -> MoviesRepository {
        return DefaultMoviesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makePosterImagesRepository() -> PosterImagesRepository {
        return DefaultPosterImagesRepository(dataTransferService: dependencies.imageDataTransferService)
    }
    
    //MARK: - Login
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return DefaultLoginViewModel(loginUseCase: makeLoginUseCase(), actions: actions)
    }
    
    func makeMovieListViewModel(actions: MovieListViewModelActions) -> MovieListViewModel {
        return DefaultMovieListViewModel(searchMoviesUseCase: makeSearchMovieUseCase(),
                                          actions: actions)
    }
    
    // MARK: - Flow Coordinators
    func makeLoginFlowCoordinator(navigationController: UINavigationController) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension MoviesSceneDIContainer: LoginFlowCoordinatorDependencies {
    
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        return LoginViewController.create(with: makeLoginViewModel(actions: actions))
    }
    
    func makeMovieListFlowCoordinator(navigationController: UINavigationController) -> MovieSearchFlowCoordinator {
        return MovieSearchFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension MoviesSceneDIContainer: MovieSearchFlowCoordinatorDependencies {
    
    func makeMoviesListViewController(actions: MovieListViewModelActions) -> MovieListViewController {
        return MovieListViewController.create(
            with: makeMovieListViewModel(actions: actions),
            posterImagesRepository: makePosterImagesRepository()
        )
    }
}
