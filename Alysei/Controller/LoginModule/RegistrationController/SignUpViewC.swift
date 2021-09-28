//
//  SignUpViewC.swift
//


import UIKit

class SignUpViewC: AlysieBaseViewC {
    
    //MARK:  - IBOutlet -
    
    @IBOutlet weak var tblViewSignUp: UITableView!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var btnProceedNext: UIButtonExtended!
   
    //MARK:  - Properties -
    
    var signUpStepOneDataModel: SignUpStepOneDataModel!
    var getRoleDataModel: [GetRoleDataModel]!
    
    //MARK:  - ViewLifeCycle Methods -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.lblMemberName.text = String.getString(self.getRoleDataModel.first?.name)
        self.btnProceedNext.setTitle((kSharedInstance.signUpViewModel.arrSignUpStepTwo.count != 0) ? AppConstants.ProceedNext : AppConstants.Submit, for: .normal)
    }
    
    //MARK:  - IBAction -
    
    @IBAction func tapBack(_ sender: UIButton) {
        
        kSharedInstance.signUpStepTwoOptionsModel = nil
        kSharedInstance.signUpViewModel = nil
        for controller in self.navigationController!.viewControllers as Array {
            //        if controller.isKind(of: RoleViewC.self) {
            //            self.navigationController!.popToViewController(controller, animated: true)
            //            break
            //        }
            if controller.isKind(of: SelectRoleViewC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func tapProceedNext(_ sender: UIButton) {
        
        let tuple = kSharedInstance.signUpViewModel.validateFields()
        if tuple.0 == false {
            self.showAlert(withMessage: tuple.1)
        }else{
            if kSharedInstance.signUpViewModel.arrSignUpStepTwo.count != 0{
                let controller = pushViewController(withName: SignUpFormViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SignUpFormViewC
                controller?.signUpStepOneDataModel = self.signUpStepOneDataModel
                controller?.getRoleDataModel = self.getRoleDataModel
            }
            else{
                self.postRequestToRegister()
            }
        }
    }
    
    //MARK:  - Private Methods -
    
    private func getSignUpTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let signUpTableCell = tblViewSignUp.dequeueReusableCell(withIdentifier: SignUpTableCell.identifier(), for: indexPath) as! SignUpTableCell
        signUpTableCell.delegate = self
        signUpTableCell.configureData(withSignUpStepOneDataModel: kSharedInstance.signUpViewModel.arrSignUpStepOne[indexPath.row])
        return signUpTableCell
    }
    
    private func getSignUpTermsTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let signUpTermsTableCell = tblViewSignUp.dequeueReusableCell(withIdentifier: SignUpTermsTableCell.identifier(), for: indexPath) as! SignUpTermsTableCell
        signUpTermsTableCell.delegate = self
        signUpTermsTableCell.configure(withSignUpStepOneDataModel: kSharedInstance.signUpViewModel.arrSignUpStepOne[indexPath.row], withSignUpStepTwoDataModel: nil)
        return signUpTermsTableCell
    }
    
    private func openPicker(withArray arr: [String],model: SignUpStepOneDataModel,keyValue keyVal: String?) -> Void {
        
        let picker = RSPickerView.init(view: self.view, arrayList: arr, keyValue: keyVal, prevSelectedValue: 0, handler: {(selectedIndex: NSInteger, response: Any?) in
                                        
                                        if let strVal = response as? String{
                                            
                                            if model.name == APIConstants.kCountry{
                                                
                                                let optionId = model.arrOptions[selectedIndex].id
                                                model.selectedValue = optionId
                                                model.selectedOptionName = strVal
                                                let filterState = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kState})
                                                filterState.first?.selectedValue = ""
                                                filterState.first?.selectedOptionName = ""
                                                let filterCity = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCity})
                                                filterCity.first?.selectedValue = ""
                                                filterCity.first?.selectedOptionName = ""
                                            }
                                            else if model.name == APIConstants.kCity{
                                                
                                                let filterTextCity = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == AppConstants.EnterYourCity})
                                                
                                                if strVal == AppConstants.Other{
                                                    model.selectedValue = strVal
                                                    model.selectedOptionName = strVal
                                                    filterTextCity.first?.required = AppConstants.Yes
                                                }
                                                else{
                                                    let optionId = model.arrOptions[selectedIndex].id
                                                    model.selectedValue = optionId
                                                    model.selectedOptionName = strVal
                                                    filterTextCity.first?.required = AppConstants.No.lowercased()
                                                }
                                            }
                                            else{
                                                let optionId = model.arrOptions[selectedIndex].id
                                                model.selectedValue = optionId
                                                model.selectedOptionName = strVal
                                            }
                                            self.tblViewSignUp.reloadData()
                                            print("selectedValue",strVal.uppercased())
                                        }})
        picker.viewContainer.backgroundColor = UIColor.white
    }
    
    private func createStringForProducts() -> String {
        let filteredSelectedProduct = self.signUpStepOneDataModel.arrOptions.map({$0}).filter({$0.isSelected == true})
        
        var selectedProductNames: [String] = []
        var selectedProductOptionIds: [String] = []
        var selectedSubProductOptionIds: [String] = []
        
        for index in 0..<filteredSelectedProduct.count {
            
            //var selectedProductId: [String] = []
            var selectedSubProductIdLocal: [String] = []
            
            selectedProductNames.append(String.getString(filteredSelectedProduct[index].optionName))
            selectedProductOptionIds.append(String.getString(filteredSelectedProduct[index].userFieldOptionId))
            
            let sections = filteredSelectedProduct[index].arrSubSections
            
            for sectionIndex in 0..<sections.count {
                
                print("arrSelectedSubOptions",sections[sectionIndex].arrSelectedSubOptions)
                selectedSubProductIdLocal.append(contentsOf: sections[sectionIndex].arrSelectedSubOptions.map({$0}))
            }
            selectedSubProductOptionIds.append(contentsOf: selectedSubProductIdLocal)
        }
        
        switch filteredSelectedProduct.count {
        case 0:
            print("No Products found")
            self.signUpStepOneDataModel.selectedOptionName = ""
        case 1:
            self.signUpStepOneDataModel.selectedOptionName = selectedProductNames[0]
        //     case 2:
        //      self.signUpStepOneDataModel.selectedOptionName = selectedProductNames[0] + ", " + selectedProductNames[1]
        default:
            let remainingProducts = (selectedProductNames.count - 1)
            self.signUpStepOneDataModel.selectedOptionName = selectedProductNames[0] + " & " + String.getString(remainingProducts) + " more"
        }
        print("product",selectedProductOptionIds)
        print("sub product",selectedSubProductOptionIds)
        
        let mergeArray = selectedProductOptionIds + selectedSubProductOptionIds
        return mergeArray.joined(separator: ", ")
    }
    
    //MARK:  - WebService Methods -
    
    private func postRequestToGetState(_ countryId: String) -> Void{
        
        let param: [String:Any] = [APIConstants.kCountryId: countryId]
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetStates + String.getString(self.getRoleDataModel.first?.roleId), method: .GET, controller: self, type: 0, param: param,btnTapped: UIButton())
    }
    
    private func postRequestToGetCity(_ stateId: String) -> Void{
        
        let param: [String:Any] = [APIConstants.kStateId: stateId]
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetCities + String.getString(self.getRoleDataModel.first?.roleId), method: .GET, controller: self, type: 1, param: param,btnTapped: UIButton())
    }
    
    private func postRequestToRegister() -> Void{
        
        btnProceedNext.isUserInteractionEnabled = false
        let dictStepOne = kSharedInstance.signUpViewModel.toDictionaryStepOne()
        
        let mergeDict = dictStepOne.compactMap { $0 }.reduce([:]) { $0.merging($1) { (current, _) in current } }
        
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kRegister, method: .POST, controller: self, type: 2, param:  mergeDict,btnTapped: self.btnProceedNext)
    }
    
  
}

