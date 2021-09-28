//
//  HubsViaCityCell.swift
//  Alysie
//

import UIKit

class HubsViaCityCell: UITableViewCell , SelectList{
    @IBOutlet weak var tableView: StateListTable!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewSearchHeight:NSLayoutConstraint!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblNoHub: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var noHubImage: UIImageView!
    var hasCome:HasCome? = .hubs
    var arrhubsViaCity:[HubsViaCity]?
    var hubsViaCity = HubsViaCity()
    var checkList: String?
    var country: CountryModel?
    var filterHubs = HubsViaCity()
    var passCallback : (() -> Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewSearchHeight.constant = hasCome == .hubs ? 0 : 45
        self.viewSearch.isHidden = hasCome == .hubs
        self.txtSearch.isHidden = hasCome == .hubs
        self.txtSearch.isHidden = self.hasCome == .hubs
        self.filterHubs.hubs_array = hubsViaCity.hubs_array
        self.tableView.hubLatitude = hubsViaCity.latitude
        self.tableView.hubLongitude = hubsViaCity.longitude
        self.tableView.hubRadius = hubsViaCity.radius
        self.lblNoHub.isHidden = filterHubs.hubs_array?.isEmpty == false
        //self.noHubImage.isHidden = filterHubs.hubs_array?.isEmpty == true
        self.noHubImage.isHidden = true
        self.tableView.states = filterHubs.hubs_array
        self.tableView.arrhubsViaCity = self.arrhubsViaCity
        self.tableView.selectDelegate = self
        self.tableView.hasCome = .hubs
        self.tableView.hubCountCallBack = {
            print("Passing Hub Count")
            self.passCallback?()
        }
        self.txtSearch.addTarget(self, action: #selector(self.didchange(_:)), for: .editingChanged)
        self.setText()
    }
    
    func setText(){
        self.checkList = hasCome == .hubs ? "hubs" : "city"
        // if let attributedString = self.createAttributedString(stringArray: ["Select the \(self.checkList ?? "") from ","\(country?.name ?? "")" +  "/" + "\( hubsViaCity.state_name ?? "")", " where you \(userType ?? "")"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue]) {
        if let attributedString = self.createAttributedString(stringArray: ["\(country?.name ?? "")" +  "/" + "\( hubsViaCity.state_name ?? "")"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]) {
            self.lblHeading.attributedText = attributedString
        }
    }
    
    @objc func didchange(_ textFeild:UITextField) {
        self.filterHubs.hubs_array?.removeAll()
        self.txtSearch.text?.count != 0  ? self.searchData() : (self.filterHubs.hubs_array = self.hubsViaCity.hubs_array ?? [] )
        self.lblNoHub.isHidden = filterHubs.hubs_array?.isEmpty == false
        //self.noHubImage.isHidden = filterHubs.hubs_array?.isEmpty == true
        self.noHubImage.isHidden = true
        self.tableView.states = filterHubs.hubs_array
        
        
    }
    
    // MARK:- Function forb Search Data
    func searchData() {
        for tutorial in self.hubsViaCity.hubs_array ?? [] {
            let title = String.getString(tutorial.name).lowercased().range(of: self.txtSearch.text!.lowercased(), options: .anchored, range: nil,   locale: nil)
            title != nil ?  self.filterHubs.hubs_array?.append(tutorial) :  print("No Data found")
            self.lblNoHub.isHidden = filterHubs.hubs_array?.isEmpty == false
            // self.noHubImage.isHidden = filterHubs.hubs_array?.isEmpty == true
            self.noHubImage.isHidden = true
            self.tableView.states = filterHubs.hubs_array
            // self.tableView.arrhubsViaCity = filterHubs
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func didSelectList(data: Any?, index: IndexPath) {
        print(data,index)
    }
    func didSelectReviewList(data: Any?, index: IndexPath, isEdithub: Bool){
        print(data,index)
    }
}
