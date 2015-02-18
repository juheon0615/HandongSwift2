//
//  MenuDivideBarView.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 19..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MenuDivideBarView: UIView {
    init(margin: Double, yPos: Double) {
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        super.init(frame: CGRect(x: margin, y: yPos, width: screenWidth - 2*margin, height: 1))
        self.backgroundColor = UIColor.grayColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}