//
//  LoadingViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 3..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var loadingImg: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rotationAni = CABasicAnimation()
        rotationAni.keyPath = "transform.rotation.z";
        rotationAni.toValue = NSNumber(double: M_PI * 2)
        rotationAni.duration = 2
        rotationAni.cumulative = true
        rotationAni.repeatCount = Float.infinity
        
        loadingImg.layer.addAnimation(rotationAni, forKey: "rotationAnimation")
    }
    
    override func viewDidAppear(animated: Bool) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("nextPage"), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func nextPage() {
        self.performSegueWithIdentifier("loadingDoneSegue", sender: self)
    }
}