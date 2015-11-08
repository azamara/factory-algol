//
//  ViewController.swift
//  Algol
//
//  Created by William Kim on 2015. 11. 8..
//  Copyright © 2015년 William Kim. All rights reserved.
//

import UIKit
import Alamofire
import Argo
import Curry

// Argo
struct User {
    let origin: String
    let url: String
    let args: String
}

extension User: Decodable {
    static func decode(j: JSON) -> Decoded<User> {
        return curry(User.init)
            <^> j <| "origin"
            <*> j <| "url"
            <*> j <| ["args", "foo"] // json["args"]["foo"]
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Hello world!!"

        // Task Queue
        let queue = TaskQueue()

        queue.tasks +=~ {
            print(1)
        }

        queue.tasks +=! {
            print(2)
        }

        print(3)
        queue.run()

        print(4)
        
        
        // Alamofire
        Alamofire.request(.GET, "http://httpbin.org/get")
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    let user: User? = decode(json)
                    print("User: \(user)")
                    print("User: \(user?.origin)")
                }
        }
        
        // Wherever you receive JSON data:
        
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

