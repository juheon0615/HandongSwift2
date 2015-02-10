//
//  MainBusUILabel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 7..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MainBusUILabel: UILabel {
    let fontsize = 10.0
    
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        
        self.font = UIFont(name: self.font.fontName, size: CGFloat(self.fontsize))
        
        self.text = text
        self.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.textAlignment = NSTextAlignment.Center
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}