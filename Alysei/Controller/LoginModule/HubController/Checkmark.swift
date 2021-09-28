//
//  Checkmark.swift
//  Alysei
//
//  Created by Gitesh Dang on 19/03/21.
//

import Foundation
import Foundation
import UIKit

public class Checkmark: UIView {
    
    // MARK: Public variables
//    public var initialLayerColor: UIColor = UIColor.blue {
//        didSet {
//            initialLayer.strokeColor = initialLayerColor.cgColor
//        }
//    }
//    public var animatedLayerColor: UIColor = UIColor.red {
//        didSet {
//            animatedLayer?.strokeColor = animatedLayerColor.cgColor
//        }
//    }
    public var initialLayerColor: UIColor = UIColor.lightGray {
        didSet {
            initialLayer.strokeColor = initialLayerColor.cgColor
        }
    }
    public var animatedLayerColor: UIColor = UIColor.init(hexString: "#174E85") {
        didSet {
            animatedLayer?.strokeColor = animatedLayerColor.cgColor
        }
    }
    public var strokeWidth: CGFloat = 4 {
        didSet {
            initialLayer.lineWidth = strokeWidth
            animatedLayer?.lineWidth = strokeWidth
        }
    }
    public var animated: Bool = false {
        didSet {
            if animated {
                animatedLayer = createCheckmarkLayer(strokeColor: animatedLayerColor, strokeEnd: 0)
                layer.addSublayer(animatedLayer!)
            }
        }
    }
    
    // MARK: Private variables
    private lazy var initialLayer: CAShapeLayer = {
        return self.createCheckmarkLayer(strokeColor: self.initialLayerColor, strokeEnd: 1)
    }()
    private var animatedLayer: CAShapeLayer?
    
    // MARK: Overriding methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    // MARK: Public methods
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    public func animate(duration: TimeInterval = 0.6) {
        guard let animatedLayer = animatedLayer else { return }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        
        animatedLayer.strokeEnd = 1
        animatedLayer.add(animation, forKey: "animateCheckmark")
    }
    
    // MARK: Private methods
    private func configureView() {
        backgroundColor = UIColor.clear
        //initialLayerColor = UIColor.blue
        initialLayerColor = UIColor.lightGray
        //animatedLayerColor = UIColor.red
        animatedLayerColor = UIColor.init(hexString: "#174E85")
        strokeWidth = 4
        animated = false
        
        layer.addSublayer(initialLayer)
    }
    private func createCheckmarkLayer(strokeColor: UIColor, strokeEnd: CGFloat) -> CAShapeLayer {
        let scale = frame.width / 100
        let centerX = frame.size.width / 2
        let centerY = frame.size.height / 2
        let sixOclock = CGFloat(Double.pi / 2)
        
        let checkmarkPath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: centerX, startAngle:  sixOclock, endAngle: sixOclock * 5, clockwise: true)
        checkmarkPath.move(to: CGPoint(x: centerX - 23 * scale, y: centerY - 1 * scale))
        checkmarkPath.addLine(to: CGPoint(x: centerX - 6 * scale, y: centerY + 15.9 * scale))
        checkmarkPath.addLine(to: CGPoint(x: centerX + 22.8 * scale, y: centerY - 13.4 * scale))
        
        let checkmarkLayer = CAShapeLayer()
        checkmarkLayer.fillColor = UIColor.clear.cgColor
        checkmarkLayer.lineWidth = strokeWidth
        checkmarkLayer.path = checkmarkPath.cgPath
        checkmarkLayer.strokeEnd = strokeEnd
        checkmarkLayer.strokeColor = strokeColor.cgColor
        checkmarkLayer.lineCap = CAShapeLayerLineCap.round
        checkmarkLayer.lineJoin = CAShapeLayerLineJoin.round
        
        return checkmarkLayer
    }
    
}



