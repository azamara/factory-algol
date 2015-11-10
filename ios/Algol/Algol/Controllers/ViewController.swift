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
    
    var timeLabel: UILabel?
    
    var timer: NSTimer?
    let INTERVAL_SECONDS = 0.2
    
    var dateFormatter = NSDateFormatter()
    
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
            let counter = self.myInterval(1)
            
            print("Started ----")
            
            let subscription = counter
                .subscribeNext { n in
                    print(n)
            }
            
            NSThread.sleepForTimeInterval(2)
            
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
        
        
        // Widget
        // set up date formatter since it's expensive to keep creating them
        self.dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        self.dateFormatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        // create and add label to display time
        timeLabel = UILabel(frame: self.view.frame)
        updateTimeLabel(nil) // to initialize the time displayed
        // style the label a little: multiple lines, center, large text
        timeLabel?.numberOfLines = 0 // allow it to wrap on to multiple lines if needed
        timeLabel?.textAlignment = .Center
        timeLabel?.font = UIFont.systemFontOfSize(28.0)
        self.view.addSubview(timeLabel!)
        
        // Timer will tick ever 1/5 of a second to tell the label to update the display time
        timer = NSTimer.scheduledTimerWithTimeInterval(INTERVAL_SECONDS, target: self, selector: "updateTimeLabel:", userInfo: nil, repeats: true)
        
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
    
    func updateTimeLabel(timer: NSTimer!)
    {
        if let label = timeLabel
        {
            // get the current time
            let now = NSDate()
            // convert time to a string for display
            let dateString = dateFormatter.stringFromDate(now)
            label.text = dateString
            // set the dateString in the shared data store
            let defaults = NSUserDefaults(suiteName: "group.io.jnw.Algol.AlgolWidget")
            defaults?.setObject("\(dateString) \n dust: \(self.dustLabel!.text!) \n temperature: \(self.temperatureLabel!.text!) \n humidity: \(self.humidityLabel!.text!)", forKey: "timeString")
            // tell the defaults to write to disk now
            defaults?.synchronize()
        }
    }

}

