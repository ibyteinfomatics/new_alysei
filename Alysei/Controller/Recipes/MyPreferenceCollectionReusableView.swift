//
//  MyPreferenceCollectionReusableView.swift
//  Alysei
//
//  Created by Gitesh Dang on 21/12/21.
//

import UIKit

class MyPreferenceCollectionReusableView: UICollectionReusableView {
    var label1: UIView = {
        let label: UIView = UIView()
        label.height(1)
        label.backgroundColor = .black
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        label1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        label1.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
