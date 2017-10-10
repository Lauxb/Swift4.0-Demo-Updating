//
//  ViewController.swift
//  CustomActionView
//
//  Created by liuxb on 2017/10/9.
//  Copyright © 2017年 liuxb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let actionSheetTitles = ["Click One","Click Two","Click Three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBaseUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController {
    fileprivate func setBaseUI() {
        
        let btnWidth:CGFloat = 200
        let btnHeight:CGFloat = 40
        let btnX:CGFloat = (SCREEN_BOUNDS.width - btnWidth)/2
        let centerY:CGFloat = self.view.center.y
        
        let btnWithCancel = UIButton(frame: CGRect(x: btnX, y: centerY - 50, width: btnWidth, height: btnHeight))
        btnWithCancel.setTitle("Show Cancel Button", for: .normal)
        btnWithCancel.backgroundColor = UIColor.blue
        btnWithCancel.tag = 1
        btnWithCancel.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        self.view.addSubview(btnWithCancel)
        
        let btnWithoutCancel = UIButton(frame: CGRect(x: btnX, y: centerY + 50, width: btnWidth, height: btnHeight))
        btnWithoutCancel.setTitle("Hide Cancel Button", for: .normal)
        btnWithoutCancel.backgroundColor = UIColor.blue
        btnWithoutCancel.tag = 2
        btnWithoutCancel.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        self.view.addSubview(btnWithoutCancel)
    }
    
    @objc func click(_ sender: UIButton) {
        let actionSheetView = ActionSheetView()
        switch sender.tag {
        case 1:
            actionSheetView.actionSheetView(titles: self.actionSheetTitles, show: true)
        default:
            actionSheetView.actionSheetView(titles: self.actionSheetTitles, show: false)
        }
        
        actionSheetView.frame = self.view.bounds
        actionSheetView.backgroundColor = UIColor.gray
        actionSheetView.delegate = self
        self.view.addSubview(actionSheetView)
    }
}

extension ViewController:ActionSheetViewDelegage {
    func actionSheetAndClickAtIndex(actionSheet: ActionSheetView, buttonIndex: Int) {
        print("ActionSheetView click at \(buttonIndex) --- (\(self.actionSheetTitles[buttonIndex])")
    }
}



