//
//  DarkTheme.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 28/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class DarkTheme: ThemeProtocol {
    
    var textColor: UIColor = UIColor.white
    var mainFontName: UIFont = UIFont(name: "zapfino", size: 20)!
    var accent: UIColor =  UIColor(named: "background")!
    var background: UIColor =  UIColor(named: "tint")!
    var tint: UIColor = UIColor(named: "accent")!
}
