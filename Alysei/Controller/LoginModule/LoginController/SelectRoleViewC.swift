//
//  ViewController.swift
//  CustomCollectionViewApp
//
//  Created by Tigran on 20.09.2018.
//  Copyright © 2018 Tigran. All rights reserved.
//

import UIKit
import Instructions

class SelectRoleViewC: AlysieBaseViewC {
    
    //MARK:  - IBOutlet -
    @IBOutlet weak var tableRoleVC: UITableView!
    @IBOutlet weak var btnGetStarted: UIButtonExtended!
    @IBOutlet weak var btnGetStartedHeight: NSLayoutConstraint!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var viewMainTour: UIView!
    @IBOutlet weak var viewTourpopup: OvalView!
    @IBOutlet weak var tourgideLabel: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    //MARK:  - Properties -
    
    var getRoleViewModel: GetRoleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnGetStarted.isHidden = true
        btnGetStartedHeight.constant = 0
        lblHeading.text = LogInSignUp.kSelectRole
        btnGetStarted.setTitle(LogInSignUp.kgetStarted, for: .normal)
        if kSharedAppDelegate.isSelectRole == false{
        viewMainTour.isHidden = false
        viewTourpopup.isHidden = false
        tourgideLabel.text = TourGuideConstants.kSelectRole
        }
        else{
            viewMainTour.isHidden = true
            viewTourpopup.isHidden = true
        }
    }
    

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.viewNavigation.drawBottomShadow()
    }

    @IBAction func tapCross(_ sender: Any) {
        viewTourpopup.isHidden = true
        viewMainTour.isHidden = true
        kSharedAppDelegate.isSelectRole = true
    }
    @IBAction func tapGetStarted(_ sender: UIButton) {
      
      let model = self.getRoleViewModel.arrRoles.filter({$0.isSelected == true})
      let selectedRoleId = model.first?.roleId
      
      if selectedRoleId == nil{
        self.showAlert(withMessage: AlertMessage.kRoleSelection)
      }
      else{
        self.btnGetStarted.isUserInteractionEnabled = false
        self.postRequestToGetWalkthorughScreens(String.getString(selectedRoleId))
      }
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }
    //MARK: - WebService Methods -
    
    private func postRequestToGetWalkthorughScreens(_ selectedRoleId: String) -> Void{
      
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetWalkthroughScreens + selectedRoleId, method: .GET, controller: self, type: 0, param: [:],btnTapped: self.btnGetStarted)
    }
}

extension SelectRoleViewC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getRoleViewModel.arrRoles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let roleCollectionCell = tableRoleVC.dequeueReusableCell(withIdentifier: "RoleTableVieCell", for: indexPath) as? RoleTableVieCell else {return UITableViewCell()}
        roleCollectionCell.selectionStyle = .none
        roleCollectionCell.configureData(withGetRoleDataModel: self.getRoleViewModel.arrRoles[indexPath.item], indexPath.item)
        if indexPath.row == self.getRoleViewModel.arrRoles.count - 1 {
            roleCollectionCell.containerBottomConstraint.constant = 100
            
        }else{
            roleCollectionCell.containerBottomConstraint.constant = 0
           
        }
        
        return roleCollectionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //if indexPath.row == 5 {
           return  UITableView.automaticDimension
//        return 250
//        }else{
//            return 150
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          btnGetStarted.isHidden = false
        btnGetStartedHeight.constant = 48
          for i in 0...self.getRoleViewModel.arrRoles.count - 1{
            
            self.getRoleViewModel.arrRoles[i].isSelected = false
          }
          
          let model = self.getRoleViewModel.arrRoles[indexPath.item]
          model.isSelected = true
         self.tableRoleVC.reloadData()

}
    

}
extension SelectRoleViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let dicResponse = kSharedInstance.getDictionary(result)
    switch type {
    case 0:
     let model = self.getRoleViewModel.arrRoles.filter({$0.isSelected == true})
     let controller = pushViewController(withName: MembersWalkthroughViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? MembersWalkthroughViewC
      controller?.getRoleDataModel = model
      controller?.getWalkThroughViewModel = GetWalkThroughViewModel(dicResponse)

        //MARK:- TESTING Change

   //    let nextVC = CountryListVC()
   //    self.navigationController?.pushViewController(nextVC, animated: true)

    default:
      break
    }
  }
}


class RoleTableVieCell: UITableViewCell{
    var imageArray = ["select_role1","select_role2","select_role3","select_role4","select_role5","select_role6"]

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgRole: CustomImageView!
    @IBOutlet weak var lblRoleName: UILabel!
    @IBOutlet weak var imgViewSelected: UIImageView!
    @IBOutlet weak var lblRoleDesc: UILabel!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
   
    override func prepareForReuse() {
        super.prepareForReuse()
        imgRole.image = UIImage(named: "image_placeholder")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imgRole.layer.cornerRadius = self.imgRole.layer.frame.height / 2
        containerView.layer.cornerRadius = 10
        if MobileDeviceType.IS_IPHONE_6{
            lblRoleDesc.font = UIFont(name: "Arial", size: 14)
        }else{
            lblRoleDesc.font = UIFont(name: "Arial", size: 13.6)
        }
    }
    
    public func configureData(withGetRoleDataModel model: GetRoleDataModel,_ indexPath: Int) -> Void {
        //imgRole.image = UIImage(named: imageArray[indexPath])
        lblRoleName.text = model.name
        lblRoleDesc.text = model.kdescription
        
        if let strUrl = "\(model.attachment?.fimageUrl ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let imgUrl = URL(string: strUrl) {
             print("ImageUrl-----------------------------------------\(imgUrl)")
            //self.imgRole.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
            self.imgRole.loadCacheImage(urlString: strUrl)
        }
        if model.isSelected == true{
            containerView.backgroundColor = UIColor.init(hexString: "009A9E")  //#174E85
            lblRoleName.textColor = UIColor.white
            lblRoleDesc.textColor = UIColor.white
            //self.imgViewSelected.isHidden = false
           // self.imgViewSelected.image = UIImage(named: "overlay_on_role_selection")
        }
        else{
            containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            lblRoleName.textColor = UIColor.init(hexString: "004577")
            lblRoleDesc.textColor = UIColor.black
            //self.imgViewSelected.isHidden = true
        }

    }
    
}

class OvalView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutOvalMask()
    }

    private func layoutOvalMask() {
        let mask = self.shapeMaskLayer()
        let bounds = self.bounds
        if mask.frame != bounds {
            mask.frame = bounds
            mask.path = CGPath(ellipseIn: bounds, transform: nil)
        }
    }

    private func shapeMaskLayer() -> CAShapeLayer {
        if let layer = self.layer.mask as? CAShapeLayer {
            return layer
        }
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.black.cgColor
        self.layer.mask = layer
        return layer
    }

}
