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
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dustLabel: UILabel!
    @IBOutlet weak var imgWater: UIImageView!
    @IBOutlet weak var imgTemperature: UIImageView!
    @IBOutlet weak var imgDust: UIImageView!
    @IBOutlet weak var loadingWater: UIActivityIndicatorView!
    @IBOutlet weak var loadingTemperature: UIActivityIndicatorView!
    @IBOutlet weak var loadingDust: UIActivityIndicatorView!
    
    var x:Int = 1;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleRefreshAnimation(true)
        getData()
        self.preferredContentSize = CGSize(width: 0, height: 248);
        // Do any additional setup after loading the view from its nib.
        print("widget view did load")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startLoading() {
        temperatureLabel?.isHidden = true
        print("\(temperatureLabel.isHidden)")
        humidityLabel?.isHidden = true
        dustLabel?.isHidden = true
        imgWater?.isHidden = true
        imgTemperature?.isHidden = true
        imgDust?.isHidden = true
        
        loadingWater?.startAnimating()
        loadingTemperature?.startAnimating()
        loadingDust?.startAnimating()
        print("Start Loading")
    }
    
    func stopLoading() {
        temperatureLabel?.isHidden = false
        humidityLabel?.isHidden = false
        dustLabel?.isHidden = false
        imgWater?.isHidden = false
        imgTemperature?.isHidden = false
        imgDust?.isHidden = false
        
        loadingWater?.stopAnimating()
        loadingTemperature?.stopAnimating()
        loadingDust?.stopAnimating()
        print("Stop Loading")
    }
    
    func toggleRefreshAnimation(_ on: Bool) {
        if on {
            startLoading()
        } else {
            let delta: Int64 = 1 * Int64(NSEC_PER_SEC)
            let time = DispatchTime.now() + Double(delta) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                self.stopLoading()
            });
        }
    }
    
    func getData(_ completionHandler: ((NCUpdateResult) -> Void)?=nil) {
        print("START: WeatherViewController.getData")
        let _now: Date = Date()
        let now: Date = _now.addingTimeInterval(60 * 60 * 9)
        print(now)
        dateLabel!.text = "TODAY, \(now)"
        let queue = TaskQueue()
        
        // Town
        queue.tasks +=~ {
        }
        
        // Home
        queue.tasks +=~ {
            print("getData")
            SwaggerClientAPI.HomeAPI.homeGet(location: Double(2)).execute { (response, error) in
                if response!.statusCode == 200,
                    let home: Home = response!.body as Home {
                        let temperature: String = String(format: "%.1f", home.temperature!)
                        let humidity: String = String(format: "%.1f", home.humidity!)
                        let dust: String = String(format: "%.1f", home.dust!)
                        self.temperatureLabel!.text = "\(temperature)º";
                        self.humidityLabel!.text = "\(humidity)%";
                        self.dustLabel!.text = "\(dust)㎍";
                }
                self.toggleRefreshAnimation(false)
            }
        }
        
        queue.run()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        print("widgetPerformUpdateWithCompletionHandler")
        // Perform any setup necessary in order to update the view.
        widgetTimeLabel?.text = "Still not sure!!!"

        getData(completionHandler)
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
    }

    @IBAction func btnRefresh(_ sender: AnyObject) {
        toggleRefreshAnimation(true)
        getData()
    }
    
    // Layout
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}
