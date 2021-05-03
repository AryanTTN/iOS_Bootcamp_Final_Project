//
//  ThemeProtocol.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 28/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var mainFontName : UIFont { get }
    var textColor: UIColor { get }
    var accent: UIColor { get }
    var background: UIColor { get }
    var tint: UIColor { get }
}
