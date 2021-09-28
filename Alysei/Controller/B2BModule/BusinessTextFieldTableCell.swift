//
//  BusinessTextFieldTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessTextFieldTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var txtFieldBusiness: UITextFieldExtended!
    var passTextCallBack: ((String) -> Void)? = nil
  override func awakeFromNib() {
    txtFieldBusiness.delegate = self
    super.awakeFromNib()
    self.txtFieldBusiness.makeCornerRadius(radius: 6.0)
    self.txtFieldBusiness.attributedPlaceholder = NSAttributedString(string: "Keyword Search",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: AppColors.liteGray.color])
   
  }
    
}


extension BusinessTextFieldTableCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            passTextCallBack?(txtAfterUpdate )
        }
        return true
    }
}
