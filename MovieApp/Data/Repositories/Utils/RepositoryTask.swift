//
//  RepositoryTask.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
