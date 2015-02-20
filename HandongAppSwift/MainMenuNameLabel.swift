//
//  MainMenuNameLabel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 12..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MainMenuNameLabel: UILabel {
    init(index: Int, itemYPos: Double, text: String) {
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        let margin = (screenWidth - (130.0 * 2)) / 3
        
        var xPos = (index % 2 == 0 ? margin : margin*2 + 130)
        var yPos = (index < 2 ? itemYPos + 130 + 5 : itemYPos + 180 + 130 + 5)
        
        super.init(frame: CGRect(x: Double(xPos), y: Double(yPos), width: 130.0, height: 20.0))
        
        self.text = text
        self.textAlignment = NSTextAlignment.Center
        self.font = UIFont(name: self.font.fontName, size: 13)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}