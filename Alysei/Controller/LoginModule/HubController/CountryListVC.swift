//
//  CountryListVC.swift
//  Alysie
//
//

import UIKit

enum HasCome {case initialCountry,showCountry,hubs,city }

class CountryListVC: AlysieBaseViewC ,SelectList {
    //MARK: - IBOutlet
    @IBOutlet weak var activeCountryCV: ActiveCollectionView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var btnBackWidth: NSLayoutConstraint!
    @IBOutlet weak var activeInactiveView: UIView!
    
    
    //MARK: - Properties -
    var countries:[CountryModel]?
    var roleId: String?
    var arrActiveUpcoming: ActiveUpcomingCountry?
    var addOrUpdate: Int?
    var isEditHub: Bool?
    var selectedHubs = [SelectdHubs]()
    
    // MARK: - ViewLifeCycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        if isEditHub == true {
            self.requestToSelectedHubGetCountries()
        }else{
        self.postRequestToGetCountries()
        }
    }

    private func postRequestToGetCountries() {
        self.disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetUpcomingCountries, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let dicResult = kSharedInstance.getDictionary(dictResponse)
            guard let data = dicResult["data"] as? [String:Any] else {return}
            self.arrActiveUpcoming = ActiveUpcomingCountry.init(data: data)
            self.activeCountryCV.countries = self.arrActiveUpcoming?.arrActiveCountries
        }
    }
    private func requestToSelectedHubGetCountries() {
        self.disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetSelectedHubCountry, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let dicResult = kSharedInstance.getDictionary(dictResponse)
            guard let data = dicResult["data"] as? [String:Any] else {return}
            self.arrActiveUpcoming = ActiveUpcomingCountry.init(data: data)
            self.activeCountryCV.countries = self.arrActiveUpcoming?.arrActiveCountries
        }
    }

    //MARK:  - IBAction -
    func didSelectList(data: Any?, index: IndexPath) {
        guard let data = data as? CountryModel else {return}
        let nextVC = HubsListVC(nibName: "HubsListVC", bundle: nil)
        nextVC.country = data
        nextVC.selectedHubs =  [SelectdHubs.createHub(country: data)]
        nextVC.hasCome = .initialCountry
        nextVC.roleId = kSharedUserDefaults.loggedInUserModal.memberRoleId
        self.enableWindowInteraction()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    
    /// func for configure UI
    func configureUI() {
        self.viewHeader.addShadow()
        self.activeInactiveView.isHidden = false
        self.activeCountryCV.hascome = .showCountry
        self.activeCountryCV.selectDelegate = self
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)" {
            labelHeading.text = "Where you want to export?"
        } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.distributer1.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.distributer2.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.distributer3.rawValue)"){
            labelHeading.text = "Where you import?"
        }else {
            labelHeading.text = "Loreum lore lreum reum um ruse"
        }
        
//        if  kSharedUserDefaults.loggedInUserModal.memberRoleId  == "6" || kSharedUserDefaults.loggedInUserModal.memberRoleId  == "9" {
//            self.activeCountryCV.isUserInteractionEnabled = false
//        }else{
//            self.activeCountryCV.isUserInteractionEnabled = true
//        }
    }
}
