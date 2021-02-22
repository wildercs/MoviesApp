//
//  DefaultMoviesRepository.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

final class DefaultMoviesRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultMoviesRepository: MoviesRepository {

    public func fetchMoviesList(query: MovieQuery, page: Int,
                                cached: @escaping (MoviesPage) -> Void,
                                completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {

        let request = MoviesRequest(query: query.query, page: page)
        let task = RepositoryTask()

        let endpoint = APIEndpoints.getMovies(with: request)
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
}
