//
//  NetworkTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 25/01/21.
//

import UIKit

class NetworkTableCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var lblFolloweCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var btnRemoveCallback:((Int) -> Void)? = nil
    var btnViewCallback:((Int) -> Void)? = nil
    var btnAcceptCallback:((Int) -> Void)? = nil
    var btnDeclineCallback:((Int) -> Void)? = nil
    
    @IBAction func btnRemoveTapped(_ sender: Any) {
        
        btnRemoveCallback?(remove.tag)
    }
    
    @IBAction func btnViewAction(_ sender: UIButton){
        btnViewCallback?(sender.tag)
    }
    
    @IBAction func btnAcceptAction(_ sender: UIButton){
        btnAcceptCallback?(sender.tag)
    }
    
    @IBAction func btnDeclineAction(_ sender: UIButton){
        btnDeclineCallback?(sender.tag)
    }
    
}
