//
//  TodayViewController.swift
//  AlgolWidget
//
//  Created by William Kim on 2015. 11. 10..
//  Copyright © 2015년 William Kim. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var widgetTimeLabel: UILabel?
    
    var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        print("widget view did load")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        
        print("widgetPerformUpdateWithCompletionHandler")
        // Perform any setup necessary in order to update the view.
        widgetTimeLabel?.text = "Still not sure!!!"
        if let label = widgetTimeLabel
        {
            widgetTimeLabel?.text = "Still not sure!!!!"
            let defaults = NSUserDefaults(suiteName: "group.io.jnw.Algol.AlgolWidget")
            widgetTimeLabel?.text = "Still not sure!!!!!!"
            if let timeString:String = defaults?.objectForKey("timeString") as? String
            {
                widgetTimeLabel?.text 
                if self.result != nil {
                    label.text = "You last ran the main app!!!"
                } else {
                    label.text = "You last ran the main app at: " + timeString
                }
                
                self.result = timeString
            }
        }
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.NewData)
    }
    
}
