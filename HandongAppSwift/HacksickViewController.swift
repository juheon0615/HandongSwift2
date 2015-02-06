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
    
    var actInd = UIActivityIndicatorView()
    
    func makeViewWithData() {
        if self.hacksickItem == nil {
            return
        }
        let weekdayString = Util.weekdayChanger(hacksickItem!.dayOfWeek)+"요일"
        let monthString = hacksickItem!.month + "월 "
        let dateString = hacksickItem!.date+"일 "
        dateLabel.text = monthString + dateString + weekdayString
        
        let grayColor = UIColor(red: 155, green: 159, blue: 161, alpha: 0)
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        
        
        // KO TA
        
        let kotaHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        kotaHead.backgroundColor = grayColor
        kotaHead.text = "Korean Table"
        
        self.scrollView.addSubview(kotaHead)
        
        
        // ko ta Breakfast
        
        let morningLabel = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        morningLabel.text = "아침"
        
        self.scrollView.addSubview(morningLabel)
        
        var lineCount = Double(hacksickItem!.breakfast.menu.componentsSeparatedByString("\n").count * 25)

        let morningMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        morningMenuLabel.text = hacksickItem?.breakfast.menu
        morningMenuLabel.numberOfLines = 0
        morningMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(morningMenuLabel)
        
        let morningPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        morningPriceLabel.text = hacksickItem?.breakfast.price
        morningPriceLabel.numberOfLines = 0
        morningPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(morningPriceLabel)
        
        
        // ko ta Lunch
        let lunchLabel = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        lunchLabel.text = "점심"
        
        self.scrollView.addSubview(lunchLabel)
        
        lineCount = Double(hacksickItem!.lunch.menu.componentsSeparatedByString("\n").count * 25)
        
        let lunchMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        lunchMenuLabel.text = hacksickItem?.lunch.menu
        lunchMenuLabel.numberOfLines = 0
        lunchMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(lunchMenuLabel)
        
        let lunchPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        lunchPriceLabel.text = hacksickItem?.lunch.price
        lunchPriceLabel.numberOfLines = 0
        lunchPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(lunchPriceLabel)
        
        
        // ko ta Dinner
        let dinnerLabel = UILabel(frame: CGRect(x: 5.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        dinnerLabel.text = "저녁"
        
        self.scrollView.addSubview(dinnerLabel)
        
        lineCount = Double(hacksickItem!.dinner.menu.componentsSeparatedByString("\n").count * 25)
        
        let dinnerMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        dinnerMenuLabel.text = hacksickItem?.dinner.menu
        dinnerMenuLabel.numberOfLines = 0
        dinnerMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(dinnerMenuLabel)
        
        let dinnerPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        dinnerPriceLabel.text = hacksickItem?.dinner.price
        dinnerPriceLabel.numberOfLines = 0
        dinnerPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(dinnerPriceLabel)
        
        
        // FRY FRY
        
        let fryHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        fryHead.backgroundColor = grayColor
        fryHead.text = "Fry Fry"
        
        self.scrollView.addSubview(fryHead)
        
        lineCount = Double(hacksickItem!.fryFry.menu.componentsSeparatedByString("\n").count * 25)
        
        let fryMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        fryMenuLabel.text = hacksickItem?.fryFry.menu
        fryMenuLabel.numberOfLines = 0
        fryMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(fryMenuLabel)
        
        let fryPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        fryPriceLabel.text = hacksickItem?.fryFry.price
        fryPriceLabel.numberOfLines = 0
        fryPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(fryPriceLabel)
        
        
        // Noodle ROAD
        let noodleHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        noodleHead.backgroundColor = grayColor
        noodleHead.text = "Noodle Road"
        
        self.scrollView.addSubview(noodleHead)
        
        lineCount = Double(hacksickItem!.noodleRoad.menu.componentsSeparatedByString("\n").count * 25)
        
        let noodleMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        noodleMenuLabel.text = hacksickItem?.noodleRoad.menu
        noodleMenuLabel.numberOfLines = 0
        noodleMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(noodleMenuLabel)
        
        let noodlePriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        noodlePriceLabel.text = hacksickItem?.noodleRoad.price
        noodlePriceLabel.numberOfLines = 0
        noodlePriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(noodlePriceLabel)
        
        
        // HAO
        let haoHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        haoHead.backgroundColor = grayColor
        haoHead.text = "Hao"
        
        self.scrollView.addSubview(haoHead)
        
        lineCount = Double(hacksickItem!.hao.menu.componentsSeparatedByString("\n").count * 25)
        
        let haoMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        haoMenuLabel.text = hacksickItem?.hao.menu
        haoMenuLabel.numberOfLines = 0
        haoMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(haoMenuLabel)
        
        let haoPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        haoPriceLabel.text = hacksickItem?.hao.price
        haoPriceLabel.numberOfLines = 0
        haoPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(haoPriceLabel)
        
        
        // GraceGarden
        let graceHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        graceHead.backgroundColor = grayColor
        graceHead.text = "Grace Garden"
        
        self.scrollView.addSubview(graceHead)
        
        lineCount = Double(hacksickItem!.graceGarden.menu.componentsSeparatedByString("\n").count * 25)
        
        let graceMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        graceMenuLabel.text = hacksickItem?.graceGarden.menu
        graceMenuLabel.numberOfLines = 0
        graceMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(graceMenuLabel)
        
        let gracePriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        gracePriceLabel.text = hacksickItem?.graceGarden.price
        gracePriceLabel.numberOfLines = 0
        gracePriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(gracePriceLabel)
        
        
        // Mix RICE
        let mixHead = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth, height: 30.0))
        self.itemYPos += 30.0
        
        mixHead.backgroundColor = grayColor
        mixHead.text = "Mix Rice"
        
        self.scrollView.addSubview(mixHead)
        
        lineCount = Double(hacksickItem!.mixRice.menu.componentsSeparatedByString("\n").count * 25)
        
        let mixMenuLabel = UILabel(frame: CGRect(x: 0.0, y: self.itemYPos, width: screenWidth/4*3, height: lineCount))
        mixMenuLabel.text = hacksickItem?.mixRice.menu
        mixMenuLabel.numberOfLines = 0
        mixMenuLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(mixMenuLabel)
        
        let mixPriceLabel = UILabel(frame: CGRect(x: screenWidth/4*3, y: self.itemYPos, width: screenWidth/4, height: lineCount))
        self.itemYPos += lineCount
        mixPriceLabel.text = hacksickItem?.mixRice.price
        mixPriceLabel.numberOfLines = 0
        mixPriceLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        self.scrollView.addSubview(mixPriceLabel)
        
        
        // Loading END
        self.actInd.stopAnimating()
        self.scrollView.contentSize = CGSizeMake(CGFloat(screenWidth), CGFloat(self.itemYPos))
    }
    
    override func viewDidLoad() {
        getDataXML()
        Util.showActivityIndicatory(self.view, indicator: &self.actInd)
    }
    
    func getDataXML() {
        let url = NSURL(string: Util.HacksickURL)!
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url, completionHandler:
            {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                self.parseHacksickXML(data)
                
                self.makeViewWithData()
        })
        dataTask.resume()
    }
    
    func parseHacksickXML(data: NSData) {
        let xmlDom = SWXMLHash.parse(data)
        
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