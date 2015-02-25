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
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var hgushopButton: UIButton!
    @IBOutlet weak var hgutubeButton: UIButton!
    @IBOutlet weak var convButton: UIButton!
    @IBOutlet weak var noticeButton: UIButton!
    
    @IBOutlet weak var timetableButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var sixwayHorBar: UILabel!
    @IBOutlet weak var schoolHorBar: UILabel!
    
    @IBOutlet weak var isWeekendSixLabel: UILabel!
    @IBOutlet weak var isWeekendSchoolLabel: UILabel!
    
    @IBOutlet weak var ghostLogo: UIButton!
    
    var initFlag = InitializeFlag.sharedInstance
    
    override func viewDidLoad() {
        if initFlag.flag == true {
            // data loaded properly
            initFlag.flag = false
        } else {
            // proper handling needed
        }
    }
    
    override func viewDidLayoutSubviews() {
        yasickButton.sizeToFit()
        haksickButton.sizeToFit()
        sixwayBusButton.sizeToFit()
        schoolBusButton.sizeToFit()
        
        noticeButton.sizeToFit()
        convButton.sizeToFit()
        hgutubeButton.sizeToFit()
        hgushopButton.sizeToFit()
        alarmButton.sizeToFit()
        settingButton.sizeToFit()
        
        timetableButton.sizeToFit()
        otherButton.sizeToFit()
        
        self.makeButtonRound()
        
        self.setBusTime()
        
        // Change label for weekend
        if Util.isWeekendToday() {
            isWeekendSchoolLabel.text = "(주말)"
            isWeekendSixLabel.text = "(주말)"
            
            isWeekendSchoolLabel.textColor = UIColor.redColor()
            isWeekendSixLabel.textColor = UIColor.redColor()
        }
        
        // logo multiple touch
        let multipleTapGesture = UITapGestureRecognizer(target: self, action: "logoTouchEvent:")
        multipleTapGesture.numberOfTapsRequired = 4
        ghostLogo.addGestureRecognizer(multipleTapGesture)
    }
    
    func makeButtonRound() {
        // make round corner button
        let topCorner = UIRectCorner(UIRectCorner.TopLeft.rawValue|UIRectCorner.TopRight.rawValue)
        let botCorner = UIRectCorner(UIRectCorner.BottomLeft.rawValue|UIRectCorner.BottomRight.rawValue)
        let cornerRadi = CGSize(width: 5.0, height: 5.0)
        
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
        
        
        // middle
        let ltLayer = CAShapeLayer()
        ltLayer.path = UIBezierPath(roundedRect: noticeButton.bounds, byRoundingCorners: UIRectCorner.TopLeft, cornerRadii: cornerRadi).CGPath
        noticeButton.layer.mask = ltLayer
        
        let rtLayer = CAShapeLayer()
        rtLayer.path = UIBezierPath(roundedRect: hgutubeButton.bounds, byRoundingCorners: UIRectCorner.TopRight, cornerRadii: cornerRadi).CGPath
        hgutubeButton.layer.mask = rtLayer
        
        let lbLayer = CAShapeLayer()
        lbLayer.path = UIBezierPath(roundedRect: hgushopButton.bounds, byRoundingCorners: UIRectCorner.BottomLeft, cornerRadii: cornerRadi).CGPath
        hgushopButton.layer.mask = lbLayer
        
        let rbLayer = CAShapeLayer()
        rbLayer.path = UIBezierPath(roundedRect: settingButton.bounds, byRoundingCorners: UIRectCorner.BottomRight, cornerRadii: cornerRadi).CGPath
        settingButton.layer.mask = rbLayer
        
        
        // bottom
        let leftCorner = UIRectCorner(UIRectCorner.TopLeft.rawValue|UIRectCorner.BottomLeft.rawValue)
        let rightCorner = UIRectCorner(UIRectCorner.TopRight.rawValue|UIRectCorner.BottomRight.rawValue)

        let lLayer = CAShapeLayer()
        lLayer.path = UIBezierPath(roundedRect: timetableButton.bounds, byRoundingCorners: leftCorner, cornerRadii: cornerRadi).CGPath
        timetableButton.layer.mask = lLayer
        
        let rLayer = CAShapeLayer()
        rLayer.path = UIBezierPath(roundedRect: otherButton.bounds, byRoundingCorners: rightCorner, cornerRadii: cornerRadi).CGPath
        otherButton.layer.mask = rLayer
    }
    
    func setBusTime() {
        var itemYPos = self.sixwayHorBar.frame.origin.y - self.sixwayBusButton.frame.origin.y + 3
        var itemHeight = (self.sixwayBusButton.frame.height - itemYPos - 5) / CGFloat(4)
        
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
        
        
        itemYPos += itemHeight
        
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
            
            
            itemYPostTemp += itemHeight
        }
        
        for data in mainBus.toSix {
            // add toSix time table label
            let fstLabel = MainBusUILabel(frame: CGRect(x: 0.0, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: data.school)
            self.sixwayBusButton.addSubview(fstLabel)
            
            let sndLabel = MainBusUILabel(frame: CGRect(x: labelWidth + 10, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: data.hwan)
            self.sixwayBusButton.addSubview(sndLabel)
            
            let trdLabel = MainBusUILabel(frame: CGRect(x: (labelWidth + 10)*2, y: CGFloat(itemYPos), width: labelWidth, height: itemHeight), text: data.six)
            self.sixwayBusButton.addSubview(trdLabel)
            
            
            itemYPos += itemHeight
        }
    }
    
    func logoTouchEvent(sender: UITapGestureRecognizer) {
        var alert = UIAlertController(title: "데이터 초기화", message: "어플리케이션 내부 데이터를 초기화 합니다.\n초기화 후 어플리케이션을 완전히 종료, 재시작해야 데이터를 갱신할 수 있습니다.\n계속 하시겠습니까?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "계속", style: UIAlertActionStyle.Default, handler: {action in
            switch action.style{
            case .Default:
                Util.clearAllStoredData()
            case .Cancel:
                break
            case .Destructive:
                break
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}