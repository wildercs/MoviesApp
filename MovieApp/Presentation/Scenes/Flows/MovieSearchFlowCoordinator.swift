//
//  MovieSearchFlowCoordinator.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import UIKit

protocol MovieSearchFlowCoordinatorDependencies  {
    func makeMoviesListViewController(actions: MovieListViewModelActions) -> MovieListViewController
}

final class MovieSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MovieSearchFlowCoordinatorDependencies

    private weak var moviesListVC: MovieListViewController?
    private weak var moviesQueriesSuggestionsVC: UIViewController?

    init(navigationController: UINavigationController,
         dependencies: MovieSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = MovieListViewModelActions(showMovieQueriesSuggestions: showMovieQueriesSuggestions,
                                                 closeMovieQueriesSuggestions: closeMovieQueriesSuggestions)
        let vc = dependencies.makeMoviesListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        moviesListVC = vc
    }

    private func showMovieQueriesSuggestions(didSelect: @escaping (MovieQuery) -> Void) {
        /*guard let moviesListViewController = moviesListVC, moviesQueriesSuggestionsVC == nil,
            let container = moviesListViewController.suggestionsListContainer else { return }

        let vc = dependencies.makeMoviesQueriesSuggestionsListViewController(didSelect: didSelect)

        moviesListViewController.add(child: vc, container: container)
        moviesQueriesSuggestionsVC = vc
        container.isHidden = false*/
    }

    private func closeMovieQueriesSuggestions() {
        //moviesQueriesSuggestionsVC?.remove()
        //moviesQueriesSuggestionsVC = nil
        moviesListVC?.suggestionsListContainer.isHidden = true
    }
}
