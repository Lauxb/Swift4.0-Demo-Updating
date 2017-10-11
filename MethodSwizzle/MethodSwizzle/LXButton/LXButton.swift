//
//  LXButton.swift
//  MethodSwizzle
//
//  Created by liuxb on 2017/10/11.
//  Copyright © 2017年 liuxb. All rights reserved.
//

import UIKit

class LXButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if !self.titleRect.isEmpty && !self.titleRect.equalTo(.zero) {
            return self.titleRect
        }
        return super.titleRect(forContentRect: contentRect)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if !self.imageRect.isEmpty && !self.imageRect.equalTo(.zero) {
            return self.imageRect
        }
        return super.imageRect(forContentRect: contentRect)
    }
}
