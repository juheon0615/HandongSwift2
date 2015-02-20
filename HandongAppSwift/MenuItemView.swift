//
//  MenuItemView.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 19..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MenuItemView: UIView {
    init(margin: Double, yPos: Double, item: StoreDetailModel.Menu) {
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        let width = screenWidth - 2 * margin
        
        var newHeight: CGFloat = 0
        
        super.init(frame: CGRect(x: margin, y: yPos, width: width, height: 1))
        
        let menuWidth = (super.frame.width / 3) * 2
        let priceWidth = (super.frame.width / 3)
        let menuLabel = UILabel(frame: CGRect(x: 0, y: 0, width: menuWidth, height: 30))
        let priceLabel = UILabel(frame: CGRect(x: 0 + menuWidth, y: 0, width: priceWidth, height: 30))
        
        // set TEXT
        menuLabel.text = item.name
        priceLabel.text = item.price
        
        // set FONT SIZE
        menuLabel.font = UIFont(name: menuLabel.font.fontName, size: 14)
        priceLabel.font = UIFont(name: priceLabel.font.fontName, size: 14)
        
        // set Properties
        menuLabel.numberOfLines = 0
        menuLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        menuLabel.sizeToFit()
        var newBound = menuLabel.frame
        newBound.size.width = menuWidth
        menuLabel.frame = newBound
        
        priceLabel.textAlignment = NSTextAlignment.Right
        priceLabel.numberOfLines = 0
        priceLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        priceLabel.sizeToFit()
        newBound = priceLabel.frame
        newBound.size.width = priceWidth
        priceLabel.frame = newBound
        
        super.addSubview(menuLabel)
        super.addSubview(priceLabel)
        
        newHeight += (menuLabel.frame.height > priceLabel.frame.height ? menuLabel.frame.height : priceLabel.frame.height)
        newHeight += 2 // margin
        
        if item.set != "" {
            let setLabel = UILabel(frame: CGRect(x: 0, y: Double(newHeight), width: Double(menuWidth), height: 10))
            setLabel.text = item.set
            setLabel.font = UIFont(name: setLabel.font.fontName, size: 13)
            setLabel.numberOfLines = 0
            setLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            setLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
            setLabel.sizeToFit()
            
            super.addSubview(setLabel)
            
            newHeight += setLabel.frame.height
        }
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: newHeight)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}