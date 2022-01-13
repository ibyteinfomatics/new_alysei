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
    @IBOutlet weak var labelHeadingLeading: NSLayoutConstraint!
    @IBOutlet weak var labelHeading1: UILabel!
    @IBOutlet weak var labelHeading1Leading: NSLayoutConstraint!
    @IBOutlet weak var labelHeading2: UILabel!
    @IBOutlet weak var labelHeading2Leading: NSLayoutConstraint!
    @IBOutlet weak var labelHeading3: UILabel!
    @IBOutlet weak var labelHeading3Leading: NSLayoutConstraint!
    @IBOutlet weak var labelHeading4: UILabel!
    @IBOutlet weak var labelHeading4Leading: NSLayoutConstraint!
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
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        labelHeading1Leading.constant -= view.bounds.width
//        labelHeading2Leading.constant -= view.bounds.width
//        labelHeading3Leading.constant -= view.bounds.width
//        labelHeading4Leading.constant -= view.bounds.width
//        labelHeadingLeading.constant -= view.bounds.width
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        UIView.animate(withDuration: 1.0) {
            self.labelHeading1.transform = CGAffineTransform(translationX: 120, y: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 1.0) {
                self.labelHeading2.transform = CGAffineTransform(translationX: 120, y: 0)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            UIView.animate(withDuration: 1.0) {
                self.labelHeading3.transform = CGAffineTransform(translationX: 120, y: 0)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            UIView.animate(withDuration: 1.0) {
                self.labelHeading4.transform = CGAffineTransform(translationX: 120, y: 0)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1.0) {
                self.labelHeading.transform = CGAffineTransform(translationX: 120, y: 0)
            }
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
           // labelHeading.text = "Where you want to export?"
            
            labelHeading.text = "export?"
        } else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.distributer1.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.distributer2.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.distributer3.rawValue)"){
           // labelHeading.text = "Where you import?"
            
            labelHeading.text = "import?"
        }else {
            //labelHeading.text = "Loreum lore lreum reum um ruse"
            
            labelHeading.text = "Loreum"
        }
        
//        if  kSharedUserDefaults.loggedInUserModal.memberRoleId  == "6" || kSharedUserDefaults.loggedInUserModal.memberRoleId  == "9" {
//            self.activeCountryCV.isUserInteractionEnabled = false
//        }else{
//            self.activeCountryCV.isUserInteractionEnabled = true
//        }
    }
    func animateRight(_ label : UILabel)
    {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveLinear], animations: {
            label.center.x = self.view.frame.width
        }, completion: { finished in
            if finished {
                //self.animateLeft()
            }
        })
        
      
    }
    func animateLeft()
    {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [ .autoreverse, .repeat, .curveEaseInOut, .beginFromCurrentState], animations: {
            self.labelHeading.frame.origin.x = 0.0
        }, completion: nil)
    }
}
