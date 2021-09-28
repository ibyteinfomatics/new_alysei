//
//  AnalyticsCollectionViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//

import UIKit

class AnalyticsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var containeView: UIView!
    
    func configCell(_ totalProduct: String){
        lblValue.text = totalProduct
    }
}
