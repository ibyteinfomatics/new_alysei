//
//  ProducerDetailTableViewCell.swift
//  Dashboard
//
//  Created by mac on 21/09/21.
//

import UIKit

class ProducerDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnDecline: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reasontoconnect: UILabel!
    @IBOutlet weak var vatno: UILabel!
    @IBOutlet weak var fdano: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    
    @IBOutlet weak var fdalabelconstraint: NSLayoutConstraint!
    @IBOutlet weak var fdanumberconstraint: NSLayoutConstraint!
    @IBOutlet weak var fdalineconstraint: NSLayoutConstraint!
    
    var btnAcceptCallback:((Int) -> Void)? = nil
    var btnDeclineCallback:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnDecline.layer.borderWidth = 1
        btnDecline.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapAccept(_ sender: UIButton) {
        btnAcceptCallback?(sender.tag)
        
    }
    
    @IBAction func tapDecline(_ sender: UIButton) {
        btnDeclineCallback?(sender.tag)
        
    }

}
