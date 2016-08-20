//
//  ColorTheme.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/20/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r:Int, g:Int, b:Int) {
        
        self.init(red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                 blue: CGFloat(b) / 255.0,
                alpha: 1.0)
    }
}

struct Theme {
    static var background = UIColor(r: 255, g: 208, b: 95)
    static var collection = UIColor(r: 148, g: 105, b: 21)
    static var imageCell  = UIColor(r: 13,  g: 63,  b: 178)
}
