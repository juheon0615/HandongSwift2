//
//  MainMenuUIImageView.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 12..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MainMenuUIImageView: UIImageView {
    init(index: Int, itemYPos: Double, image: String) {
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        let margin = (screenWidth - (130.0 * 2)) / 3
        
        var xPos = (index % 2 == 0 ? margin : margin*2 + 130)
        var yPos = (index < 2 ? itemYPos : itemYPos + 180)
        
        super.init(frame: CGRect(x: Double(xPos), y: Double(yPos), width: 130.0, height: 130.0))
        
        // make corner round
        let roundCorner = UIRectCorner(UIRectCorner.AllCorners.rawValue)
        let cornerRadi = CGSize(width: 10.0, height: 10.0)
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundCorner, cornerRadii: cornerRadi).CGPath
        self.layer.mask = layer
        
        let img = Util.readImage(image)
        if img != nil {
            self.image = UIImage(data: img!)
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}