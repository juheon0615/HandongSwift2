//
//  File.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 6..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MomsViewController: UIViewController {
    let rootTag = "moms"
    let itemTag = "menu"
    let dateTag = "date"
    let breTag = "breakfast"
    let lunDinTag = "lunNdin"
    
    let menuTag = "name"
    let priceTag = "price"
    
    var itemYPos: Double = 0.0
    var boxYPos: Double = 2.0
    var momsItem = Array<MomsModel>()
    var idx: Int?
    
    var actInd = UIActivityIndicatorView()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        Util.showActivityIndicatory(self.view, indicator: &self.actInd)
        
        dateSetter()
        
        let data = Util.readFile(Util.TodaysMomsInfoName)
        if data != nil {
            self.parseMomsXML(data!)
        }
        self.makeViewWithData()
    }
    
    func dateSetter() {
        let today = Util.getToday()
        
        let weekdayString = Util.weekdayChanger(today.weekday) + "요일"
        let monthString = String(today.month) + "월 "
        let dateString = String(today.day) + "일 "
        self.dateLabel.text = monthString + dateString + weekdayString
    }
    
    func noDataHandler() {
        let backColor = UIColor(red: 0.9843, green: 0.8196, blue: 0.2509, alpha: 0.2)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        // ADD No DATA Label
        let noDataLabel = UILabel(frame: CGRect(x: 5.0, y: 5.0, width: screenWidth - 10, height: 100.0))
        
        noDataLabel.backgroundColor = backColor
        noDataLabel.numberOfLines = 0
        noDataLabel.text = "금일 식단정보가 없습니다.\n맘스키친 운영 여부를 확인해주시기 바랍니다."
        
        self.scrollView.addSubview(noDataLabel)
        
        // Loading END
        Util.hideActivityIndicator(&self.actInd)
    }
    
    func parseMomsXML(data: NSString) {
        let xmlDom = SWXMLHash.parse(data)
        
        var alldayMenuCount = xmlDom[rootTag][itemTag].all.count
        
        for i in 0 ..< alldayMenuCount {
            let model = MomsModel(
                date: xmlDom[rootTag][itemTag][i][dateTag].element!.text!,
                breakfast: xmlDom[rootTag][itemTag][i][breTag][menuTag].element!.text,
                breakfastPrice: xmlDom[rootTag][itemTag][i][breTag][priceTag].element!.text,
                lunchDinner: xmlDom[rootTag][itemTag][i][lunDinTag][menuTag].element!.text,
                lunchDinnerPrice: xmlDom[rootTag][itemTag][i][lunDinTag][priceTag].element!.text)
            
            momsItem.append(model)
        }
    }
    
    func makeViewWithData() {
        if self.momsItem.count == 0 {
            self.noDataHandler()
            return
        }
        
        if self.idx == nil {
            
            let today = Util.getToday()
            self.idx = -1
            
            for i in 0 ..< self.momsItem.count {
                if self.momsItem[i].month.toInt() == today.month && self.momsItem[i].date.toInt() == today.day {
                    idx = i
                    break
                }
            }
            
            if idx == -1 {
                // no data for today
                idx = nil
                
                self.noDataHandler()
                return
            }
        }
        
        let backColor = UIColor(red: 0.9843, green: 0.8196, blue: 0.2509, alpha: 0.2)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        
        // BREAKFAST
        let breCont = UIView(frame: CGRectZero)
        
        let breHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        breHead.text = "아침"
        breHead.font = UIFont(name: breHead.font.fontName, size: 19)
        
        breCont.addSubview(breHead)
        
        let breDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        breDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        breCont.addSubview(breDivBar)
        
        var lineCount = Double(momsItem[idx!].breakfast.menu.componentsSeparatedByString("\n").count * 25)
        
        let morningMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        morningMenuLabel.text = momsItem[idx!].breakfast.menu
        morningMenuLabel.numberOfLines = 0
        morningMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        breCont.addSubview(morningMenuLabel)
        
        let morningPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        morningPriceLabel.text = momsItem[idx!].breakfast.price
        morningPriceLabel.numberOfLines = 0
        morningPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        breCont.addSubview(morningPriceLabel)
        
        // add Container View to Scroll View
        breCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        breCont.backgroundColor = backColor
        breCont.opaque = true
        self.scrollView.addSubview(breCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // LUNCH && DINNER
        let ldCont = UIView(frame: CGRectZero)
        
        let ldHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        ldHead.text = "점심 & 저녁"
        ldHead.font = UIFont(name: ldHead.font.fontName, size: 19)
        
        ldCont.addSubview(ldHead)
        
        let ldDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        ldDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        ldCont.addSubview(ldDivBar)
        
        lineCount = Double(momsItem[idx!].lunchDinner.menu.componentsSeparatedByString("\n").count * 25)
        
        let ldMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        ldMenuLabel.text = momsItem[idx!].lunchDinner.menu
        ldMenuLabel.numberOfLines = 0
        ldMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        ldCont.addSubview(ldMenuLabel)
        
        let ldPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        ldPriceLabel.text = momsItem[idx!].lunchDinner.price
        ldPriceLabel.numberOfLines = 0
        ldPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        ldCont.addSubview(ldPriceLabel)
        
        // add Container View to Scroll View
        ldCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        ldCont.backgroundColor = backColor
        ldCont.opaque = true
        self.scrollView.addSubview(ldCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // Loading END
        Util.hideActivityIndicator(&self.actInd)
        self.scrollView.contentSize = CGSizeMake(CGFloat(screenWidth), CGFloat(self.boxYPos))
    }
}