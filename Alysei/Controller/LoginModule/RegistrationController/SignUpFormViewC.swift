//
//  SignUpFormViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 14/01/21.
//

import UIKit
import CoreLocation

class SignUpFormViewC: AlysieBaseViewC{
    
  //MARK: - Outlet -
    
  @IBOutlet weak var tblViewSignUpForm: UITableView!
  @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var header: UIView!
  @IBOutlet weak var btnSubmit: UIButtonExtended!
  
  //MARK: - Properties -

  var signUpStepOneDataModel: SignUpStepOneDataModel!
  var getRoleDataModel: [GetRoleDataModel]!
  var locationManager: CLLocationManager!
    var cOptionId: String?
  //MARK:  - ViewLifeCycle Methods -
    
  override func viewDidLoad() {
    
    super.viewDidLoad()
    header.drawBottomShadow()
    if getRoleDataModel.first?.roleId == "9"{
      self.getCurrentLocation()
    }
    self.lblMemberName.text = String.getString(self.getRoleDataModel.first?.name)
  }
  
  //MARK:  - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapSubmit(_ sender: UIButton) {
    
    let tuple = kSharedInstance.signUpViewModel.validateFieldsStepTwo()
    _ = (tuple.0 == false) ? showAlert(withMessage: tuple.1) : self.postRequestToRegister()
  }
    
  //MARK:  - Private Methods -
  
  private func getCurrentLocation() {
  
  if (CLLocationManager.locationServicesEnabled()) {
    print(AlertMessage.kLocationEnabled)
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  } else {
    print(AlertMessage.kLocationNotEnabled)
   }
  }
  
  func checkLocation(_ model: SignUpStepTwoDataModel) -> Void{
    
    if CLLocationManager.locationServicesEnabled() {
      
      switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
          
          showTwoButtonsAlert(message: AlertMessage.kLocationPopUp, buttonTitle: AppConstants.Settings){
          if let bundleId = Bundle.main.bundleIdentifier,
            let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)"){
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
          }
        }
        case .authorizedAlways, .authorizedWhenInUse:
          let controller = pushViewController(withName: MapViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? MapViewC
          controller?.signUpStepTwoDataModel = model
          controller?.delegate = self
      default:
         break
      }
    }
  }

  private func getSignUpRadioTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let signUpFormTableCell = tblViewSignUpForm.dequeueReusableCell(withIdentifier: SignUpFormTableCell.identifier(), for: indexPath) as! SignUpFormTableCell
    signUpFormTableCell.configure(withSignUpStepTwoDataModel: kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row])
    signUpFormTableCell.delegate = self
    return signUpFormTableCell
  }
  
  private func getSignUpFormSelectTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let signUpFormSelectTableCell = tblViewSignUpForm.dequeueReusableCell(withIdentifier: SignUpFormSelectTableCell.identifier(), for: indexPath) as! SignUpFormSelectTableCell
    signUpFormSelectTableCell.configureData(withSignUpStepTwoDataModel: kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row])
    return signUpFormSelectTableCell
  }
  
  private func getSignUpFormMultiCheckBoxTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let signUpMultiCheckboxTableCell = tblViewSignUpForm.dequeueReusableCell(withIdentifier: SignUpMultiCheckboxTableCell.identifier(), for: indexPath) as! SignUpMultiCheckboxTableCell
    signUpMultiCheckboxTableCell.delegate = self
    signUpMultiCheckboxTableCell.configureData(withSignUpStepTwoDataModel: kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row])
    return signUpMultiCheckboxTableCell
  }
  
  private func getSignUpTermsTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let signUpTermsTableCell = tblViewSignUpForm.dequeueReusableCell(withIdentifier: SignUpTermsTableCell.identifier(), for: indexPath) as! SignUpTermsTableCell
    signUpTermsTableCell.delegate = self
    signUpTermsTableCell.configure(withSignUpStepOneDataModel: nil, withSignUpStepTwoDataModel: kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row])
    return signUpTermsTableCell
  }

  private func openPicker(withArray arr: [String],model: SignUpStepTwoDataModel,keyValue keyVal: String?) -> Void {
    
    let picker = RSPickerView.init(view: self.view, arrayList: arr, keyValue: keyVal, prevSelectedValue: 0, handler: {(selectedIndex: NSInteger, response: Any?) in
      
      if let strVal = response as? String{
        
        if model.arrOptions[selectedIndex].userFieldOptionId.isEmpty == true{
          kSharedInstance.signUpViewModel.roleId = model.arrOptions[selectedIndex].roleid
        }
        else{
          let optionId = model.arrOptions[selectedIndex].userFieldOptionId
            self.cOptionId = optionId
          model.selectedValue = optionId
        }
        model.selectedOptionName = strVal
       // model.selectedValue = strVal
        model.selectedValue = self.cOptionId
        
        self.tblViewSignUpForm.reloadData()
        print("selectedValue",strVal.uppercased())
      }})
    picker.viewContainer.backgroundColor = UIColor.white
  }
  
  private func createStringForProducts(_ model: SignUpStepTwoDataModel) -> String{
    
    let filteredSelectedProduct = model.arrOptions.map({$0}).filter({$0.isSelected == true})
    
    var selectedProductNames: [String] = []
    var selectedProductOptionIds: [String] = []
   
    for index in 0..<filteredSelectedProduct.count {
     
      selectedProductNames.append(String.getString(filteredSelectedProduct[index].optionName))
      selectedProductOptionIds.append(String.getString(filteredSelectedProduct[index].userFieldOptionId))
    }
    switch filteredSelectedProduct.count {
     case 0:
      print("No Products found")
     case 1:
      model.selectedOptionName = selectedProductNames[0]
//     case 2:
//      model.selectedOptionName = selectedProductNames[0] + ", " + selectedProductNames[1]
     default:
       let remainingProducts = (selectedProductNames.count - 1)
       model.selectedOptionName = selectedProductNames[0] + " & " + String.getString(remainingProducts) + " more"
     }
    print("product",selectedProductOptionIds)
    let mergeArray = selectedProductOptionIds
    return mergeArray.joined(separator: ", ")
  }
  
  //MARK:  - WebService Methods -
  
  private func postRequestToRegister() -> Void{
    
    self.btnSubmit.isUserInteractionEnabled = false
    let dictStepOne = kSharedInstance.signUpViewModel.toDictionaryStepOne()
    let dictStepTwo = kSharedInstance.signUpViewModel.toDictionaryStepTwo()

    let mergeDict = dictStepOne + dictStepTwo
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kRegister, method: .POST, controller: self, type: 0, param:  mergeDict.compactMap { $0 }.reduce([:]) { $0.merging($1) { (current, _) in current } },btnTapped: self.btnSubmit)
  }
}

