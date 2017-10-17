//
//  DisplayView.swift
//  CADisplayLinkSample
//
//  Created by liuxb on 2017/10/17.
//  Copyright © 2017年 liuxb. All rights reserved.
//

import UIKit

let SCREEN_BOUNDS = UIScreen.main.bounds
let MIN_HEIGHT:CGFloat = 100
let W_H:CGFloat = 5

class DisplayView: UIView {
    fileprivate var mHeight: CGFloat = 100.0
    
    fileprivate var curveX: CGFloat = 0.0
    fileprivate var curveY: CGFloat = 0.0
    fileprivate var curveView: UIView!
    
    fileprivate var shapeLayer: CAShapeLayer!
    fileprivate var displayLink: CADisplayLink!
    fileprivate var isAnimating: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initData(){
        self.shapeLayer = CAShapeLayer()
        self.shapeLayer.fillColor = UIColor.blue.cgColor
        self.layer.addSublayer(self.shapeLayer)
        
        self.curveX = SCREEN_BOUNDS.width*0.5
        self.curveY = MIN_HEIGHT
        self.curveView = UIView(frame: CGRect(x: curveX - W_H*0.5, y: curveY, width: W_H, height: W_H))
        self.curveView.backgroundColor = UIColor.red
        self.addSubview(self.curveView)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanAction(pan:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(pan)
        
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.calculatePah))
        self.displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        self.displayLink.isPaused = true
        
        self.updateShapeLayerPath()
    }
}


extension DisplayView {
    @objc func handlePanAction(pan: UIPanGestureRecognizer){
        if !self.isAnimating {
            if pan.state == .changed {
                //shapeLayer随着手势扩大区域
                let point = pan.translation(in: self)
                
                self.mHeight = point.y * 0.7 + MIN_HEIGHT
                self.curveY = mHeight > MIN_HEIGHT ? mHeight : MIN_HEIGHT
                self.curveX = SCREEN_BOUNDS.size.width * 0.5 + point.x
                
                self.curveView.frame = CGRect(x: self.curveX,
                                              y: self.curveY,
                                              width: curveView.frame.size.width,
                                              height: curveView.frame.size.height)
                self.updateShapeLayerPath()
            } else if pan.state == .cancelled || pan.state == .ended || pan.state == .failed {
                self.isAnimating = true
                self.displayLink.isPaused = false
                
                UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                    self.curveView.frame = CGRect(x: (SCREEN_BOUNDS.size.width - W_H)*0.5, y: MIN_HEIGHT, width: W_H, height: W_H)
                }, completion: { (finished) in
                    if finished {
                        self.isAnimating = false
                        self.displayLink.isPaused = true
                    }
                })
            }
        }
    }
    
    func updateShapeLayerPath() {
        let path = UIBezierPath()
        path .move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: SCREEN_BOUNDS.size.width, y: 0))
        path.addLine(to: CGPoint(x: SCREEN_BOUNDS.size.width, y: MIN_HEIGHT))
        path.addQuadCurve(to: CGPoint(x: 0.0, y: MIN_HEIGHT), controlPoint: CGPoint(x: curveX, y: curveY))
        path.close()
        self.shapeLayer.path = path.cgPath
    }
    
    @objc func calculatePah() {
        let layer = self.curveView.layer.presentation()
        self.curveX = (layer?.position.x)!
        self.curveY = (layer?.position.y)!
        self.updateShapeLayerPath()
    }
}






































