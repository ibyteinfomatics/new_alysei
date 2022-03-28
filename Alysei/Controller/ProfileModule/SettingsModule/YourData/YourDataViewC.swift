//
//  YourDataViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit

class YourDataViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblNothingRequest: UITextField!
    @IBOutlet weak var btnRequest: UIButton!
    
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    viewNavigation.drawBottomShadow()
      lblTitle.text = AppConstants.YourData
      lblSubTitle.text = AppConstants.AccountDataDownload
      lblNothingRequest.text = AppConstants.NothingRequestedYet
      btnRequest.setTitle(AppConstants.RequestData, for: .normal)
      
   super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
