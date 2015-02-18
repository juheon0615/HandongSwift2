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
    var hyoamItem = Array<HyoamModel>()
    var idx: Int?
    
    var actInd = UIActivityIndicatorView()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        Util.showActivityIndicatory(self.view, indicator: &self.actInd)
        getDataXML()
        dateSetter()
    }
    
    func dateSetter() {
        let today = Util.getToday()
        
        let weekdayString = Util.weekdayChanger(today.weekday) + "요일"
        let monthString = String(today.month) + "월 "
        let dateString = String(today.day) + "일 "
        self.dateLabel.text = monthString + dateString + weekdayString
    }
    
    func getDataXML() {
        let url = NSURL(string: Util.HyoamthetableURL)!
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url, completionHandler:
            {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                self.parseHyoamXML(data)
                
                self.makeViewWithData()
        })
        dataTask.resume()
    }
    
    func parseHyoamXML(data: NSData) {
        let xmlDom = SWXMLHash.parse(data)
        
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
        let grayColor = UIColor(red: 155, green: 159, blue: 161, alpha: 0)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        // ADD No DATA Label
        let noDataLabel = UILabel(frame: CGRect(x: 5.0, y: 5.0, width: screenWidth - 10, height: 100.0))
        
        noDataLabel.backgroundColor = grayColor
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
        
        let grayColor = UIColor(red: 155, green: 159, blue: 161, alpha: 0)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        
        // SPECIAL MENU
        
        let specialHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        specialHead.backgroundColor = grayColor
        specialHead.text = "특선"
        
        self.scrollView.addSubview(specialHead)
        
        let specialMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: 30.0))
        specialMenuLabel.text = hyoamItem[idx!].special.menu
        specialMenuLabel.numberOfLines = 0
        specialMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(specialMenuLabel)
        
        let specialPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: 30.0))
        self.itemYPos += 30.0
        specialPriceLabel.text = hyoamItem[idx!].special.price
        specialPriceLabel.numberOfLines = 0
        specialPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(specialPriceLabel)
        
        
        // NORMAL MENUs
        
        let normalHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        normalHead.backgroundColor = grayColor
        normalHead.text = "일반메뉴"
        
        self.scrollView.addSubview(normalHead)
        
        var lineCount: Double = 0.0
        for i in 0 ..< hyoamItem[idx!].normal.count {
            lineCount = Double(hyoamItem[idx!].normal[i].menu.componentsSeparatedByString("\n").count * 25)
            
            let normalMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
            normalMenuLabel.text = hyoamItem[idx!].normal[i].menu
            normalMenuLabel.numberOfLines = 0
            normalMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            
            self.scrollView.addSubview(normalMenuLabel)
            
            let normalPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
            self.itemYPos += lineCount
            normalPriceLabel.text = hyoamItem[idx!].normal[i].price
            normalPriceLabel.numberOfLines = 0
            normalPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            
            self.scrollView.addSubview(normalPriceLabel)
        }

        
        
        // Loading END
        Util.hideActivityIndicator(&self.actInd)
        self.scrollView.contentSize = CGSizeMake(CGFloat(screenWidth), CGFloat(self.itemYPos))
    }
}