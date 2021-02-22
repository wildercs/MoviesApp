//
//  CGSize+ScaledSize.swift
//  MovieApp
//
//  Created by wilder campos on 21/02/21.
//

import Foundation
import UIKit

extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}