//MARK:  - TableView Methods -

extension SignUpViewC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return kSharedInstance.signUpViewModel?.arrSignUpStepOne.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = kSharedInstance.signUpViewModel.arrSignUpStepOne[indexPath.row]
        
        switch model.type {
        case AppConstants.Terms:
            return self.getSignUpTermsTableCell(indexPath)
        default:
            
            return self.getSignUpTableCell(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = kSharedInstance.signUpViewModel.arrSignUpStepOne[indexPath.row]
        
        switch model.name {
        case AppConstants.Password:
            return 158.0
        case AppConstants.EnterYourCity:
            let cityModel = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCity})
            if cityModel.first?.selectedOptionName == AppConstants.Other{
                return 105.0
            }
            else{
                return 0.0
            }
        default:
            return (model.type == AppConstants.Terms) ? 95.0 : 105.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let model = kSharedInstance.signUpViewModel.arrSignUpStepOne[indexPath.row]
        
        switch model.type {
        case AppConstants.Select:
            
            switch model.name {
            
            case APIConstants.kCountry:
                let arrOptions : [String] = kSharedInstance.signUpViewModel.arrSignUpStepOne[indexPath.row].arrOptions.map({String.getString($0.name)})
                self.openPicker(withArray: arrOptions, model: model, keyValue: nil)
                
            case APIConstants.kState:
                
                let filterCountry = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCountry})
                _ = (filterCountry.first?.selectedValue?.isEmpty == true) ? showAlert(withMessage: AlertMessage.kSelectCountry) : self.postRequestToGetState(String.getString(filterCountry.first?.selectedValue))
                
            case APIConstants.kCity:
                
                let filterState = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kState})
                _ = (filterState.first?.selectedValue?.isEmpty == true) ? showAlert(withMessage: AlertMessage.kSelectState) : self.postRequestToGetCity(String.getString(filterState.first?.selectedValue))
                
            default:
                break
            }
            
        case AppConstants.Checkbox,AppConstants.Multiselect:
            
            let controller = pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
            controller?.stepOneDelegate = self
            
            if self.signUpStepOneDataModel == nil{
                controller?.signUpStepOneDataModel = kSharedInstance.signUpViewModel.arrSignUpStepOne[indexPath.row]
            }
            else{
                controller?.signUpStepOneDataModel = self.signUpStepOneDataModel
            }
        default:
            break
        }
    }
}

