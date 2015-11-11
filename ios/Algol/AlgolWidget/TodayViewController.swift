//
//  TodayViewController.swift
//  AlgolWidget
//
//  Created by William Kim on 2015. 11. 10..
//  Copyright © 2015년 William Kim. All rights reserved.
//

import UIKit
import NotificationCenter
import Alamofire
import RxSwift

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var widgetTimeLabel: UILabel?
    
    
    var x:Int = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        print("widget view did load")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSensor() {
        SwaggerClientAPI.HomeAPI.homeGet(location: Double(2)).execute { (response, error) in
            if response!.statusCode == 200,
                let home: Home = response!.body as Home {
                    self.homeLabel!.text = "\(home.home_id!)"
                    self.temperatureLabel!.text = "\(home.temperature!)º"
                    self.humidityLabel!.text = "\(home.humidity!)%"
                    self.dustLabel!.text = "\(home.dust!)"
                    
                    widgetTimeLabel?.text = "\(NSDate.init()) \n dust: \(home.dust!)"
            }
        }
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        
        print("widgetPerformUpdateWithCompletionHandler")
        // Perform any setup necessary in order to update the view.
        widgetTimeLabel?.text = "Still not sure!!!"

        self.getSensor()
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.NewData)
    }

    @IBAction func btnRefresh(sender: AnyObject) {
        self.getSensor()
    }
    
}
