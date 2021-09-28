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
             label.textColor = .black
             label.font = UIFont(name: "Montserrat-Bold", size: 16)
             label.sizeToFit()
             return label
         }()

         override init(frame: CGRect) {
             super.init(frame: frame)

             addSubview(label)

             label.translatesAutoresizingMaskIntoConstraints = false
             label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
             label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
             label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
