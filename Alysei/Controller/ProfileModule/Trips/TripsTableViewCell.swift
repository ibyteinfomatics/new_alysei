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
    @IBOutlet weak var lblTitleIntensity: UILabel!
    @IBOutlet weak var lblTitleDuration: UILabel!
    @IBOutlet weak var lblTitleTripPrice: UILabel!
    @IBOutlet weak var lblTitleTravelAgency: UILabel!
    @IBOutlet weak var lblTitleRegion: UILabel!
    
    
    
    @IBOutlet weak var duview1: UIView!
    @IBOutlet weak var duview2: UIView!
    @IBOutlet weak var duview3: UIView!
    @IBOutlet weak var duview4: UIView!
    @IBOutlet weak var duview5: UIView!
    @IBOutlet weak var duview6: UIView!
    @IBOutlet weak var duview7: UIView!
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var tripImage: ImageLoader!
    @IBOutlet weak var tripTitle: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var travelTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
   // @IBOutlet weak var activitiesTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var interestedButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    var btnDeleteCallback:((Int,Int) -> Void)? = nil
    var btnEditCallback:((Int) -> Void)? = nil
    var btnMoreCallback:((Int) -> Void)? = nil
    var data: TripDatum?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblTitleIntensity.text = AppConstants.kIntensity + ":"
        lblTitleDuration.text = AppConstants.kDuration + ":"
        lblTitleRegion.text = AppConstants.kRegion + ":"
        lblTitleTripPrice.text = AppConstants.kTripPrice + ":"
        lblTitleTravelAgency.text = AppConstants.kTravelAgency + ":"
       
        view1.layer.cornerRadius = view1.frame.size.width/2
        view2.layer.cornerRadius = view2.frame.size.width/2
        view3.layer.cornerRadius = view3.frame.size.width/2
        view4.layer.cornerRadius = view4.frame.size.width/2
        view5.layer.cornerRadius = view5.frame.size.width/2
        
//        duview1.layer.cornerRadius = duview1.frame.size.width/2
//        duview2.layer.cornerRadius = duview2.frame.size.width/2
//        duview3.layer.cornerRadius = duview3.frame.size.width/2
//        duview4.layer.cornerRadius = duview4.frame.size.width/2
//        duview5.layer.cornerRadius = duview5.frame.size.width/2
//        duview6.layer.cornerRadius = duview6.frame.size.width/2
//        duview7.layer.cornerRadius = duview7.frame.size.width/2
       
        view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        view5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: TripDatum){
        self.data = data
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag,self.data?.tripID ?? 0)
    }
    
    @IBAction func btnMoreAction(_ sender: UIButton){
        btnMoreCallback?(sender.tag)
    }
    
    @IBAction func btnEditAction(_ sender: UIButton){
        btnEditCallback?(sender.tag)
    }

}
