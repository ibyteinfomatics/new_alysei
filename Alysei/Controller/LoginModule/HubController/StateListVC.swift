//
//  StateListVC.swift
//  Alysie
//
//

import UIKit
var userType: String?
var hideEyeIcon: Bool?

class StateListVC: AlysieBaseViewC , SelectList {
    
    // MARK:- objects
    @IBOutlet weak var tableVIew: StateListTable!
    @IBOutlet weak var lblHeaderText: UILabel!
    var selectedHubs = [SelectdHubs]()
    var country:CountryModel?
    @IBOutlet weak var txtSearch: UITextField!
    var states:[CountryHubs]?
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var vwSearch: UIView!
    var isEditHub: Bool?
    var isChckfirstEditSlcted = true
    var roleId: String?
    var countryId: String?
    
    var searchState:[CountryHubs]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHeader.drawBottomShadowGreen()
        self.searchSetUI()
        self.tableVIew.selectDelegate = self
        self.tableVIew.roleId = self.roleId
        hideEyeIcon = true
        self.setText()
        if country != nil{
            self.countryId = country?.id
        }
//        self.isEditHub == true ? self.requestToGetSelectedState(countryId ?? "") :
        self.postRequestToGetState(countryId ?? "")
        self.txtSearch.addTarget(self, action: #selector(self.searchText(_:)), for: .allEvents)
    }
    
    
    @objc func searchText(_ text:UITextField) {
        if text.text?.isEmpty ?? false {
            self.tableVIew.states = self.states
            return
        }
        self.searchState = self.states?.filter{($0.name?.contains(ignoreCase: text.text) ?? false)}
        self.tableVIew.states = self.searchState
    }
    
    func searchSetUI(){
        vwSearch.layer.borderWidth = 0.1
        vwSearch.layer.borderColor = UIColor.lightGray.cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableVIew.reloadData()
    }
    func setText(){
        
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
            userType = "export"
        }else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "4" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "5" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "6") {
            userType = "import"
        }else{
            userType = "loreum"
        }
        if let attributedString = self.createAttributedString(stringArray: ["Select the states from ","\(country?.name ?? "")", " where you \(userType ?? "")"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "#4BB3FD")]) {
            // if let attributedString = self.createAttributedString(stringArray: ["\(country?.name ?? "")" + "/" + "\(userType ?? "")"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]) {
            self.lblHeaderText.attributedText = attributedString
        }
//        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
//            labelHeading.text = "Where you want to export?"
//        }else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "4" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "5" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "6"){
//           labelHeading.text = "Where you import?"
//        }else {
//            labelHeading.text = "Loreum lore lreum reum um ruse"
//
//        }
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        selectedHub?.state = self.states?.filter{$0.isSelected} ?? []
        if selectedHub?.state.isEmpty ?? false {
            showAlert(withMessage: "Please select atleast one state")
        }else{
            let storyBoard = UIStoryboard(name: StoryBoardConstants.kHubSelection, bundle: nil)
            let nextvc = storyBoard.instantiateViewController(identifier: "HubCitiesListViewController") as! HubCitiesListViewController
            nextvc.country = selectedHub?.country
            nextvc.roleId = self.roleId
            nextvc.city =  (self.states?.filter{$0.isSelected} ?? [])
            let statesIDs = kSharedInstance.getStringArray(nextvc.city.map{$0.id})
            for selectedHubs in self.selectedHubs {
                selectedHubs.hubs = selectedHubs.hubs.filter{statesIDs.contains($0.state_id ?? "") || String.getString($0.state_id)  == "" }
            }
            nextvc.selectedHubs = self.selectedHubs
            nextvc.isEditHub = self.isEditHub
            self.navigationController?.pushViewController(nextvc, animated: true)
        }
    }
    private func postRequestToGetState(_ countryId: String) -> Void{
        disableWindowInteraction()
        let param: [String:Any] = [APIConstants.kCountryId: countryId]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetHubState, requestMethod: .GET, requestParameters: param, withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard let data = response["data"] as? [[String:Any]] else {return}
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let hubs = kSharedInstance.getStringArray(selectedHub?.state.map{$0.id})
            self.states = data.map{CountryHubs(data: $0)}
            _ = self.states?.map{$0.isSelected = hubs.contains($0.id ?? "")}
            self.tableVIew.states = self.states
        }
    }
    
    private func requestToGetSelectedState(_ countryId: String) -> Void{
        disableWindowInteraction()
        let param: [String:Any] = [APIConstants.kCountryId: countryId]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetSelectedHubStates, requestMethod: .GET, requestParameters: param, withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard let data = response["data"] as? [[String:Any]] else {return}
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let hubs = kSharedInstance.getStringArray(selectedHub?.state.map{$0.id})
            self.states = data.map{CountryHubs(data: $0)}
            if self.isEditHub == false {
                _ = self.states?.map{$0.isSelected = hubs.contains($0.id ?? "")}
            }else if  (self.isEditHub == true) && (self.isChckfirstEditSlcted == false) {
                _ = self.states?.map{$0.isSelected = hubs.contains($0.id ?? "")}
            }
            self.tableVIew.states = self.states
        }
    }
    func didSelectList(data: Any?, index: IndexPath) {
        print(data,index)
    }
    func didSelectReviewList(data: Any?, index: IndexPath, isEdithub: Bool){
        //self.isEditHub = isEdithub
        print(data,index)
    }
}

