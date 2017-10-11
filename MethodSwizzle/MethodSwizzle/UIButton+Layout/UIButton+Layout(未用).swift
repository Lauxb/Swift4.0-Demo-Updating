//
//  UIButton+Layout.swift
//  MethodSwizzle
//
//  Created by liuxb on 2017/10/10.
//  Copyright © 2017年 liuxb. All rights reserved.
//

import UIKit

let s_titleRectKey = "lxb_titleRectKey"
let s_imageRectKey = "lxb_imageRectKey"
extension UIButton {
    var s_titleRect:CGRect {
        get{
            return objc_getAssociatedObject(self, s_titleRectKey) as! CGRect
        }
        set{
            objc_setAssociatedObject(self, s_titleRectKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var s_imageRect:CGRect {
        get{
            return objc_getAssociatedObject(self, s_imageRectKey) as! CGRect
        }
        set{
            objc_setAssociatedObject(self, s_imageRectKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIButton {
    
    //Method 'load()' defines Objective-C class method 'load', which is not permitted by Swift
    //Method 'initialize()' defines Objective-C class method 'initialize', which is not permitted by Swift
    //
    //  解决思路：initialize()无非就是提供一个入口允许我们将runtime代码插入到适当的位置,那么这个入口是每一个Class都必须实现且一定会执行的方法，那么这个就和代理模式很接近了。那么我们可以在程序刚启动时使用runtime获取所有的Class，然后对他们遍历，如果他是Protaocl的代理就立即执行代理方法，我们只需要在代理方法中实现initialize()中要实现的代码。
    //
    // (此处不在用swift实现，采用objective-c实现)
    
    /**
    func MethodSwizzle(c: AnyClass, originalSEL: Selector, swappedSEL:Selector) {
        let originalMethod = class_getInstanceMethod(c, originalSEL)!
        let swappedMethod = class_getInstanceMethod(c, swappedSEL)!
        
        //运行时函数class_addMethod，如果发现方法已经存在，会失败返回，也可以用来做检查用
        if class_addMethod(c, originalSEL, method_getImplementation(swappedMethod), method_getTypeEncoding(swappedMethod)) {
            //如果添加成功（在父类中重写的方法），再把目标类中的方法替换为旧有的实现
            class_replaceMethod(c, swappedSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            //addMethod会让目标类的方法指向新的实现，使用replaceMethod再将新的方法指向原先的方法，这样就完成了交换操作
            method_exchangeImplementations(originalMethod, swappedMethod)
        }
    }
    
    func override_titleRectForContentRect(contentRect:CGRect) -> CGRect {
        if !self.s_titleRect.isEmpty && !self.s_titleRect.equalTo(CGRect.zero){
            return self.s_titleRect
        }
        return self.override_titleRectForContentRect(contentRect: contentRect)
    }
    
    func override_imageRectForContentRect(contentRect:CGRect) -> CGRect {
        if !self.s_imageRect.isEmpty && !self.s_imageRect.equalTo(CGRect.zero){
            return self.s_imageRect
        }
        return self.override_imageRectForContentRect(contentRect: contentRect)
    }
     **/
}