//SelectProduct Tapped Done

extension SignUpViewC: TappedDoneStepOne{
    
    func tapDone(_ signUpStepOneDataModel: SignUpStepOneDataModel) {
        
        self.signUpStepOneDataModel = nil
        self.signUpStepOneDataModel = signUpStepOneDataModel
        signUpStepOneDataModel.selectedValue = self.createStringForProducts()
        self.navigationController?.popViewController(animated: true)
        self.tblViewSignUp.reloadData()
    }
}

//SignUpTableCell Tapped Info

extension SignUpViewC: TappedInfo{
    
    func tapInfo(_ model: SignUpStepOneDataModel) {
        
        showAlert(withMessage: String.getString(model.hint))
        
    }
}

//TermsCell
extension SignUpViewC: SignUpTermsDelegate{
    
    func tapOnButtons(stepOneModel: SignUpStepOneDataModel?, stepTwoModel: SignUpStepTwoDataModel?) {
        
        stepOneModel?.selectedValue = (stepOneModel?.selectedValue == AppConstants.Yes.capitalized) ? AppConstants.No.capitalized : AppConstants.Yes.capitalized
        self.tblViewSignUp.reloadData()
    }
}

//APIResponse
extension SignUpViewC{
    
    override func didUserGetData(from result: Any, type: Int) {
        
        let dicResult = kSharedInstance.getDictionary(result)
        let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
        let dicRole = kSharedInstance.getDictionary(dicData[APIConstants.kRoles])
        switch type {
        case 0:
            
            let filterState = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kState})
            if let array = dicResult[APIConstants.kData] as? ArrayOfDictionary{
                filterState.first?.arrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
            }
            
            guard filterState.first != nil else { return }
            let arrOptions: [String]? = (filterState.first?.arrOptions.map({String.getString($0.name)}))
            self.openPicker(withArray: arrOptions ?? [], model: filterState.first!, keyValue: nil)
            print("state")
        case 1:
            
            let filterCity = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCity})
            if let array = dicResult[APIConstants.kData] as? ArrayOfDictionary{
                filterCity.first?.arrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
            }
            
            guard filterCity.first != nil else { return }
            let arrOptions: [String]? = (filterCity.first?.arrOptions.map({String.getString($0.name)}))
            self.openPicker(withArray: arrOptions ?? [], model: filterCity.first!, keyValue: nil)
            print("city")
        case 2:
            kSharedInstance.signUpViewModel = nil
            kSharedInstance.signUpStepTwoOptionsModel = nil
            if String.getString(dicRole[APIConstants.kRoleId]) == "10"{
                let controller = pushViewController(withName: OTPVerificationViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? OTPVerificationViewC
                controller?.email = String.getString(dicData[APIConstants.kEmail])
            }
            else{
                
                kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: dicResult)
                let roleId = String.getString(dicRole[APIConstants.kRoleId])
                let nextVC = CountryListVC()
                self.navigationController?.pushViewController(nextVC, animated: true)
                nextVC.roleId = roleId
            }
        default:
            break
        }
    }
}

