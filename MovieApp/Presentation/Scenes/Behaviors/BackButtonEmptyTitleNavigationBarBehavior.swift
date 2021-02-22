//
//  BackButtonEmptyTitleNavigationBarBehavior.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import UIKit

struct BackButtonEmptyTitleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
