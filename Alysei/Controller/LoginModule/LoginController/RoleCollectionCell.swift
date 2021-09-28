//
//  RoleCollectionCellCollectionViewCell.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 13/01/21.
//

import UIKit


class RoleCollectionCell: UICollectionViewCell {
    
    //MARK: - IBOutlet -
    
    @IBOutlet weak var imgVRole: UIImageView!
    @IBOutlet weak var lblRoleName: UILabel!
    @IBOutlet weak var imgViewSelected: UIImageView!
    
    @IBOutlet weak var imgRole: ImageLoader!
    
    //MARK: - Public Methods -
    var imageArray = ["select_role1","select_role2","select_role3","select_role4","select_role5","select_role6"]
    public func configureData(withGetRoleDataModel model: GetRoleDataModel,_ indexPath: Int) -> Void{
        
        //imgVRole.setImage(withString: String.getString(model.image), placeholder: nil)
        //   print("")
        // Create URL
//        let url = URL(string: "\(model.image ?? "")")!
//        
//        DispatchQueue.global().async {
//            // Fetch Image Data
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    // Create Image and Update Image View
//                    self.imgVRole.image = UIImage(data: data)
//                }
//            }
//        }
        // unwrapped url safely...
        if let strUrl = "\(model.image ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let imgUrl = URL(string: strUrl) {

            self.imgRole.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
        }
//        self.imgVRole.image = UIImage(named: imageArray[indexPath])
        lblRoleName.text = model.name
        
        if model.isSelected == true{
            
            self.imgViewSelected.isHidden = false
            self.imgViewSelected.image = UIImage(named: "overlay_on_role_selection")
        }
        else{
            self.imgViewSelected.isHidden = true
        }
    }
}
