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
    
    @IBOutlet weak var isWeekendSixLabel: UILabel!
    @IBOutlet weak var isWeekendSchoolLabel: UILabel!
    
    override func viewDidLoad() {
        
        self.makeButtonRound()
        
        self.setBusTime()
        
        // Change label for weekend
        if Util.isWeekendToday() {
            isWeekendSchoolLabel.text = "(주말)"
            isWeekendSixLabel.text = "(주말)"
            
            isWeekendSchoolLabel.textColor = UIColor.redColor()
            isWeekendSixLabel.textColor = UIColor.redColor()
        }
    }
    
    func makeButtonRound() {
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
    
    func setBusTime() {
        var itemYPos = 35.0
        var itemHeight = (self.schoolBusButton.frame.height - CGFloat(itemYPos) - 5.0) / CGFloat(4)
        
        // INIT top label
        let tableWidth = self.schoolBusButton.frame.width
        let labelWidth = (tableWidth-20)/3.0
        // add school top label
        let fstLabel = MainBusUILabel(frame: CGRect(x: 0.0, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: "육거리")
        self.schoolBusButton.addSubview(fstLabel)
        
        let sndLabel = MainBusUILabel(frame: CGRect(x: labelWidth + 10, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: "환호동")
        self.schoolBusButton.addSubview(sndLabel)
        
        let trdLabel = MainBusUILabel(frame: CGRect(x: (labelWidth + 10)*2, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: "학교")
        self.schoolBusButton.addSubview(trdLabel)
        
        
        
        // add six top label
        let fstLabel2 = MainBusUILabel(frame: CGRect(x: 0.0, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: "학교")
        self.sixwayBusButton.addSubview(fstLabel2)
        
        let sndLabel2 = MainBusUILabel(frame: CGRect(x: labelWidth + 10, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: "환호동")
        self.sixwayBusButton.addSubview(sndLabel2)
        
        let trdLabel2 = MainBusUILabel(frame: CGRect(x: (labelWidth + 10)*2, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: "육거리")
        self.sixwayBusButton.addSubview(trdLabel2)
        
        
        
        itemYPos += Double(itemHeight)
        
        var itemYPostTemp = itemYPos
        // add time table
        let mainBus = MainBusModel.sharedInstance
        
        for data in mainBus.toSchool {
            // add toSchool time table label
            let fstLabel = MainBusUILabel(frame: CGRect(x: 0.0, y: CGFloat(itemYPostTemp), width: labelWidth, height: itemHeight), text: data.six)
            self.schoolBusButton.addSubview(fstLabel)
            
            let sndLabel = MainBusUILabel(frame: CGRect(x: labelWidth + 10, y: CGFloat(itemYPostTemp), width: labelWidth, height: itemHeight), text: data.hwan)
            self.schoolBusButton.addSubview(sndLabel)
            
            let trdLabel = MainBusUILabel(frame: CGRect(x: (labelWidth + 10)*2, y: CGFloat(itemYPostTemp), width: labelWidth, height: itemHeight), text: data.school)
            self.schoolBusButton.addSubview(trdLabel)
            
            
            itemYPostTemp += Double(itemHeight)
        }
        
        for data in mainBus.toSix {
            // add toSchool time table label
            let fstLabel = MainBusUILabel(frame: CGRect(x: 0.0, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: data.school)
            self.sixwayBusButton.addSubview(fstLabel)
            
            let sndLabel = MainBusUILabel(frame: CGRect(x: labelWidth + 10, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: data.hwan)
            self.sixwayBusButton.addSubview(sndLabel)
            
            let trdLabel = MainBusUILabel(frame: CGRect(x: (labelWidth + 10)*2, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: data.six)
            self.sixwayBusButton.addSubview(trdLabel)
            
            
            itemYPos += Double(itemHeight)
        }
    }
}