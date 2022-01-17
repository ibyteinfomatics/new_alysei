//
//  ContactDetailViewController.swift
//  Alysei
//
//  Created by Janu Gandhi on 07/04/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SVProgressHUD
import CoreLocation

protocol ContactDetailDisplayLogic: class {
    func showAlertWithMessage(_ message: String)
}

class ContactDetailViewController: UIViewController, ContactDetailDisplayLogic {
    var interactor: ContactDetailBusinessLogic?
    var router: (NSObjectProtocol & ContactDetailRoutingLogic & ContactDetailDataPassing)?

   // var viewModel: ContactDetail.Contact.ViewModel!
    var viewModel:UserProfile.contactTab!
    var locationManager: CLLocationManager!
    var userType: UserRoles = .voyagers
    var flagView: FlagView!
    var countryCode = ""
    
    var countryList = [Country]()
    var Countryname : String?
    // MARK:- Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK:- Setup

    private func setup() {
        let viewController = self
        let interactor = ContactDetailInteractor()
        let presenter = ContactDetailPresenter()
        let router = ContactDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }

        if segue.identifier == "segueContactDetailsToFlagCountry" {
            if let navCon = segue.destination as? UINavigationController {
                if let countryList = navCon.viewControllers.first as? FlagCountryList {
                    countryList.didSelectCountry = { [weak self](country) in
                        let countryName = country.name.lowercased()
                        self?.countryCode = country.callingCode
                        self?.flagView?.flag.image = UIImage(named: countryName)
                        self?.flagView?.countrtyCode.text = "+\(self?.countryCode ?? "91")"
                    }
                }
            }

        }
    }

    // MARK:- View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        vwHeader.drawBottomShadow()
        self.emailTextField.placeholder = "email@example.com"
        self.phoneTextField.placeholder = "9999999999"
        self.facebookTextField.placeholder = "https://www.facebook.com"
        self.websiteTextField.placeholder = "https://www.yourwebsite.com"
        phoneTextField.delegate = self
        self.websiteTextField.delegate = self
        self.facebookTextField.delegate = self
        
        countryList = parseJSONtoCountry("Countries", fileExtension: "json")
        countryList = countryList.sorted(by: { $0.name < $1.name })
        
        for i in 0..<countryList.count {
            
            if viewModel.country_code == countryList[i].callingCode{
                Countryname = countryList[i].name
            }
            
        }

        if viewModel != nil {
            self.emailTextField.text = "\(viewModel.email ?? "")"
            self.phoneTextField.text = "\(viewModel.phone ?? "")"
            self.addressTextField.text = "\(viewModel.address ?? "")"
            self.websiteTextField.text = "\(viewModel.website ?? "")"
            self.facebookTextField.text = "\(viewModel.fbLink ?? "")"
            self.countryCode = viewModel.country_code ?? self.countryCode
        }
        if viewModel.country_code == nil{
            if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)" ||  kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voiceExperts.rawValue)" ||
                kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.travelAgencies.rawValue)"{
                self.countryCode = "+39"
            }else {
                self.countryCode = "+1"
            }
        }
        
        self.phoneTextField.keyboardType = .numberPad
        self.addButtonToTextField(self.phoneTextField)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

//     MARK:- IBOutlets
    @IBOutlet var emailTextField: UITextFieldExtended!
    @IBOutlet var phoneTextField: UITextFieldExtended!
    @IBOutlet var addressTextField: UITextFieldExtended!
    @IBOutlet var websiteTextField: UITextFieldExtended!
    @IBOutlet var facebookTextField: UITextFieldExtended!
    @IBOutlet weak var vwHeader: UIView!

    // MARK:- protocol methods

    func showAlertWithMessage(_ message: String) {
        SVProgressHUD.dismiss()
        
        //let alert:UIAlertController = UIAlertController(title: AlertTitle.appName, message: message, preferredStyle: UIAlertController.Style.alert)


        //let okayAction = UIAlertAction(title: AlertMessage.kOkay,
                                      // style: UIAlertAction.Style.default) { (action) in
            self.backButtonTapped()
        //}

        //alert.addAction(okayAction)
        //self.present(alert, animated: true, completion: nil)

    }



    func addressTextFieldSelected(_ sender: UITextField) -> Void{

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
                controller?.dismiss = { [weak self] (mapAddressModel , latitude, longitude) in
                    if mapAddressModel.address2 == "" {
                        self?.addressTextField.text = "\(mapAddressModel.address1), \(mapAddressModel.mapAddress)".capitalized
                    }else if mapAddressModel.address1 == "" {
                        self?.addressTextField.text = "\(mapAddressModel.address2), \(mapAddressModel.mapAddress)".capitalized
                    }else{
                    self?.addressTextField.text = "\(mapAddressModel.address1), \(mapAddressModel.address2)"
                        //, \(mapAddressModel.mapAddress)".capitalized
                    }
                }
//                controller?.delegate = self
            default:
                break
            }
        }
    }


    public func pushViewController(withName name: String, fromStoryboard storyboard: String) -> UIViewController {

        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)

        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }

    //MARK:- custom methods

    private func validateAllfields() -> Bool {

       guard self.emailTextField.text?.isValid(.email) == true else {
            showAlert(withMessage: "Please enter a valid email ID.")
        return false
        }

        guard self.phoneTextField.text?.isValid(.mobileNumber) == true else {
            showAlert(withMessage: "Please enter a valid phone number.")
            return false
        }

        if !(self.facebookTextField.text?.isEmpty ?? true) {
            guard self.facebookTextField.text?.isValid(.facebook) == true else {
                showAlert(withMessage: "Please enter a valid facebook url.")
                return false
            }
        }


        if (self.userType == .voyagers || self.userType == .voiceExperts) && (self.websiteTextField.text?.count ?? 0 > 0)  {
            guard self.websiteTextField.text?.isValid(.url) == true else {
                showAlert(withMessage: "Please enter a valid URL.")
                return false
            }
        } else {
            guard self.websiteTextField.text?.isValid(.url) == true else {
                showAlert(withMessage: "Please enter a valid URL.")
                return false
            }
        }

        return true
    }

    private func addButtonToTextField(_ textField: UITextFieldExtended) {

        guard let flag = Bundle.main.loadNibNamed("Flag", owner: self, options: nil)?.first as? FlagView else {
            return
        }
        flagView = flag
        flagView.button.addTarget(self, action: #selector(presentCountryList(_:)), for: .touchUpInside)
        if viewModel.phone == nil {
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)" ||  kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voiceExperts.rawValue)" ||
            kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.travelAgencies.rawValue)"{
            flagView.flag.image = UIImage(named: "italy")
            flagView.countrtyCode.text = "+39"
        }else {
            flagView.flag.image = UIImage(named: "united states")
            flagView.countrtyCode.text = "+1"
        }
        }else{
//            let flagImage = countryName(from: viewModel.country_code ?? "")
//            print("flagImage---------------------\(flagImage)")
            flagView.flag.image = UIImage(named: Countryname?.lowercased() ?? "" )
            flagView.countrtyCode.text = "+" + (viewModel.country_code ?? "")
        }
        
