//
//  CompanySecondTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 19/01/21.
//

import UIKit

class CompanySecondTableCell: UITableViewCell {
  
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDescription: UILabel!
  @IBOutlet weak var btnUploadChange: UIButton!
    @IBOutlet weak var btnView: UIButton!
  @IBOutlet weak var imgCheckMark: UIImageView!
    var btnUploadCallBack: ((Int) -> Void)? = nil
    var btnViewCallBack: ((Int) -> Void)? = nil
  override func awakeFromNib() {
    super.awakeFromNib()
  }
    func configCell(_ title:String, _ desc: String, _ section: Int, _ index: Int, _ data: DataCertificates){
        lblTitle.text = title
        lblDescription.text = desc
//            if arrUploadImagesIndex.contains(index) {
//                self.imgCheckMark.image = UIImage(named: "icon_bubble4")
//            }else {
//                self.imgCheckMark.image = UIImage(named: "grey_checked_icon")
//            }
        let userId = data.userFieldOptionId
        
        if  index == 0 {
        self.imgCheckMark.image  = data.photoOfLabel?.isEmpty == true ? UIImage(named: "grey_checked_icon") : UIImage(named: "ProfileCompletion5")
            
            let btnText = data.photoOfLabel?.isEmpty == true ? "Upload" : "Uploaded"
            self.btnUploadChange.setTitle(btnText, for: .normal)
            self.btnUploadChange.backgroundColor = data.photoOfLabel?.isEmpty == true ? UIColor.init(hexString: "#004577") : UIColor.init(hexString: "#33A386")
            
            self.btnView.isHidden = data.photoOfLabel?.isEmpty == true ? true : false
            
        }else if index == 1 {
        self.imgCheckMark.image  = data.fceSidCertification?.isEmpty == true ? UIImage(named: "grey_checked_icon") : UIImage(named: "ProfileCompletion5")
            let btnText = data.fceSidCertification?.isEmpty == true ? "Upload" : "Uploaded"
            self.btnUploadChange.setTitle(btnText, for: .normal)
            self.btnUploadChange.backgroundColor = data.fceSidCertification?.isEmpty == true ? UIColor.init(hexString: "#004577") : UIColor.init(hexString: "#33A386")
            
            self.btnView.isHidden = data.fceSidCertification?.isEmpty == true ? true : false
        }else if index == 2{
            self.imgCheckMark.image  = data.phytosanitaryCertificate?.isEmpty == true ? UIImage(named: "grey_checked_icon") : UIImage(named: "ProfileCompletion5")
            let btnText = data.phytosanitaryCertificate?.isEmpty == true ? "Upload" : "Uploaded"
            self.btnUploadChange.setTitle(btnText, for: .normal)
            self.btnUploadChange.backgroundColor = data.phytosanitaryCertificate?.isEmpty == true ? UIColor.init(hexString: "#004577") : UIColor.init(hexString: "#33A386")
            self.btnView.isHidden = data.phytosanitaryCertificate?.isEmpty == true ? true : false
        }else if index == 3{
            self.imgCheckMark.image  = data.packaginForUsa?.isEmpty == true ? UIImage(named: "grey_checked_icon") : UIImage(named: "ProfileCompletion5")
            let btnText = data.packaginForUsa?.isEmpty == true ? "Upload" : "Uploaded"
            self.btnUploadChange.setTitle(btnText, for: .normal)
            self.btnUploadChange.backgroundColor = data.packaginForUsa?.isEmpty == true ? UIColor.init(hexString: "#004577") : UIColor.init(hexString: "#33A386")
            self.btnView.isHidden = data.packaginForUsa?.isEmpty == true ? true : false
       }else if index == 4 {
            self.imgCheckMark.image  = data.foodSafetyPlan?.isEmpty == true ? UIImage(named: "grey_checked_icon") : UIImage(named: "ProfileCompletion5")
           let btnText = data.foodSafetyPlan?.isEmpty == true ? "Upload" : "Uploaded"
           self.btnUploadChange.setTitle(btnText, for: .normal)
           self.btnUploadChange.backgroundColor = data.foodSafetyPlan?.isEmpty == true ? UIColor.init(hexString: "#004577") : UIColor.init(hexString: "#33A386")
           self.btnView.isHidden = data.foodSafetyPlan?.isEmpty == true ? true : false
        }else{
            self.imgCheckMark.image  = data.animalHelathAslCertificate?.isEmpty == true ? UIImage(named: "grey_checked_icon") : UIImage(named: "ProfileCompletion5")
            let btnText = data.animalHelathAslCertificate?.isEmpty == true ? "Upload" : "Uploaded"
            self.btnUploadChange.setTitle(btnText, for: .normal)
            self.btnUploadChange.backgroundColor = data.animalHelathAslCertificate?.isEmpty == true ? UIColor.init(hexString: "#004577") : UIColor.init(hexString: "#33A386")
            self.btnView.isHidden = data.animalHelathAslCertificate?.isEmpty == true ? true : false
        }
    }
    
    @IBAction func btnUploadAction(_ sender: UIButton){
        self.btnUploadCallBack?(sender.tag)
    }
    
    @IBAction func btnViewAction(_ sender: UIButton){
        
        self.btnViewCallBack?(sender.tag)
        
    }
}
