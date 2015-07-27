//
//  HyoamViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 6..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class HyoamViewController: UIViewController {
    let rootTag = "hyoam"
    let itemTag = "menu"
    let dateTag = "date"
    let specialTag = "special"
    let normalTag = "normal"
    
    let unitTag = "unit"
    let menuTag = "name"
    let priceTag = "price"
    
    var itemYPos: Double = 0.0
    var boxYPos: Double = 2.0
    var hyoamItem = Array<HyoamModel>()
    var idx: Int?
    
    var actInd = UIActivityIndicatorView()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        Util.showActivityIndicatory(self.view, indicator: &self.actInd)
        
        dateSetter()
        
        let data = Util.readFile(Util.TodaysHyoamInfoName)
        if data != nil {
            self.parseHyoamXML(data!)
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
    
    func parseHyoamXML(data: NSString) {
        let xmlDom = SWXMLHash.parse(data as String)
        
        var alldayMenuCount = xmlDom[rootTag][itemTag].all.count
        
        for i in 0 ..< alldayMenuCount {
            var allNormal = Array<String?>()
            var allNormalPrice = Array<String?>()
            
            let allNoramlTags = xmlDom[rootTag][itemTag][i][normalTag][unitTag].all
            for j in 0 ..< allNoramlTags.count {
                allNormal.append(allNoramlTags[j][menuTag].element!.text)
                allNormalPrice.append(allNoramlTags[j][priceTag].element!.text)
            }
            
            let model = HyoamModel(
                date: xmlDom[rootTag][itemTag][i][dateTag].element!.text!,
                special: xmlDom[rootTag][itemTag][i][specialTag][unitTag][menuTag].element!.text,
                specialPrice: xmlDom[rootTag][itemTag][i][specialTag][unitTag][priceTag].element!.text,
                normal: allNormal,
                normalPrice: allNormalPrice)
            
            hyoamItem.append(model)
        }
    }
    
    func noDataHandler() {
        let backColor = UIColor(red: 0.9843, green: 0.8196, blue: 0.2509, alpha: 0.2)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        // ADD No DATA Label
        let noDataLabel = UILabel(frame: CGRect(x: 5.0, y: 5.0, width: screenWidth - 10, height: 100.0))
        
        noDataLabel.backgroundColor = backColor
        noDataLabel.numberOfLines = 0
        noDataLabel.text = "금일 식단정보가 없습니다.\n또랑 운영 여부를 확인해주시기 바랍니다.\n(전화 :054-260-1267)"
        
        self.scrollView.addSubview(noDataLabel)
        
        // Loading END
        Util.hideActivityIndicator(&self.actInd)
    }
    
    func makeViewWithData() {
        if self.hyoamItem.count == 0 {
            self.noDataHandler()
            return
        }
        
        if self.idx == nil {
            let today = Util.getToday()
            self.idx = -1
            
            for i in 0 ..< self.hyoamItem.count {
                if self.hyoamItem[i].month.toInt() == today.month && self.hyoamItem[i].date.toInt() == today.day {
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
        
        
        // SPECIAL MENU
        let specialCont = UIView(frame: CGRectZero)
        
        let specialHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        specialHead.text = "특선"
        specialHead.font = UIFont(name: specialHead.font.fontName, size: 19)
        
        specialCont.addSubview(specialHead)
        
        let specialDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        specialDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        specialCont.addSubview(specialDivBar)
        
        let specialMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: 30.0))
        specialMenuLabel.text = hyoamItem[idx!].special.menu
        specialMenuLabel.numberOfLines = 0
        specialMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        specialCont.addSubview(specialMenuLabel)
        
        let specialPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: 30.0))
        self.itemYPos += 30.0
        specialPriceLabel.text = hyoamItem[idx!].special.price
        specialPriceLabel.numberOfLines = 0
        specialPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        specialCont.addSubview(specialPriceLabel)
        
        // add Container View to Scroll View
        specialCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        specialCont.backgroundColor = backColor
        specialCont.opaque = true
        self.scrollView.addSubview(specialCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // NORMAL MENUs
        let normalCont = UIView(frame: CGRectZero)
        
        let normalHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        normalHead.text = "일반메뉴"
        normalHead.font = UIFont(name: normalHead.font.fontName, size: 19)
        
        normalCont.addSubview(normalHead)
        
        let normalDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        normalDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        normalCont.addSubview(normalDivBar)
        
        var lineCount: Double = 0.0
        for i in 0 ..< hyoamItem[idx!].normal.count {
            lineCount = Double(hyoamItem[idx!].normal[i].menu.componentsSeparatedByString("\n").count * 25)
            
            let normalMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
            normalMenuLabel.text = hyoamItem[idx!].normal[i].menu
            normalMenuLabel.numberOfLines = 0
            normalMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            
            normalCont.addSubview(normalMenuLabel)
            
            let normalPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
            self.itemYPos += lineCount
            normalPriceLabel.text = hyoamItem[idx!].normal[i].price
            normalPriceLabel.numberOfLines = 0
            normalPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            
            normalCont.addSubview(normalPriceLabel)
        }
        
        // add Container View to Scroll View
        normalCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        normalCont.backgroundColor = backColor
        normalCont.opaque = true
        self.scrollView.addSubview(normalCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0

        
        
        // Loading END
        Util.hideActivityIndicator(&self.actInd)
        self.scrollView.contentSize = CGSizeMake(CGFloat(screenWidth), CGFloat(self.boxYPos))
    }
}