//MARK:  - TableView Methods -

extension SignUpFormViewC: UITableViewDataSource, UITableViewDelegate{
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return kSharedInstance.signUpViewModel?.arrSignUpStepTwo.count ?? 0
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let model = kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row]
    switch model.type {
    case AppConstants.Select,AppConstants.Text,AppConstants.Multiselect,AppConstants.Map:
      return self.getSignUpFormSelectTableCell(indexPath)
    case AppConstants.Radio:
      return self.getSignUpRadioTableCell(indexPath)
    case AppConstants.Checkbox:
      return self.getSignUpFormMultiCheckBoxTableCell(indexPath)
    case AppConstants.Terms:
      return self.getSignUpTermsTableCell(indexPath)
    default:
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let model = kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row]
    
    switch model.type {
    case AppConstants.Select:
      let arrOptions : [String] = kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row].arrOptions.map({String.getString($0.optionName)})
      self.openPicker(withArray: arrOptions, model: model, keyValue: nil)
    case AppConstants.Multiselect:
      let controller = pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
      controller?.signUpStepTwoDataModel = model
      controller?.stepTwoDelegate = self
    case AppConstants.Map:
      //self.getCurrentLocation()

      self.checkLocation(model)
      //_ = pushViewController(withName: MapViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) 
    default:
      break
    }
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let model = kSharedInstance.signUpViewModel.arrSignUpStepTwo[indexPath.row]
    
    switch model.type {
    
    case AppConstants.Select:
    
      if kSharedInstance.signUpStepTwoOptionsModel == nil{
        
        if (model.parentId?.isEmpty == false){
          model.isHidden = true
          return 0.0
        }
        else{
          model.isHidden = false
          return 110.0
        }
        //return (model.parentId?.isEmpty == false) ? 0.0 :  110.0
      }
      else{
        
        let parentIdArray = kSharedInstance.signUpViewModel.arrSignUpStepTwo.map({$0.parentId})
        var selectedIndex: [Int?] = []
      
        for i in 0..<kSharedInstance.signUpStepTwoOptionsModel.count{
        
          let firstIndex = parentIdArray.firstIndex(where: {$0 == kSharedInstance.signUpStepTwoOptionsModel[i].userFieldOptionId})
          selectedIndex.append(firstIndex)
        }
        print("indexs",selectedIndex)
        
        if selectedIndex.contains(indexPath.row) || model.parentId?.isEmpty == true{
          model.isHidden = false
         // return 110.0
            return 90.0
        }
        else{
          model.isHidden = true
          return 0.0
        }
       }
    case AppConstants.Text,AppConstants.Multiselect,AppConstants.Map:
     // return 110.0
        return 90
    case AppConstants.Radio:
      return 97.0
    case AppConstants.Checkbox:
     // return 118.0
      return 100
    case AppConstants.Terms:
      return 95.0
    default:
      return 0.0
    }
  }
}

