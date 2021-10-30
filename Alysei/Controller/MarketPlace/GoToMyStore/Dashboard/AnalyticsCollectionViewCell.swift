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
    
    func configCell(_ totalProduct: Int, _ totalCategory: Int, _ totalEnquiry: Int, _ totalReview: Int, index: Int?){
        if index == 0 {
            lblValue.text = "\(totalProduct)"
        }else if index == 1 {
            lblValue.text = "\(totalEnquiry)"
        }else if index == 2{
            lblValue.text = "\(totalCategory)"
        }else{
            lblValue.text = "\(totalReview)"
        }
        
    }
}
