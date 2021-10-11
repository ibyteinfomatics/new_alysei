//
//  NetworkConnectionTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 10/11/21.
//

import UIKit

class NetworkConnectionTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var img: UIImageView!
   // @IBOutlet weak var remove: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var btnRemoveCallback:((Int) -> Void)? = nil
    var btnViewCallback:((Int) -> Void)? = nil
    var btnAcceptCallback:((Int) -> Void)? = nil
    var btnDeclineCallback:((Int) -> Void)? = nil
    
//    @IBAction func btnRemoveTapped(_ sender: Any) {
//        
//        btnRemoveCallback?(remove.tag)
//    }
    
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
