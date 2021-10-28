//
//  AwardCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 26/10/21.
//

import UIKit

class AwardCell: UICollectionViewCell {
    
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var competitionName: UILabel!
    @IBOutlet weak var winningproduct: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var awardimg: UIImageView!
    
    var btnDeleteCallback:((Int) -> Void)? = nil
    var btnEditCallback:((Int) -> Void)? = nil
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
    
    
    @IBAction func btnEditAction(_ sender: UIButton){
        btnEditCallback?(sender.tag)
    }
    
    public func configure(withAllProductsDataModel model: AllProductsDataModel?,pushedFrom: Int = 0) -> Void{

      
    }
    
}