//RadioCell
extension SignUpFormViewC: TappedSwitch{
  
  func tapSwitch(_ stepTwoModel: SignUpStepTwoDataModel?, _ stepOneModel: SignUpStepOneDataModel?, switchAnswer: UISwitch, btn: UIButton, currentTapType: Int?) {
    
    switch currentTapType {
    case 0:
      stepTwoModel?.selectedValue = (switchAnswer.isOn == true) ? AppConstants.Yes.capitalized : AppConstants.No
      self.tblViewSignUpForm.reloadData()
    case 1:
      showAlert(withMessage: String.getString(stepTwoModel?.hint))
    default:
      break
    }    
  }
}

//CheckboxCell
extension SignUpFormViewC: SignUpMultiSelectDelegate{
  
  func tappedCheckBox(collectionView: UICollectionView, signUpStepTwoOptionsModel: SignUpStepTwoOptionsModel?, signUpStepTwoDataModel: SignUpStepTwoDataModel?, signUpStepOneDataModel: SignUpStepOneDataModel?, btn: UIButton, cell: SignUpMultiCheckboxTableCell) {
    
    
    if btn == cell.btnInfo{
      
      showAlert(withMessage: String.getString(signUpStepTwoDataModel?.hint))
    }
    else{

      signUpStepTwoOptionsModel?.isSelected = (signUpStepTwoOptionsModel?.isSelected == true) ? false : true
      collectionView.reloadData()

      kSharedInstance.signUpStepTwoOptionsModel = signUpStepTwoDataModel?.arrOptions.filter({$0.isSelected == true})
      
      var selectedOptionId:[String] = []
      for i in 0..<kSharedInstance.signUpStepTwoOptionsModel.count{
       // selectedOptionId.append(String.getString(signUpStepTwoDataModel?.arrOptions[i].userFieldOptionId))
        selectedOptionId.append(String.getString(kSharedInstance.signUpStepTwoOptionsModel?[i].userFieldOptionId))
      }
      signUpStepTwoDataModel?.selectedValue = selectedOptionId.joined(separator: ", ")
        print("SelectedOptionId------------------------------------------------------------------\(selectedOptionId)")
        print("SelectedValue------------------------------------------------------------------\(signUpStepTwoDataModel?.selectedValue ?? "")")
    }
    self.tblViewSignUpForm.reloadData()
  }
}
 
