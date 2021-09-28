//
//  CompanyFirstTableCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 19/01/21.
//

import UIKit

class CompanyFirstTableCell: UITableViewCell {
  
  @IBOutlet weak var lblCompanyFirst: UILabel!
  @IBOutlet weak var txtFieldCompanyFirst: UITextField!
  @IBOutlet weak var btnCompanyFirst: UIButton!
    var btnCallback: (() -> Void)? = nil
    
  override func awakeFromNib() {
    super.awakeFromNib()
  }
    func configCell(_ title:String, _ userCerData: UserCerData?,_ index: Int?){
        lblCompanyFirst.text = title
        if index == 0{
        txtFieldCompanyFirst.text = userCerData?.vatNo
        }else{
            txtFieldCompanyFirst.text = userCerData?.fdaNo
        }
    }
    
    @IBAction func btnInfo(_ sender: UIButton){
        self.btnCallback?()
    }
    
    
}
