//
//  SelectB2BProductViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/26/21.
//
//
//  SelectOptionViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 13/01/21.
//

import UIKit



class SelectB2BProductViewController: AlysieBaseViewC {

  //MARK:  - Outlet -
    
  @IBOutlet weak var tblViewSelectProduct: UITableView!
  @IBOutlet weak var viewNavigation: UIView!
  @IBOutlet weak var lblNavigation: UILabel!
  
  //MARK:  - Properties -
  
 
   
    var arrProductType: ProductType?
  //MARK:  - ViewLifeCycle Methods -
    
   override func viewDidLoad() {
    super.viewDidLoad()
    //self.signUpStepOneDataModel.map({arrProductType?.options})
   }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK:  - IBAction -
  
  @IBAction func tapDone(_ sender: UIButton) {
    
    
  }
  
  @IBAction func tapBack(_ sender: UIButton) {
    //kSharedInstance.signUpStepOneDataModel = nil
    self.navigationController?.popViewController(animated: true)
  }
  

}

//MARK:  - TableView Methods -

    
   
  
    




