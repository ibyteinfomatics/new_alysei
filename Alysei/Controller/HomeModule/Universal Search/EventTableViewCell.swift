//
//  EventsTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var hostTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var noItemLabel: UILabel!
    @IBOutlet weak var btnVisit: UIButton!
    
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.layer.cornerRadius = self.userImage.frame.height / 2
        btnVisit.layer.cornerRadius = self.btnVisit.frame.height / 2
        btnVisit.layer.masksToBounds = true
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
