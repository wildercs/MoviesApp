//
//  MoviesRequest+Mapping.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

struct MoviesRequest: Encodable {
    let query: String
    let page: Int
}
