//
//  LoaderView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    private var loader: Loader?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup(frame: CGRect) {
        let width = frame.width / 3
        let height = frame.height / 3
        loader = Loader(frame: CGRect(x: .zero, y: .zero, width: width, height: height))
        if let loader = loader {
            loader.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(loader)
            NSLayoutConstraint.activate([
                loader.widthAnchor.constraint(equalToConstant: width),
                loader.heightAnchor.constraint(equalToConstant: height),
                loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            self.backgroundColor = .bg50.withAlphaComponent(.commonAlpha)
            self.layer.cornerRadius = 10
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.bg50.cgColor
        }
    }
}

class Loader: UIView {
    
    private let startAngle = CGFloat(0.0 * Double.pi)
    private let endAngle = CGFloat(1.4 * Double.pi)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0),
                                      radius: (self.frame.size.width + 8) / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let segmentLayer = CAShapeLayer()
        segmentLayer.path = circlePath.cgPath
        segmentLayer.lineWidth = 3
        segmentLayer.strokeColor = UIColor.primary500.cgColor
        segmentLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(segmentLayer)
        
        let drawAnimation = CABasicAnimation(keyPath: "transform.rotation")
        drawAnimation.duration = 1
        drawAnimation.repeatCount = .infinity
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.fromValue = 0
        drawAnimation.toValue = CGFloat(Double.pi * 2.0)
        drawAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        layer.add(drawAnimation, forKey: "rotateAnimation")
    }
}
