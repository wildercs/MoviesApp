//
//  PosterImagesRepository.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

protocol PosterImagesRepository {
    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
