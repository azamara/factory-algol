//
//  ViewController.swift
//  Algol
//
//  Created by William Kim on 2015. 11. 8..
//  Copyright © 2015년 William Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Hello world!!"

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

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

