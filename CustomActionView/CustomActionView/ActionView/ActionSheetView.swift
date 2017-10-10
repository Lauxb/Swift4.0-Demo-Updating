//
//  ActionView.swift
//  CustomActionView
//
//  Created by liuxb on 2017/10/10.
//  Copyright © 2017年 liuxb. All rights reserved.
//

import UIKit

let SCREEN_BOUNDS = UIScreen.main.bounds
let CELL_HEIGHT:CGFloat = 50
let CELL_SPACE:CGFloat = 5

protocol ActionSheetViewDelegage:NSObjectProtocol {
    func actionSheetAndClickAtIndex(actionSheet:ActionSheetView, buttonIndex: Int)
}

class ActionSheetView: UIView {
    var titles: Array<Any>?
    var show:Bool = false
    var delegate:ActionSheetViewDelegage?
    
    lazy var btnBgView:UIView = {
        let btnBgView = UIView()
        btnBgView.backgroundColor = UIColor.gray
        btnBgView.alpha = 0.8
        return btnBgView
    }()
}

extension ActionSheetView {
    
    func actionSheetView(titles: Array<Any>, show: Bool) {
        self.frame = bounds
        self.titles = titles
        self.show = show
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hiddenSheet))
        self.addGestureRecognizer(tap)
        
        self.setUpUI()
    }
    
    func setUpUI() {
        let size = SCREEN_BOUNDS.size
        
        var bgHeight:CGFloat = 0
        let bgWidth: CGFloat = size.width
        
        let rows = titles!.count
        if show {
            bgHeight = CELL_HEIGHT * CGFloat(rows) + CELL_HEIGHT + CELL_SPACE
        } else {
            bgHeight = CELL_HEIGHT * CGFloat(rows)
        }
        
        self.btnBgView.frame = CGRect(x: 0, y: size.height, width: size.width, height: bgHeight)
        self.addSubview(self.btnBgView)
        
        for i in 0..<rows {
            let btnX:CGFloat = 0
            var btnY:CGFloat = 0

            if show {
                btnY = bgHeight - CELL_HEIGHT - CELL_SPACE - CELL_HEIGHT * CGFloat(rows - i)
            } else {
                btnY = bgHeight - CELL_HEIGHT * CGFloat(rows - i)
            }

            let btnW = bgWidth
            let btnH = CELL_HEIGHT - 0.5

            let btn = UIButton(type: .custom)
            btn.setTitle(titles![i] as? String, for: .normal)
            btn.backgroundColor = UIColor.white
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            btn.tag = i
            btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            self.btnBgView.addSubview(btn)
        }
        
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(UIColor.black, for: .normal)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.addTarget(self, action: #selector(hiddenSheet), for: .touchUpInside)
        cancelBtn.tag = 0
        cancelBtn.frame = CGRect(x: 0, y: bgHeight - CELL_HEIGHT, width: bgWidth, height: CELL_HEIGHT)
        self.btnBgView.addSubview(cancelBtn)
        cancelBtn.isHidden = !show
        UIView.animate(withDuration: 0.3) {
            var frame = self.btnBgView.frame
            frame.origin.y = size.height - frame.size.height
            self.btnBgView.frame = frame
        }
    }
}

extension ActionSheetView {
    
    @objc func buttonAction(_ sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.actionSheetAndClickAtIndex(actionSheet: self, buttonIndex: sender.tag)
        }
        self.hiddenSheet()
    }
    
    @objc func hiddenSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            var frame = self.btnBgView.frame;
            frame.origin.y = SCREEN_BOUNDS.size.height;
            self.btnBgView.frame = frame;
            
        }) { (Bool) in
            self.removeFromSuperview()
        }
    }
}
