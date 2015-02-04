//
//  MainViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 3..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var yasickButton: UIButton!
    @IBOutlet weak var haksickButton: UIButton!
    
    @IBOutlet weak var sixwayBusButton: UIButton!
    
    override func viewDidLoad() {
        // make round corner button
        let topMaskLayer = CAShapeLayer()
        let topBezierPath = UIBezierPath(roundedRect: yasickButton.bounds, byRoundingCorners: UIRectCorner(UIRectCorner.TopLeft.rawValue|UIRectCorner.TopRight.rawValue), cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        topMaskLayer.path = topBezierPath.CGPath
        yasickButton.layer.mask = topMaskLayer
        
        let bottomMaskLayer = CAShapeLayer()
        let bottomBezierPath = UIBezierPath(roundedRect: haksickButton.bounds, byRoundingCorners: UIRectCorner(UIRectCorner.BottomLeft.rawValue|UIRectCorner.BottomRight.rawValue), cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        bottomMaskLayer.path = bottomBezierPath.CGPath
        haksickButton.layer.mask = bottomMaskLayer
    }
}