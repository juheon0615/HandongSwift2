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
    @IBOutlet weak var schoolBusButton: UIButton!
    
    override func viewDidLoad() {
        // make round corner button
        let topCorner = UIRectCorner(UIRectCorner.TopLeft.rawValue|UIRectCorner.TopRight.rawValue)
        let botCorner = UIRectCorner(UIRectCorner.BottomLeft.rawValue|UIRectCorner.BottomRight.rawValue)
        let cornerRadi = CGSize(width: 10.0, height: 10.0)
        
        let yasickButtonLayer = CAShapeLayer()
        yasickButtonLayer.path = UIBezierPath(roundedRect: yasickButton.bounds, byRoundingCorners: topCorner, cornerRadii: cornerRadi).CGPath
        yasickButton.layer.mask = yasickButtonLayer
        
        let sixwayButtonLayer = CAShapeLayer()
        sixwayButtonLayer.path = UIBezierPath(roundedRect: sixwayBusButton.bounds, byRoundingCorners: topCorner, cornerRadii: cornerRadi).CGPath
        sixwayBusButton.layer.mask = sixwayButtonLayer
        
        
        let haksickButtonLayer = CAShapeLayer()
        haksickButtonLayer.path = UIBezierPath(roundedRect: haksickButton.bounds, byRoundingCorners: botCorner , cornerRadii: cornerRadi).CGPath
        haksickButton.layer.mask = haksickButtonLayer
        
        let schoolButtonLayer = CAShapeLayer()
        schoolButtonLayer.path = UIBezierPath(roundedRect: schoolBusButton.bounds, byRoundingCorners: botCorner, cornerRadii: cornerRadi).CGPath
        schoolBusButton.layer.mask = schoolButtonLayer
    }
}