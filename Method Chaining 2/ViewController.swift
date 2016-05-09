//
//  ViewController.swift
//  Method Chaining 2
//
//  Created by Hamish Knight on 09/05/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = RequestHandler.Input(foo: 5, bar: "baz")
        
        RequestHandler.doRequest(input).success {result in
            print("success, with:", result)
        }.failure {
            print("fail :(")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