//TermsCell
extension SignUpFormViewC: SignUpTermsDelegate{
  
  func tapOnButtons(stepOneModel: SignUpStepOneDataModel?, stepTwoModel: SignUpStepTwoDataModel?) {
    
    stepTwoModel?.selectedValue = (stepTwoModel?.selectedValue == AppConstants.Yes.capitalized) ? AppConstants.No.capitalized : AppConstants.Yes.capitalized
    self.tblViewSignUpForm.reloadData()
  }
}

//SelectCell
extension SignUpFormViewC: TappedDoneStepTwo{
  
  func tapDone(_ signUpStepTwoDataModel: SignUpStepTwoDataModel) {
    
    let value = self.createStringForProducts(signUpStepTwoDataModel)
    signUpStepTwoDataModel.selectedValue = value
    self.navigationController?.popViewController(animated: true)
    self.tblViewSignUpForm.reloadData()
  }
}

extension SignUpFormViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    kSharedInstance.signUpViewModel = nil
    kSharedInstance.signUpStepTwoOptionsModel = nil
    let dicResult = kSharedInstance.getDictionary(result)
    let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
    let dicRole = kSharedInstance.getDictionary(dicData[APIConstants.kRoles])
    //let accessToken = kSharedInstance.getDictionary(dicData[APIConstants.kToken])
  
    if String.getString(dicRole[APIConstants.kRoleId]) == "10"{
      let controller = pushViewController(withName: OTPVerificationViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? OTPVerificationViewC
      controller?.email = String.getString(dicData[APIConstants.kEmail])
    }
    else{
      
      kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: dicResult)
      kSharedUserDefaults.alyseiReview =  Int.getInt(dicData["alysei_review"])
      let roleId = String.getString(dicRole[APIConstants.kRoleId])
      let nextVC = CountryListVC()
        nextVC.roleId = roleId
//        nextVC.isEditHub = false
      self.navigationController?.pushViewController(nextVC, animated: true)
    }
  }
}

//MARK: - LocationManagerDelegate Methods -

extension SignUpFormViewC: CLLocationManagerDelegate{
 
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    
   NotificationCenter.default.removeObserver(self)
   manager.stopUpdatingLocation()
   let location = locations.last! as CLLocation
   kSharedUserDefaults.latitude = location.coordinate.latitude
   kSharedUserDefaults.longitude = location.coordinate.longitude
   //_ = pushViewController(withName: MapViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
 }
}


extension SignUpFormViewC: SaveAddressCallback{
  
    func addressSaved(_ model: SignUpStepTwoDataModel, addressLineOne: String, addressLineTwo: String, mapAddress: String?) {
    
    self.navigationController?.popViewController(animated: true)
        model.selectedValue = addressLineOne +  " " + addressLineTwo //+ ", " + "\((mapAddress ?? ""))"
    model.selectedAddressLineOne = addressLineOne
    model.selectedAddressLineTwo = addressLineTwo
    
    let latModel = kSharedInstance.signUpViewModel.arrSignUpStepTwo.filter({$0.name == AppConstants.KeyLatitude})
    latModel.first?.selectedValue = String(kSharedUserDefaults.latitude)
    let longModel = kSharedInstance.signUpViewModel.arrSignUpStepTwo.filter({$0.name == AppConstants.KeyLongitude})
    longModel.first?.selectedValue = String(kSharedUserDefaults.longitude)
    
    self.tblViewSignUpForm.reloadData()
    
  }
}
