//
//  SaveAddressViewC.swift
//  Alysie
//
//  Created by CodeAegis on 02/03/21.
//

import UIKit
import IQKeyboardManagerSwift

protocol SaveAddressCallback {
  
    func addressSaved(_ model: SignUpStepTwoDataModel,addressLineOne: String,addressLineTwo: String, mapAddress: String?) -> Void
}

class SaveAddressViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var txtFieldAddress1: UITextFieldExtended!
  @IBOutlet weak var txtFieldAddress2: UITextFieldExtended!
  @IBOutlet weak var viewBottom: UIView!
  @IBOutlet weak var viewTop: UIView!
  @IBOutlet weak var viewTopHeightConstraint: NSLayoutConstraint!
    var mapAddress: String?
  //MARK: - Properties -
  
  var signUpStepTwoDataModel: SignUpStepTwoDataModel!
  var delegate: SaveAddressCallback?

    var dismiss: ((_ mapAddress: MapAddressModel) -> Void)?

  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initialSetUp()
  }
 
  //MARK: - Private Methods -
  
  private func initialSetUp() -> Void{
    
    if self.signUpStepTwoDataModel != nil{
      self.txtFieldAddress1.text = self.signUpStepTwoDataModel.selectedAddressLineOne
      self.txtFieldAddress2.text = self.signUpStepTwoDataModel.selectedAddressLineTwo
    }
    
  }
  
  @objc func keyboardWillShow(sender: NSNotification) {
    
   // self.viewTopHeightConstraint.constant = 310.0 + 200.0
   // self.viewBottom.frame.origin.y -= 60
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapClose(_ sender: UIButton) {

    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func tapSubmit(_ sender: UIButton) {
    
    if self.txtFieldAddress1.text?.isEmpty == true{
      showAlert(withMessage: AlertMessage.kAddress)
    }
    else{
        if self.signUpStepTwoDataModel != nil {
            self.delegate?.addressSaved(self.signUpStepTwoDataModel, addressLineOne: String.getString((self.txtFieldAddress1.text)), addressLineTwo: String.getString((self.txtFieldAddress2.text)), mapAddress: self.mapAddress)
        } else {
            let mapAddressModel = MapAddressModel(address1: String.getString((self.txtFieldAddress1.text)),
                                                  address2: String.getString((self.txtFieldAddress2.text)),
                                                  mapAddress: self.mapAddress ?? "")
            self.dismiss?(mapAddressModel)
            self.dismiss(animated: false, completion: nil)
        }

    }
  }
}
