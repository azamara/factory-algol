//
//  ViewController.swift
//  Algol
//
//  Created by William Kim on 2015. 11. 8..
//  Copyright © 2015년 William Kim. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

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
        
        let queue2 = TaskQueue()
        
        queue2.tasks +=~ {
            let counter = self.myInterval(2)
            
            print("Started ----")
            
            let subscription = counter
                .subscribeNext { n in
                    print(n)
            }
            
            NSThread.sleepForTimeInterval(10)
            
            subscription.dispose()
            
            print("Ended ----")
        }
        
        queue2.run()
        
//        let counter = self.myInterval(0.1)
//        
//        print("Main Thread Started ----")
//        
//        let subscription = counter
//            .subscribeNext { n in
//                print(n)
//        }
//        
//        NSThread.sleepForTimeInterval(2)
//        
//        subscription.dispose()
//        
//        print("Main Thread Ended ----")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myInterval(interval: NSTimeInterval) -> Observable<Int> {
        return create { observer in
            print("Subscribed")
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
            
            var next = 0
            
            dispatch_source_set_timer(timer, 0, UInt64(interval * Double(NSEC_PER_SEC)), 0)
            let cancel = AnonymousDisposable {
                print("Disposed")
                dispatch_source_cancel(timer)
            }
            dispatch_source_set_event_handler(timer, {
                if cancel.disposed {
                    return
                }
                observer.on(.Next(next++))
            })
            dispatch_resume(timer)
            
            return cancel
        }
    }




}

