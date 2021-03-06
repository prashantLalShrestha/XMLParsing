//
//  ViewController.swift
//  XMLParsing
//
//  Created by Prashant Shrestha on 8/11/18.
//  Copyright © 2018 Prashant Shrestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let book = CheckUserStatusResult.retrieveBook(), let statusCode = book.statusCode, let message = book.message {
            print(statusCode + ": " + message)
            let encoded = book.toXML()
            print(encoded)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

