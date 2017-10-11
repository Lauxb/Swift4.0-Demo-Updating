//
//  ViewController.swift
//  MethodSwizzle
//
//  Created by liuxb on 2017/10/10.
//  Copyright © 2017年 liuxb. All rights reserved.
//

import UIKit

let SCREEN_BOUNDS = UIScreen.main.bounds

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    func createButton() {
        let centerY = self.view.center.y
        let upBtn = LXButton(frame: CGRect(x: SCREEN_BOUNDS.size.width*0.5 - 60, y: centerY - 60, width: 120, height: 120))
        upBtn.tag = 0
        upBtn.backgroundColor = UIColor.brown
        upBtn.setImage(UIImage(named: "lu"), for: .normal)
        upBtn.setTitle("瞄准", for: .normal)
        upBtn.setTitleColor(UIColor.white, for: .normal)
        upBtn.setTitleColor(UIColor.white, for: .highlighted)
        upBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        upBtn.titleLabel?.textAlignment = .center
        upBtn.imageRect = CGRect(x: 10, y: 0, width: 100, height: 100)
        upBtn.titleRect = CGRect(x: 0, y: 100, width: 120, height: 20)
        upBtn.addTarget(self, action: #selector(change(_:)), for: .touchUpInside)
        self.view.addSubview(upBtn)
    }
    
    @objc func change(_ sender: UIButton) {
        switch sender.tag {
        case 0: //up
            sender.imageRect = CGRect(x: 10, y: 20, width: 100, height: 100)
            sender.titleRect = CGRect(x: 0, y: 0, width: 120, height: 20)
            sender.tag = 1
        case 1: //down
            sender.imageRect = CGRect(x: 10, y: 0, width: 100, height: 100)
            sender.titleRect = CGRect(x: 0, y: 100, width: 120, height: 20)
            sender.tag = 2
        case 2: //left
            sender.imageRect = CGRect(x: 60, y: 30, width: 60, height: 60)
            sender.titleRect = CGRect(x: 0, y: 30, width: 60, height: 60)
            sender.tag = 3
        default: //right
            sender.imageRect = CGRect(x: 0, y: 30, width: 60, height: 60)
            sender.titleRect = CGRect(x: 60, y: 30, width: 60, height: 60)
            sender.tag = 0
        }
    }
}











































