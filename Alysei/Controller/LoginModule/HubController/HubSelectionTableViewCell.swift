//
//  HubSelectionTableViewCell.swift
//  Alysie
//
//  Created by Gitesh Dang on 03/03/21.
//

import UIKit

class HubSelectionTableViewCell: UITableViewCell {
    
    //MARK:- IBOUTLET
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewSearchHeight:NSLayoutConstraint!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblNoHub: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    
    var checkCase: CountryCityHubSelection?
    var btnClickHereCallback: ((Int) -> Void)? = nil
    var checkUserType: String?
    var country: String?
    var checkloadList: String?
    var hubData: Hubs?
    var arrLoadCities = [SignUpOptionsDataModel]()
    var arrSelectdHubId = [String]()
    var callBackSelectHubCityId:(() -> Void)? = nil
    var roleId: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //MARK: func Call
        initialSetup()
        //MARK:- REGISTER XIB
        tableView.register(UINib(nibName: "CountrySelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CountrySelectionTableViewCell")
        tableView.register(UINib(nibName: "SelectCityTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectCityTableViewCell")
        
    }
    
    //MARK: Initial Setup
  //MARK:- check role Id
    func initialSetup(){
        txtSearch.delegate = self
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
            checkUserType = "export"
        }else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "4" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "5" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "6") {
            checkUserType = "import"
        }else{
        }
        
        if let attributedString = self.createAttributedString(stringArray: ["Select the \(checkloadList ?? "") from", " \(country ?? "")" + "/" + "\(self.hubData?.state_name ?? "") ", " where you want to \(self.checkUserType ?? "")."], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue]) {
            self.lblHeading.attributedText = attributedString
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configCell(_ data: Hubs, _ country: String,_ loadCell: String?, _ checkCase: CountryCityHubSelection){
        self.hubData = data
        self.arrLoadCities = self.hubData?.city_array ?? [SignUpOptionsDataModel]()
        self.country = country
        self.checkloadList = loadCell
        self.checkCase = checkCase
       // self.latitude = self.
       
        if data.hubs_array?.count == 0 || data.city_array?.count == 0 {
            self.lblNoHub.isHidden = false
        }else{
            self.lblNoHub.isHidden = true
        }
        initialSetup()
        
    }
    
    //MARK:  - Private Methods -
    private func getSelectCountryTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let selectCountryTableCell = tableView.dequeueReusableCell(withIdentifier: CountrySelectionTableViewCell.identifier(), for: indexPath) as! CountrySelectionTableViewCell
        selectCountryTableCell.selectionStyle = .none
        selectCountryTableCell.imageFlag.layer.cornerRadius = 15
        let obj = hubData?.hubs_array?[indexPath.row]
        //        selectCountryTableCell.buttonCheckbox.isSelected = (obj?.isSelectedProduct ?? false) ? true : false
        //selectCountryTableCell.configCell(hubData?.hubs_array?[indexPath.row] ?? SignUpOptionsDataModel(withDictionary: [:]))
        return selectCountryTableCell
    }
    private func getCityTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let selectCityTableCell = tableView.dequeueReusableCell(withIdentifier: SelectCityTableViewCell.identifier(), for: indexPath) as! SelectCityTableViewCell
        selectCityTableCell.selectionStyle = .none
        selectCityTableCell.buttonRightCheckBox.isHidden = false
        selectCityTableCell.buttonLeftCheckbox.isHidden = true
        selectCityTableCell.buttonLeftCheckWidth.constant = 0
        //selectCityTableCell.configCell(arrLoadCities[indexPath.row], indexPath.row, checkCase ?? .hub)
        return selectCityTableCell
    }
    
    //MARK: IBACTION
}
//MARK:- Cell Extension

extension HubSelectionTableViewCell: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.checkCase == .hub{
            return hubData?.hubs_array?.count ?? 0
        }else{
            return arrLoadCities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.checkCase == .hub{
            return getSelectCountryTableCell(indexPath)
        }else{
            return getCityTableCell(indexPath)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if self.checkCase == .hub{
//            let obj = self.hubData?.hubs_array?[indexPath.row]
//            if obj?.isSelectedProduct == false{
//                obj?.isSelectedProduct = true
//            }else{
//                obj?.isSelectedProduct = false
//            }
//            
//        }else{
//            let obj = self.hubData?.city_array?[indexPath.row]
//            if obj?.isSelectedProduct == false{
//                obj?.isSelectedProduct = true
//            }else{
//                obj?.isSelectedProduct = false
//            }
//        }
//        tableView.reloadData()
      }
    }
//}

//MARK:- TEXTFIELD DELEGATE
extension HubSelectionTableViewCell: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            self.arrLoadCities = hubData?.city_array ?? [SignUpOptionsDataModel]()
            //            for i in 0..<arrLoadCities.count{
            //                let Indexname = arrLoadCities[i].name
            //                Indexname?.substring(to: txtAfterUpdate.count)
            //            }
            self.arrLoadCities = self.arrLoadCities.filter({ $0.name?.range(of: txtAfterUpdate, options: .caseInsensitive) != nil})
            
            //self.arrLoadCities = self.arrLoadCities.filter({ ($0.name?.hasSuffix(txtAfterUpdate) ?? false)})
            if self.arrLoadCities == [SignUpOptionsDataModel]() && txtAfterUpdate == ""{
                self.arrLoadCities = hubData?.city_array ?? [SignUpOptionsDataModel]()
            }
            self.tableView.reloadData()
        }
        
        return true
    }
    
}

//MARK: Api
//private func postRequestToGetCity(_ stateId: [String]) -> Void{
//    
//    let param: [String:Any] = ["params": stateId]
//    
//    TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetHubCity, requestMethod: .GET, requestParameters: param, withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
//        let response = kSharedInstance.getDictionary(dictResponse)
//        
//        if let data = response["data"] as? [String:Any]{
//            self.hubCitiesList = StateHubModel.init(with: data)
//        }
//        self.tableView.reloadData()
//    }
//    
//}
//MARK: EXTENSION UIVIEWCONTROLLER UITableViewCell
extension UIViewController {
    func createAttributedString(stringArray: [String], attributedPart: Int, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString? {
        let finalString = NSMutableAttributedString()
        for i in 0 ..< stringArray.count {
            var attributedString = NSMutableAttributedString(string: stringArray[i], attributes: nil)
            if i == attributedPart {
                attributedString = NSMutableAttributedString(string: attributedString.string, attributes: attributes)
                finalString.append(attributedString)
            } else {
                finalString.append(attributedString)
            }
        }
        return finalString
    }
}
extension UITableViewCell{
    func createAttributedString(stringArray: [String], attributedPart: Int, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString? {
        let finalString = NSMutableAttributedString()
        for i in 0 ..< stringArray.count {
            var attributedString = NSMutableAttributedString(string: stringArray[i], attributes: nil)
            if i == attributedPart {
                attributedString = NSMutableAttributedString(string: attributedString.string, attributes: attributes)
                finalString.append(attributedString)
            } else {
                finalString.append(attributedString)
            }
        }
        return finalString
    }
}
