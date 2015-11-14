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
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dustLabel: UILabel!

    func getData() {
        print("START: WeatherViewController.getData")
        let queue = TaskQueue()
        
        // Town
        queue.tasks +=~ {
        }
        
        // Home
        queue.tasks +=~ {
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
                
            }
        }
        
        queue.run()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}