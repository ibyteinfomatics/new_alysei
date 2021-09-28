//
//  BlockingTableCell.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 20/01/21.
//

import UIKit

class BlockingTableCell: UITableViewCell {
    
    //MARK: - IBOutlet -
    
    @IBOutlet weak var imgViewBlocking: UIImageView!
    @IBOutlet weak var lblBlockingName: UILabel!
    @IBOutlet weak var lblBlockingStatus: UILabel!
    
    //MARK: - Public Methods -
    
    public func configure(img: String, lblName: String, lblStatus: String){
        
        imgViewBlocking.image = UIImage.init(named: img)
        lblBlockingName.text = lblName
        lblBlockingStatus.text = lblStatus
    }

}
