//
//  ViewController.swift
//  CADisplayLinkSample
//
//  Created by liuxb on 2017/10/17.
//  Copyright © 2017年 liuxb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayView = DisplayView(frame: self.view.bounds)
        displayView.backgroundColor = UIColor.brown
        self.view.addSubview(displayView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

