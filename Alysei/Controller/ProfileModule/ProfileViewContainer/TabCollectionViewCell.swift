//
//  TabCollectionViewCell.swift
//  Alysei
//
//  Created by Janu Gandhi on 23/05/21.
//

import UIKit
import Koloda


class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    var isCellSelected = false
    @IBOutlet var underLineBorder: UILabel!

//    private var underlineBorder: UILabel {
//
//        let label = UILabel()
//
//        label.frame = CGRect(x: 0.0, y: self.frame.height - 2.0, width: self.frame.width, height: 1.0)
//
//        label.backgroundColor = .black
//        return label
//    }

    override func awakeFromNib() {
        self.underLineBorder.isHidden = true
//        self.underlineBorder.isHidden = true
//        self.addSubview(self.underlineBorder)
    }

    func isUnderlineBorderVisible(_ status: Bool) {
//        self.underlineBorder.frame = CGRect(x: 0.0, y: self.frame.height - 2.0, width: self.frame.width, height: 1.0)
//        self.underlineBorder.isHidden = status
//        self.backgroundColor = status ? UIColor.yellow : UIColor.clear
        self.underLineBorder.isHidden = !status
    }

}


