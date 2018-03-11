//
//  UIColor+defalut.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/09.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var defaultTint: UIColor {
        return UIColor(red: 0, green: 122/255, blue: 1, alpha: 1.0)
    }
    
    static var defaultTintHighlighted: UIColor {
        return UIColor(red: 0.6, green: 192/255, blue: 1, alpha: 1.0)
    }

    static var whiteHighlighted: UIColor {
        return UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 0.8)
    }
    
    static var unable: UIColor {
        return UIColor(red: 200/255, green: 200/255, blue: 204/255, alpha: 1.0)
    }
}