//        flagView.flag.image = UIImage(named: "india")
//        flagView.countrtyCode.text = "+91"
        flag.flag.centerVertically()
        flag.countrtyCode.centerVertically()

        textField.leftViewMode = .always
        textField.leftView = flagView
        textField.rightView = UIView()
    }
   
    @objc func presentCountryList(_ sender: UIButton) {
        performSegue(withIdentifier: "segueContactDetailsToFlagCountry", sender: self)
    }

    // MARK:- @IBAction methods

    @IBAction func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {

        if self.validateAllfields() {
            SVProgressHUD.show()

            let requestModel = ContactDetail.Contact.Request(phone: self.phoneTextField.text,
                                                             address: self.addressTextField.text,
                                                             website: self.websiteTextField.text,
                                                             facebookURL: self.facebookTextField.text,
                                                             countryCode: self.countryCode)
            self.interactor?.updateContactDetail(requestModel)

        }
    }

    @IBAction func websiteInfoButtonTapped(_ sender: UIButton) {
        showAlert(withMessage: "URL format should be like \n https://www.example.com/")
    }

    @IBAction func facebookInfoButtonTapped(_ sender: UIButton) {
        showAlert(withMessage: "URL format should be like \n https://www.facebook.com/username")
    }
    
    func countryName(from countryCode: String) -> String{
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
            // Country name was found
            return name
        } else {
            // Country name cannot be found
            return countryCode
        }
       
    }
   // func countryName(countryCode: String) -> String? {
   //     let current = Locale.current.localizedString(forIdentifier: "en_US")
      //  return current.localizedString(forRegionCode: countryCode)
  //  }
    
  
}


extension ContactDetailViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.addressTextField {
            self.addressTextFieldSelected(textField)
            return false
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField ==  websiteTextField {
            if textField.text == "https://" {
                textField.text = ""
                textField.placeholder = "https://www.yourwebsite.com"
            }
        }
        if  textField == facebookTextField  {
            if textField.text == "https://www.facebook.com/" {
                textField.text = ""
                textField.placeholder = "https://www.facebook.com"
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    print("Backspace was pressed")
                    return true
                }
            }
            if (textField.text?.count ?? 0) < 10 {
                return true
            }else{
                return false
            }

        }
        if textField == websiteTextField{
            if textField.text == "" {
            websiteTextField.text = "https://"
            }
//            if let char = string.cString(using: String.Encoding.utf8) {
//                let isBackSpace = strcmp(char, "\\b")
//                if textField.text == "https://"{
//                if (isBackSpace == -92) {
//                    print("Backspace was pressed")
//                    return false
//                }else{
//                    return true
//                }
//                }
//            }
        }
        
        if textField == facebookTextField{
            if textField.text == "" {
                facebookTextField.text = "https://www.facebook.com/"
            }
//            if let char = string.cString(using: String.Encoding.utf8) {
//                let isBackSpace = strcmp(char, "\\b")
//                if textField.text == "https://"{
//                if (isBackSpace == -92) {
//                    print("Backspace was pressed")
//                    return false
//                }else{
//                    return true
//                }
//                }
//            }
        }

        return true
    }
}

extension ContactDetailViewController: SaveAddressCallback {

    func addressSaved(_ model: SignUpStepTwoDataModel, addressLineOne: String, addressLineTwo: String, mapAddress: String?) {

        self.navigationController?.popViewController(animated: true)
//        model.selectedValue = addressLineOne +  " " + addressLineTwo + ", " + "\((mapAddress ?? ""))"
//        model.selectedAddressLineOne = addressLineOne
//        model.selectedAddressLineTwo = addressLineTwo
//
//        let latModel = kSharedInstance.signUpViewModel.arrSignUpStepTwo.filter({$0.name == AppConstants.KeyLatitude})
//        latModel.first?.selectedValue = String(kSharedUserDefaults.latitude)
//        let longModel = kSharedInstance.signUpViewModel.arrSignUpStepTwo.filter({$0.name == AppConstants.KeyLongitude})
//        longModel.first?.selectedValue = String(kSharedUserDefaults.longitude)
           print("AddressLine1 ", addressLineOne)
            print("AddressLine2", addressLineTwo)

            self.addressTextField.text = "\(addressLineOne) \(addressLineTwo)" //" \(mapAddress)"


    }
}
