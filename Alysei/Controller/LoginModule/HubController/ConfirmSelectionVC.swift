//
//  ConfirmSelectionVC.swift
//  Alysie
//
//

import UIKit
import SVProgressHUD

class ConfirmSelectionVC: UIViewController , SelectList{
    
    var selectedHubs = [SelectdHubs]()
    //var reviewSelectedHubs : ReviewHubModel.reviewHubModel?
    var reviewSelectedHubs : [ReviewSelectedHub]?
    //var checkNoHubCallBack:(()  ->Void?) = nil
    // var reviewSelectedHubs :
    
    @IBOutlet weak var tableView: ConfirmSelectionTable!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblheading: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    
    var updatedHubs:(([SelectdHubs])->())?
    var roleId: String?
    var isEditHub:Bool?
    var isEditHubServerApi = false
    var dataDelegate:SelectList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblheading.text = LogInSignUp.kSelectedHubs
        btnEdit.setTitle(LogInSignUp.kEdit, for: .normal)
        self.viewHeader.drawBottomShadowGreen()
        self.tableView.dataDelegate = self
        self.tableView.selectedHubs = selectedHubs
        self.tableView.roleId = self.roleId
        self.tableView.isEditHub = self.isEditHub
        self.tableView.callback = {
            let nextVC = CountryListVC(nibName: "CountryListVC", bundle: nil)
            nextVC.isEditHub = self.isEditHub
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        if isEditHub == true{
            self.isEditHubServerApi = true
            self.callReviewHubApi()
        }
    }
    
    func didSelectList(data: Any?, index: IndexPath) {
        guard let data = data as? SelectdHubs else {return}
        let nextVC = HubsListVC(nibName: "HubsListVC", bundle: nil)
        nextVC.country = data.country
        nextVC.selectedHubs = self.selectedHubs
        nextVC.isEditHub = self.isEditHub
        nextVC.selectedHubs = self.selectedHubs
        nextVC.hasCome = .initialCountry
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func didSelectReviewList(data: Any?, index: IndexPath, isEdithub:Bool) {
        guard let data = data as? ReviewSelectedHub else {return}
        let nextVC = HubsListVC(nibName: "HubsListVC", bundle: nil)
        nextVC.country = CountryModel(name:String.getString(data.country_name) , id: String.getString(data.country_id))
        self.selectedHubs.first?.country = nextVC.country ?? CountryModel()
        nextVC.selectedHubs = self.selectedHubs
        nextVC.isEditHub = self.isEditHub
        nextVC.selectedHubs = self.selectedHubs
        nextVC.isEditHub = self.isEditHub
        nextVC.hasCome = .initialCountry
        //nextVC.reviewhubCount = self.reviewSelectedHubs?.count ?? 0
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.updatedHubs?(self.selectedHubs)
    }
    
    
    @IBAction func proceedNext(_ sender: UIButton) {
//        if isEditHub == true && self.isEditHubServerApi {
//            self.selectedHubs.first?.hubs = self.reviewSelectedHubs?.first?.hubs
//        }
        var allHubs = [CountryHubs]()
        var addOrUpdate = 0
        for hub in self.selectedHubs {
            allHubs = allHubs + (hub.hubs )
        }
        if allHubs.isEmpty  && isEditHubServerApi != true {
            showAlert(withMessage: "Please select at least 1 hub to continue")
        }else{
            let selectedCity = allHubs.filter{$0.type == .city}
            let selectedHubs = allHubs.filter{$0.type == .hubs}
            let hubsID = selectedHubs.map{Int.getInt($0.id)}
//            if self.isEditHubServerApi == true {
//                addOrUpdate = 2
//            }else{
//                addOrUpdate = 1
//            }
           // "add_or_update": addOrUpdate
            let params = ["params":["add_or_update": editHubValue ?? "1",
                                    "selectedhubs":hubsID,
                                    "selectedcity":self.createCityJson(hubs: selectedCity)]]
            print(params)
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPostHub, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResposne, error, errorType, statuscode) in
                kSharedAppDelegate.pushToTabBarViewC()
            }
        }
    }
    
//    @IBAction func nextVC(_ sender: UIButton) {
//        if isEditHub == true{
//
//        }else{
//            if self.selectedHubs.isEmpty {
//                showAlert(withMessage: "Please select at least 1 hub to continue"){
//                    self.updatedHubs?(self.selectedHubs)
//                    self.navigationController?.popViewController(animated: true)
//                }
//                return
//            }
//            self.updatedHubs?(self.selectedHubs)
//        }
//        self.navigationController?.popViewController(animated: true)
//    }
    @IBAction func btnEditHub(_ sender: UIButton){
        var hub: SelectdHubs?
        hub = selectedHubs[0]
        if self.isEditHub == true{
            let hub = self.reviewSelectedHubs?[0]
            let indexpath = IndexPath(row: 0, section: 1)
            self.didSelectReviewList(data: hub, index: indexpath, isEdithub: self.isEditHub ?? false)
        }else{
            let indexpath = IndexPath(row: 0, section: 1)
            self.didSelectList(data: hub, index: indexpath)
        }
    }

    func createCityJson(hubs:[CountryHubs]?)->[[String:Any]] {
        var params = [[String:Any]]()
        for hub in hubs ?? [] {
            var pm = [String:Any]()
            pm["country_id"] = hub.country_id
            pm["state_id"] = hub.state_id
            pm["city_id"] = hub.id
            params.append(pm)
        }
        return params
    }
    func removeHubInCaseOfEdit(_ title: String?){
        self.selectedHubs.first?.hubs = self.selectedHubs.first?.hubs.filter({$0.name != title}) ?? []
        
    }
}

extension ConfirmSelectionVC {
    func callReviewHubApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: "\(APIUrl.kReviewHub)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statuscode) in
            print("success")
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                
                let hubsArray = kSharedInstance.getArray(withDictionary: data)
                self.reviewSelectedHubs = hubsArray.map{ReviewSelectedHub(with: $0)}
                self.selectedHubs = [SelectdHubs()]
                let hubsList = kSharedInstance.getDictionary(data)
                let hubList = kSharedInstance.getArray(withDictionary: hubsList["hubs"])
                let hubs = hubList.map{CountryHubs(HubsFromServer: $0)}
                let citiesArray = kSharedInstance.getArray(withDictionary: hubsList["cities"])
                let cities = citiesArray.map{CountryHubs(cityFromServer: $0)}
                self.selectedHubs.first?.hubs = (cities + hubs).uniqueArray(map: {$0.id})
                let state_ids = kSharedInstance.getStringArray(cities.map{$0.state_id})
                let state = state_ids.map{CountryHubs(stateID:$0)}
                self.selectedHubs.first?.state = state
            }
          
            self.tableView.reviewSelectedHubs = self.reviewSelectedHubs
            self.tableView.reloadData()
        }
    }
}

