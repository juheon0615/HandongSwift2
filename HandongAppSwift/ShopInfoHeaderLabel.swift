//
//  ShopInfoHeaderLabel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 20..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class ShopInfoHeaderLabel: UILabel {
    
    class var height: Double {
        return 25
    }
    class var width: Double {
        return 80
    }
    
    init(x: Double, y: Double, text: String) {
        super.init(frame: CGRect(x: x, y: y, width: ShopInfoHeaderLabel.width, height: ShopInfoHeaderLabel.height))
        self.text = text
        self.textColor = UIColor.darkGrayColor()
        self.font = UIFont(name: self.font.fontName, size: 14)
        self.sizeToFit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
