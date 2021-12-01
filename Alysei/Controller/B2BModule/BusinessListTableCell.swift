//
//  BusinessListTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessListTableCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    

  override func awakeFromNib() {
    super.awakeFromNib()
  }
    func configData(_ data: SubjectData){
    
        let roleID = UserRoles(rawValue:Int.getInt(data.roleId)  ) ?? .voyagers
        var name = ""
        switch roleID {
//        case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
//            name = data.companyName ?? ""
//        case .restaurant :
//            name =  data.restaurantName ?? ""
//        case .voiceExperts:
//            name = data.name ?? ""
//        default:
//            name = data.companyName ?? ""
//        }
        case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
            name = "\(data.companyName?.capitalized ?? "")"
        //                case .voiceExperts, .voyagers:
        case .restaurant :
            name = "\(data.restaurantName?.capitalized ?? "")"
        default:
            if data.firstName == "" || data.firstName == nil {
                name = "\(data.name ?? "")"
            }else{
                name = "\(data.firstName?.capitalized ?? "") \(data.lastName?.capitalized ?? "")"
            }
        }
        userName.text = name
        
        if data.roleId == UserRoles.producer.rawValue{
            userLocation.text = "Producer," + "\(data.follower_count ?? 0) Followers"
        }else if data.roleId == UserRoles.restaurant.rawValue{
            userLocation.text = "Restaurant," + "\(data.follower_count ?? 0) Followers"
        }else if(data.roleId == UserRoles.voyagers.rawValue){
            userLocation.text = "Voyager"
        }else if data.roleId == UserRoles.voiceExperts.rawValue{
            userLocation.text = "Voice Of Experts," + "\(data.follower_count ?? 0) Followers"
        }else if data.roleId == UserRoles.distributer1.rawValue {
            userLocation.text = "Importer," + "\(data.follower_count ?? 0) Followers"
        }else if data.roleId == UserRoles.distributer2.rawValue{
            userLocation.text = "Distributer," + "\(data.follower_count ?? 0) Followers"
        }else if data.roleId == UserRoles.distributer3.rawValue{
            userLocation.text = "Importer & Distributer," + "\(data.follower_count ?? 0) Followers"
        }else if data.roleId == UserRoles.travelAgencies.rawValue{
            userLocation.text = "Travel Agencies," + "\(data.follower_count ?? 0) Followers"
        }
      //  userLocation.text = data.email
     if String.getString(data.avatarId?.attachmentUrl) == "" {
            userImage.image = UIImage(named: "profile_icon")
        }else{
            userImage.setImage(withString: kImageBaseUrl + String.getString(data.avatarId?.attachmentUrl))
        }
       
   }
}
