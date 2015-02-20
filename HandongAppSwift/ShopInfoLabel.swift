//
//  ShopInfoLabel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 20..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class ShopInfoLabel: UILabel {
    init(x: Double, y: Double, text: String) {
        let width = Double(UIScreen.mainScreen().applicationFrame.width) - x - 10
        
        super.init(frame: CGRect(x: x, y: y, width: width, height: 25))
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.text = text
        self.textColor = UIColor.darkGrayColor()
        self.font = UIFont(name: self.font.fontName, size: 14)
        self.sizeToFit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}