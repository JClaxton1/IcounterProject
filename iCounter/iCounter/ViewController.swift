//
//  ViewController.swift
//  iCounter
//
//  Created by Jason Claxton on 8/13/17.
//  Copyright © 2017 Jason Claxton. All rights reserved.
//

import UIKit

var cList: [Count] = []
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

}

