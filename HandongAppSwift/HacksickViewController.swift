//
//  HacksickViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 5..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class HacksickViewController: UIViewController {
    let rootTag = "haksik"
    let dateTag = "date"
    let koteBreTag = "kotebre"
    let koteLunTag = "kotelun"
    let koteDinTag = "kotedin"
    
    let menuTag = "menu"
    let priceTag = "price"
    
    let fryTag = "fryfry"
    let noodTag = "noodle"
    let haoTag = "hao"
    let graTag = "grace"
    let mixTag = "mix"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var hacksickItem: HacksickModel?
    var itemYPos: Double = 0.0
    var boxYPos: Double = 2.0
    
    var actInd = UIActivityIndicatorView()
    
    func noDataHandler() {
        let backColor = UIColor(red: 0.9843, green: 0.8196, blue: 0.2509, alpha: 0.2)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        // ADD No DATA Label
        let noDataLabel = UILabel(frame: CGRect(x: 5.0, y: 5.0, width: screenWidth - 10, height: 100.0))
        
        noDataLabel.backgroundColor = backColor
        noDataLabel.numberOfLines = 0
        noDataLabel.text = "금일 식단정보가 없습니다.\n학생식당 운영 여부를 확인해주시기 바랍니다."
        
        self.scrollView.addSubview(noDataLabel)
        
        // Loading END
        Util.hideActivityIndicator(&self.actInd)
    }
    
    func makeViewWithData() {
        if self.hacksickItem == nil {
            self.noDataHandler()
            return
        }
        let backColor = UIColor(red: 0.9843, green: 0.8196, blue: 0.2509, alpha: 0.2)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        
        // KO TA
        let kotaCont = UIView(frame: CGRectZero)
        
        let kotaHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        kotaHead.text = "Korean Table"
        kotaHead.font = UIFont(name: kotaHead.font.fontName, size: 19)
        
        kotaCont.addSubview(kotaHead)
        
        let kotaDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        kotaDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        kotaCont.addSubview(kotaDivBar)
        
        // ko ta Breakfast
        let morningLabel = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        morningLabel.text = "아침"
        
        kotaCont.addSubview(morningLabel)
        
        var lineCount = Double(hacksickItem!.breakfast.menu.componentsSeparatedByString("\n").count * 25)

        let morningMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        morningMenuLabel.text = hacksickItem?.breakfast.menu
        morningMenuLabel.numberOfLines = 0
        morningMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        kotaCont.addSubview(morningMenuLabel)
        
        let morningPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        morningPriceLabel.text = hacksickItem?.breakfast.price
        morningPriceLabel.numberOfLines = 0
        morningPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        kotaCont.addSubview(morningPriceLabel)
        
        // ko ta Lunch
        let lunchLabel = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        lunchLabel.text = "점심"
        
        kotaCont.addSubview(lunchLabel)
        
        lineCount = Double(hacksickItem!.lunch.menu.componentsSeparatedByString("\n").count * 25)
        
        let lunchMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        lunchMenuLabel.text = hacksickItem?.lunch.menu
        lunchMenuLabel.numberOfLines = 0
        lunchMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        kotaCont.addSubview(lunchMenuLabel)
        
        let lunchPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        lunchPriceLabel.text = hacksickItem?.lunch.price
        lunchPriceLabel.numberOfLines = 0
        lunchPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        kotaCont.addSubview(lunchPriceLabel)
        
        
        // ko ta Dinner
        let dinnerLabel = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        dinnerLabel.text = "저녁"
        
        kotaCont.addSubview(dinnerLabel)
        
        lineCount = Double(hacksickItem!.dinner.menu.componentsSeparatedByString("\n").count * 25)
        
        let dinnerMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        dinnerMenuLabel.text = hacksickItem?.dinner.menu
        dinnerMenuLabel.numberOfLines = 0
        dinnerMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        kotaCont.addSubview(dinnerMenuLabel)
        
        let dinnerPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        dinnerPriceLabel.text = hacksickItem?.dinner.price
        dinnerPriceLabel.numberOfLines = 0
        dinnerPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        kotaCont.addSubview(dinnerPriceLabel)
        
        // add Container View to Scroll View
        kotaCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        kotaCont.backgroundColor = backColor
        kotaCont.opaque = true
        self.scrollView.addSubview(kotaCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        
        // FRY FRY
        let fryCont = UIView(frame: CGRectZero)
        
        let fryHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        fryHead.text = "Fry Fry"
        fryHead.font = UIFont(name: fryHead.font.fontName, size: 19)
        
        fryCont.addSubview(fryHead)
        
        let fryDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        fryDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        fryCont.addSubview(fryDivBar)
        
        lineCount = Double(hacksickItem!.fryFry.menu.componentsSeparatedByString("\n").count * 25)
        
        let fryMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        fryMenuLabel.text = hacksickItem?.fryFry.menu
        fryMenuLabel.numberOfLines = 0
        fryMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        fryCont.addSubview(fryMenuLabel)
        
        let fryPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        fryPriceLabel.text = hacksickItem?.fryFry.price
        fryPriceLabel.numberOfLines = 0
        fryPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        fryCont.addSubview(fryPriceLabel)
        
        // add Container View to Scroll View
        fryCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        fryCont.backgroundColor = backColor
        fryCont.opaque = true
        self.scrollView.addSubview(fryCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // Noodle ROAD
        let noodleCont = UIView(frame: CGRectZero)
        
        let noodleHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        noodleHead.text = "Noodle Road"
        noodleHead.font = UIFont(name: noodleHead.font.fontName, size: 19)
        
        noodleCont.addSubview(noodleHead)
        
        let noodleDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        noodleDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        noodleCont.addSubview(noodleDivBar)
        
        lineCount = Double(hacksickItem!.noodleRoad.menu.componentsSeparatedByString("\n").count * 25)
        
        let noodleMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        noodleMenuLabel.text = hacksickItem?.noodleRoad.menu
        noodleMenuLabel.numberOfLines = 0
        noodleMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        noodleCont.addSubview(noodleMenuLabel)
        
        let noodlePriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        noodlePriceLabel.text = hacksickItem?.noodleRoad.price
        noodlePriceLabel.numberOfLines = 0
        noodlePriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        noodleCont.addSubview(noodlePriceLabel)
        
        // add Container View to Scroll View
        noodleCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        noodleCont.backgroundColor = backColor
        noodleCont.opaque = true
        self.scrollView.addSubview(noodleCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // HAO
        let haoCont = UIView(frame: CGRectZero)
        
        let haoHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        haoHead.text = "Hao"
        haoHead.font = UIFont(name: haoHead.font.fontName, size: 19)
        
        haoCont.addSubview(haoHead)
        
        let haoDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        haoDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        haoCont.addSubview(haoDivBar)
        
        lineCount = Double(hacksickItem!.hao.menu.componentsSeparatedByString("\n").count * 25)
        
        let haoMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        haoMenuLabel.text = hacksickItem?.hao.menu
        haoMenuLabel.numberOfLines = 0
        haoMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        haoCont.addSubview(haoMenuLabel)
        
        let haoPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        haoPriceLabel.text = hacksickItem?.hao.price
        haoPriceLabel.numberOfLines = 0
        haoPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        haoCont.addSubview(haoPriceLabel)
        
        // add Container View to Scroll View
        haoCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        haoCont.backgroundColor = backColor
        haoCont.opaque = true
        self.scrollView.addSubview(haoCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // GraceGarden
        let graceCont = UIView(frame: CGRectZero)
        
        let graceHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        graceHead.text = "Grace Garden"
        graceHead.font = UIFont(name: graceHead.font.fontName, size: 19)
        
        graceCont.addSubview(graceHead)
        
        let graceDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        graceDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        graceCont.addSubview(graceDivBar)
        
        lineCount = Double(hacksickItem!.graceGarden.menu.componentsSeparatedByString("\n").count * 25)
        
        let graceMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        graceMenuLabel.text = hacksickItem?.graceGarden.menu
        graceMenuLabel.numberOfLines = 0
        graceMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        graceCont.addSubview(graceMenuLabel)
        
        let gracePriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        gracePriceLabel.text = hacksickItem?.graceGarden.price
        gracePriceLabel.numberOfLines = 0
        gracePriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        graceCont.addSubview(gracePriceLabel)
        
        // add Container View to Scroll View
        graceCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        graceCont.backgroundColor = backColor
        graceCont.opaque = true
        self.scrollView.addSubview(graceCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // Mix RICE
        let mixCont = UIView(frame: CGRectZero)
        
        let mixHead = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 32.0
        
        mixHead.text = "Mix Rice"
        mixHead.font = UIFont(name: mixHead.font.fontName, size: 19)
        
        mixCont.addSubview(mixHead)
        
        let mixDivBar = UIView(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth - 30.0, height: 1))
        mixDivBar.backgroundColor = UIColor.darkGrayColor()
        self.itemYPos += 2.0
        
        mixCont.addSubview(mixDivBar)
        
        lineCount = Double(hacksickItem!.mixRice.menu.componentsSeparatedByString("\n").count * 25)
        
        let mixMenuLabel = UILabel(frame: CGRect(x: 8.0, y: self.itemYPos, width: screenWidth/4*3 - 8, height: lineCount))
        mixMenuLabel.text = hacksickItem?.mixRice.menu
        mixMenuLabel.numberOfLines = 0
        mixMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        mixCont.addSubview(mixMenuLabel)
        
        let mixPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        mixPriceLabel.text = hacksickItem?.mixRice.price
        mixPriceLabel.numberOfLines = 0
        mixPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        mixCont.addSubview(mixPriceLabel)
        
        // add Container View to Scroll View
        mixCont.frame = CGRect(x: 10.0, y: self.boxYPos, width: screenWidth - 20.0, height: itemYPos)
        mixCont.backgroundColor = backColor
        mixCont.opaque = true
        self.scrollView.addSubview(mixCont)
        
        self.boxYPos += self.itemYPos + 5.0
        self.itemYPos = 0.0
        
        
        // Loading END
        Util.hideActivityIndicator(&self.actInd)
        self.scrollView.contentSize = CGSizeMake(CGFloat(screenWidth), CGFloat(self.boxYPos))
    }
    
    override func viewDidLoad() {
        Util.showActivityIndicatory(self.view, indicator: &self.actInd)
        
        dateSetter()
        
        let data = Util.readFile(Util.TodaysHacksickInfoName)
        if data != nil {
            self.parseHacksickXML(data!)
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
    
    func parseHacksickXML(data: NSString) {
        let xmlDom = SWXMLHash.parse(data as String)
        
        hacksickItem = HacksickModel(date: xmlDom[rootTag][dateTag].element!.text!,
            breakfast: xmlDom[rootTag][koteBreTag][menuTag].element!.text,
            breakfastPrice: xmlDom[rootTag][koteBreTag][priceTag].element!.text,
            lunch: xmlDom[rootTag][koteLunTag][menuTag].element!.text,
            lunchPrice: xmlDom[rootTag][koteLunTag][priceTag].element!.text,
            dinner: xmlDom[rootTag][koteDinTag][menuTag].element!.text,
            dinnerPrice: xmlDom[rootTag][koteDinTag][priceTag].element!.text,
            fryFry: xmlDom[rootTag][fryTag][menuTag].element!.text,
            fryFryPrice: xmlDom[rootTag][fryTag][priceTag].element!.text,
            noodleRoad: xmlDom[rootTag][noodTag][menuTag].element!.text,
            noodleRoadPrice: xmlDom[rootTag][noodTag][priceTag].element!.text,
            hao: xmlDom[rootTag][haoTag][menuTag].element!.text,
            haoPrice: xmlDom[rootTag][haoTag][priceTag].element!.text,
            graceGarden: xmlDom[rootTag][graTag][menuTag].element!.text,
            graceGardenPrice: xmlDom[rootTag][graTag][priceTag].element!.text,
            mixRice: xmlDom[rootTag][mixTag][menuTag].element!.text,
            mixRicePrice: xmlDom[rootTag][mixTag][priceTag].element!.text)
    }
}