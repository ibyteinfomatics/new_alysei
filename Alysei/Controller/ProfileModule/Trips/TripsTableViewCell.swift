//
//  TripsTableViewCell.swift
//  Profile Screen
//
//  Created by mac on 30/08/21.
//

import UIKit

class TripsTableViewCell: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var tripTitle: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var travelTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var interestedButton: UIButton!
    
    var btnDeleteCallback:((Int) -> Void)? = nil
    var btnEditCallback:((Int) -> Void)? = nil
    var btnMoreCallback:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view1.layer.cornerRadius = view1.frame.size.width/2
        view2.layer.cornerRadius = view2.frame.size.width/2
        view3.layer.cornerRadius = view3.frame.size.width/2
        view4.layer.cornerRadius = view4.frame.size.width/2
        view5.layer.cornerRadius = view5.frame.size.width/2
        
        view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        
        moreInfoButton.layer.cornerRadius = 10
        interestedButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
    
    @IBAction func btnMoreAction(_ sender: UIButton){
        btnMoreCallback?(sender.tag)
    }
    
    @IBAction func btnEditAction(_ sender: UIButton){
        btnEditCallback?(sender.tag)
    }

}
