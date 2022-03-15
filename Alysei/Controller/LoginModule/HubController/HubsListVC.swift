//
//  HubsListVC.swift
//  Alysie
//
//

import UIKit
import Instructions

class HubsListVC: UIViewController {
    
    // MARK:- Objects
    @IBOutlet weak var tableView: HubsListTable!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var bottomStackHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewBottomStack: UIView!
    @IBOutlet weak var heightOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var lblShowSelectedHub: UILabel!
    @IBOutlet weak var btnClickHere: UIButton!
    
    
    var city = [CountryHubs]()
    var country: CountryModel?
    var selectedHubs = [SelectdHubs]()
    var hubsViaCity:[HubsViaCity]?
    var hasCome:HasCome? = .hubs
    
    var roleId: String?
    var isEditHub: Bool?
    var isChckHubfirstEditSlcted = true
    var isChckCityfirstEditSlcted = true
    var totalHub: Int?
    var selectedHubCount: Int?
    var reviewhubCount = 0
    
    let coachMarksController = CoachMarksController()
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
                self.coachMarksController.dataSource = self
                self.coachMarksController.delegate = self
        
                let skipView = CoachMarkSkipDefaultView()
                skipView.setTitle(RecipeConstants.kSkip, for: .normal)
                    self.coachMarksController.skipView = skipView
        
        self.viewHeader.drawBottomShadowGreen()
        self.viewBottomStack.addShadow()
       // self.btnClickHere.underlined(borderColor: UIColor.init(hexString: "#4BB3FD"))
        self.tableView.hasCome = self.hasCome
        self.tableView.country = self.country
        self.tableView.roleId = self.roleId
        self.tableView.passCallBack = {
            var selectedHubs = [CountryHubs]()
            for hub in self.hubsViaCity ?? [] {
                for subHub in hub.hubs_array ?? [] { if subHub.isSelected {selectedHubs.append(subHub)}}
            }
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            selectedHub?.hubs = (selectedHub?.hubs.filter{$0.type == .city} ?? []) + selectedHubs
            self.setSelectedHubLabel(selectedHub?.hubs.count, totalHub: self.totalHub)
        }
        
