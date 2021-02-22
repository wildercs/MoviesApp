//
//  BlackStyleNavigationBarBehavior.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation

import UIKit

struct BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationController?.navigationBar.barStyle = .black
    }
}
