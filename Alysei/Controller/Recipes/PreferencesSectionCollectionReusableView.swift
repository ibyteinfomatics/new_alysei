//
//  PreferencesSectionCollectionReusableView.swift
//  Alysei
//
//  Created by namrata upadhyay on 19/09/21.
//

import UIKit

class PreferencesSectionCollectionReusableView: UICollectionReusableView {
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica Neue Bold", size: 16)
        
        label.sizeToFit()
        return label
    }()
    
    var gradientVw: UIView = {
        let view: UIView = UIView()
        view.sizeToFit()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
//        let colorTop =  UIColor(red: 94.0/255.0, green: 199.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 70.0/255.0, green: 172.0/255.0, blue: 213.0/255.0, alpha: 1.0).cgColor
        let colorTop =  UIColor(red: 21.0/255.0, green: 68.0/255.0, blue: 120.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 21.0/255.0, green: 68.0/255.0, blue: 120.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.shouldRasterize = true
        gradientVw.layer.addSublayer(gradientLayer)
        addSubview(gradientVw)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            gradientVw.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            gradientVw.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            gradientVw.topAnchor.constraint(equalTo: topAnchor),
            gradientVw.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
