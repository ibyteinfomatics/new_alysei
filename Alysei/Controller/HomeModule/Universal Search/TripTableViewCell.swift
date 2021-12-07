//
//  TripsTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var duview1: UIView!
    @IBOutlet weak var duview2: UIView!
    @IBOutlet weak var duview3: UIView!
    @IBOutlet weak var duview4: UIView!
    @IBOutlet weak var duview5: UIView!
    @IBOutlet weak var duview6: UIView!
    @IBOutlet weak var duview7: UIView!
    
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var tripTitle: UILabel!
    @IBOutlet weak var travelTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
   // @IBOutlet weak var activitiesTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var noItemLabel: UILabel!
    
    @IBOutlet weak var mainVw: UIView!
    
    @IBOutlet weak var userImage: UIImageView!

    var data: TripDatum?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userImage.layer.cornerRadius = self.userImage.frame.height/2
        view1.layer.cornerRadius = view1.frame.size.width/2
        view2.layer.cornerRadius = view2.frame.size.width/2
        view3.layer.cornerRadius = view3.frame.size.width/2
        view4.layer.cornerRadius = view4.frame.size.width/2
        view5.layer.cornerRadius = view5.frame.size.width/2
        
        duview1.layer.cornerRadius = duview1.frame.size.width/2
        duview2.layer.cornerRadius = duview2.frame.size.width/2
        duview3.layer.cornerRadius = duview3.frame.size.width/2
        duview4.layer.cornerRadius = duview4.frame.size.width/2
        duview5.layer.cornerRadius = duview5.frame.size.width/2
        duview6.layer.cornerRadius = duview6.frame.size.width/2
        duview7.layer.cornerRadius = duview7.frame.size.width/2
        
        view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        
        duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        duview7.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: TripDatum){
        self.data = data
    }
    
    

}
