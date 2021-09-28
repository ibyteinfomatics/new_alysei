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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnRemoveTapped(_ sender: Any) {
        
        
    }
}
