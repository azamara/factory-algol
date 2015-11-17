//
//  WeatherViewController.swift
//  Algol
//
//  Created by William Kim on 2015. 11. 14..
//  Copyright © 2015년 William Kim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RxSwift

class WeatherViewController: UIViewController {
    
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

    func getData() {
        print("START: WeatherViewController.getData")
        let _now: NSDate = NSDate()
        let now: NSDate = _now.dateByAddingTimeInterval(60 * 60 * 9)
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
    
    func startLoading() {
        temperatureLabel?.hidden = true
        print("\(temperatureLabel.hidden)")
        humidityLabel?.hidden = true
        dustLabel?.hidden = true
        imgWater?.hidden = true
        imgTemperature?.hidden = true
        imgDust?.hidden = true
        
        loadingWater?.startAnimating()
        loadingTemperature?.startAnimating()
        loadingDust?.startAnimating()
        print("Start Loading")
    }
    
    func stopLoading() {
        temperatureLabel?.hidden = false
        humidityLabel?.hidden = false
        dustLabel?.hidden = false
        imgWater?.hidden = false
        imgTemperature?.hidden = false
        imgDust?.hidden = false

        loadingWater?.stopAnimating()
        loadingTemperature?.stopAnimating()
        loadingDust?.stopAnimating()
        print("Stop Loading")
    }
    
    func toggleRefreshAnimation(on: Bool) {
        if on {
            startLoading()
        } else {
            let delta: Int64 = 1 * Int64(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, delta)
            
            dispatch_after(time, dispatch_get_main_queue(), {
                self.stopLoading()
            });
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JTSplashView.splashViewWithBackgroundColor(nil, circleColor: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), circleSize: nil)
        // Simulate state when we want to hide the splash view
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("hideSplashView"), userInfo: nil, repeats: false)
    }
    
    func hideSplashView() {
        JTSplashView.finishWithCompletion { () -> Void in
            UIApplication.sharedApplication().statusBarHidden = false
            self.toggleRefreshAnimation(true)
            self.getData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func btnRefresh() {
        toggleRefreshAnimation(true)
        getData()
    }
}