        if self.hasCome == .initialCountry {
            self.lblHeading.text =  "Select Hubs"
            hideEyeIcon = self.hasCome != .initialCountry
            self.bottomStack.isHidden =  false
            self.viewBottomStack.isHidden = false
            self.bottomStackHeight.constant = 40
           // self.bottomStack.backgroundColor = UIColor.init(hexString: "#1D4873")
            self.heightOfCollectionView.constant = 0
            self.callStateWiseHubListApi()
        }
    }
    
    private func callHubViewApi(){
        let countryID = String.getString(country?.id)
        let cityID = kSharedInstance.getStringArray(self.city.map{$0.id})
        let params: [String:Any] = [ "params": [ countryID: cityID]]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kgetHubs, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard  let data = response["data"] as? [String:Any] else {return}
            let hubs = kSharedInstance.getArray(withDictionary: data["hubs"])
            
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let selectedCity = kSharedInstance.getStringArray(selectedHub?.hubs.map{$0.id})
            self.hubsViaCity = hubs.map{HubsViaCity(data: $0)}
            if self.isEditHub == false{
                for hub in self.hubsViaCity ?? [] {
                    _ = hub.hubs_array?.map{ $0.isSelected = selectedCity.contains($0.id ?? "")}
                }
            }else if  (self.isEditHub == true) && (self.isChckHubfirstEditSlcted == false) {
                for hub in self.hubsViaCity ?? [] {
                    _ = hub.hubs_array?.map{ $0.isSelected = selectedCity.contains($0.id ?? "")}
                }
            }
            else{
                self.isChckHubfirstEditSlcted = false
                // self.isEditHub = false
               
            }
            
            self.tableView.hubsViaCity = self.hubsViaCity
            //self.collectionView.hubsViaCity = self.hubsViaCity
        }
    }
    
    
    private func postRequestToGetCity() -> Void{
        let cityID = kSharedInstance.getStringArray(self.city.map{$0.id})
        let param: [String:Any] = ["params": cityID]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetHubCity, requestMethod: .POST, requestParameters: param, withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard  let data = response["data"] as? [String:Any] else {return}
            let hubs = kSharedInstance.getArray(withDictionary: data["cities"])
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let selectedCity = kSharedInstance.getStringArray(selectedHub?.hubs.map{$0.id})
            self.hubsViaCity = hubs.map{HubsViaCity(city: $0)}
            
            if self.isEditHub == false{
                for hub in self.hubsViaCity ?? [] {
                    _ = hub.hubs_array?.map{ $0.isSelected = selectedCity.contains($0.id ?? "")}
                }
            }else if  (self.isEditHub == true) && (self.isChckCityfirstEditSlcted == false) {
                for hub in self.hubsViaCity ?? [] {
                    _ = hub.hubs_array?.map{ $0.isSelected = selectedCity.contains($0.id ?? "")}
                }
            }
            else{
                self.isChckCityfirstEditSlcted = false
                
            }
            self.tableView.hubsViaCity = self.hubsViaCity
            //self.collectionView.hubsViaCity = self.hubsViaCity
        }
    }
    
    func callStateWiseHubListApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetStateWiseHub + "\(country?.id ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                let hubs = kSharedInstance.getArray(withDictionary: data["hubs"])
                self.hubsViaCity = hubs.map{HubsViaCity(data: $0)}
            }
            for i in 0..<(self.hubsViaCity?.count ?? 0){
                self.totalHub = (self.totalHub ?? 0) + (self.hubsViaCity?[i].hubs_array?.count ?? 0)
            }
            for hub in self.hubsViaCity ?? [] {
                for subHub in hub.hubs_array ?? [] {
                    for selectedHubs in self.selectedHubs {
                        subHub.isSelected = selectedHubs.hubs.first{$0.id == subHub.id } != nil
                        if subHub.isSelected == true{
                            self.reviewhubCount += 1
                        }
                    }
                }
            }
            self.setSelectedHubLabel(self.reviewhubCount, totalHub: self.totalHub)
            self.tableView.hasCome = .hubs
            self.tableView.hubsViaCity = self.hubsViaCity
        }
    }
    
    func setSelectedHubLabel(_ selectedHub: Int? , totalHub: Int?){
        lblShowSelectedHub.text = "\(selectedHub ?? 0)" + " " + "of" + " " + "\(totalHub ?? 0)" + " " + "hubs selected"
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        var selectedHubs = [CountryHubs]()
        for hub in self.hubsViaCity ?? [] {
            for subHub in hub.hubs_array ?? [] { if subHub.isSelected {selectedHubs.append(subHub)}}
        }
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
//        selectedHub?.hubs = (selectedHub?.hubs.filter{$0.type == .hubs} ?? []) + selectedHubs
        selectedHub?.hubs = (selectedHub?.hubs.filter{$0.type == .city} ?? []) + selectedHubs
        let oldHubs = selectedHub?.hubs.filter{$0.type != self.hasCome} ?? []
        selectedHub?.hubs = oldHubs +  selectedHubs
        if selectedHub?.hubs.isEmpty ?? false {
            showAlert(withMessage: "Please select atleast one hub")
        }else{
            let nextVC = ConfirmSelectionVC()
            nextVC.selectedHubs = self.selectedHubs
            nextVC.updatedHubs = { hubs in
                self.selectedHubs = hubs
                for hub in self.hubsViaCity ?? [] {
                    for subHub in hub.hubs_array ?? [] {
                        for selectedHubs in hubs {
                            subHub.isSelected = selectedHubs.hubs.first{$0.id == subHub.id } != nil
                        }
                    }
                }
                self.tableView.hubsViaCity =  self.hubsViaCity
                self.tableView.reloadData()
            }
            nextVC.roleId = kSharedUserDefaults.loggedInUserModal.memberRoleId
            nextVC.isEditHub = false
            nextVC.isEditHubServerApi = self.isEditHub ?? false
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    @IBAction func clickHear(_ sender: UIButton) {
        var selectedHubs = [CountryHubs]()
        for hub in self.hubsViaCity ?? [] {
            for subHub in hub.hubs_array ?? [] { if subHub.isSelected {selectedHubs.append(subHub)}}
        }
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        selectedHub?.hubs = (selectedHub?.hubs.filter{$0.type == .city} ?? []) + selectedHubs
        let nextvc = StateListVC()
        nextvc.country = self.country
        nextvc.isEditHub = self.isEditHub
        nextvc.selectedHubs = self.selectedHubs
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        hideEyeIcon = true
        self.navigationController?.popViewController(animated: true)
    }
}

extension HubsListVC : CoachMarksControllerDataSource, CoachMarksControllerDelegate{

    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 2
    }

    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {

        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)

        switch index {
        case 0:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
            case "3", "8":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProducerHub
            case "4", "5", "6":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kImporterdistributorHub
            case "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kRestaurentsHub
            default:
                break
            }
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
            
        case 1:
            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
            case "3", "8", "4", "5", "6":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProducerClickHere
           
            case "9":
                coachViews.bodyView.hintLabel.text = TourGuideConstants.kRestaurentClickHere
            default:
                break
            }
            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
            
        default: break
        }

        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }




    func coachMarksController(_ coachMarksController: CoachMarksController,
                                  coachMarkAt index: Int) -> CoachMark {
        let indexpath1 = IndexPath(row: 0, section: 0)
        let cell1 = tableView.cellForRow(at: indexpath1) as? SelectCityTableViewCell
        switch index {
        case 0:return coachMarksController.helper.makeCoachMark(for: cell1?.buttonLeftCheckbox)
        case 1: return coachMarksController.helper.makeCoachMark(for: btnClickHere)

        default: return coachMarksController.helper.makeCoachMark()
        }
    }


    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        AppManager.setUserSeenAppInstruction()
    }
}

