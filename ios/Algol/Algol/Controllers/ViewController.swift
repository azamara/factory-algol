//
//  ViewController.swift
//  Algol
//
//  Created by William Kim on 2015. 11. 8..
//  Copyright © 2015년 William Kim. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dustLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Hello world!!"

        // Task Queue
        let queue = TaskQueue()

        queue.tasks +=~ {
            print(1)
            SwaggerClientAPI.HomeAPI.homeGet(location: Double(2)).execute { (response, error) in
                if response!.statusCode == 200,
                    let home: Home = response!.body as Home {
                        self.homeLabel!.text = "\(home.home_id!)"
                        self.temperatureLabel!.text = "\(home.temperature!)º"
                        self.humidityLabel!.text = "\(home.humidity!)%"
                        self.dustLabel!.text = "\(home.dust!)"
                }
            }
        }

        queue.tasks +=! {
            print(2)
        }

        queue.run()

        
        
        // Alamofire
        /*
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response)
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
        }
        */

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

