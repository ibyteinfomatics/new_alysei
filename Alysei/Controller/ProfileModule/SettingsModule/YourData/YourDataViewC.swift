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
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    
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
