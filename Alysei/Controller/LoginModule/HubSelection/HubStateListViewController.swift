//
//  HubStateListViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class HubStateListViewController: AlysieBaseViewC {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblExprtImprt: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchfield: UITextField!
    var arrLoadCities = [SignUpOptionsDataModel]()
    var hubData: Hubs?
    var selectCountryId: String?
    var selectedHubs = [SelectdHubs]()
    var country:CountryModel?
    var states:[CountryHubs]?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.headerView.drawShadow()
        self.postRequestToGetState(self.selectCountryId ?? "0")

    }
   
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HubCitiesListViewController") as? HubCitiesListViewController else {return}
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension HubStateListViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.states?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HubStateListTableViewCell", for: indexPath) as? HubStateListTableViewCell else {return UITableViewCell()}
        cell.configCell(states?[indexPath.row] ?? CountryHubs(data: [:]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension HubStateListViewController: UITextFieldDelegate{
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
            
            //MARK: Uncomment
            if self.arrLoadCities == [SignUpOptionsDataModel]() && txtAfterUpdate == ""{
                self.arrLoadCities = hubData?.city_array ?? [SignUpOptionsDataModel]()
          }
            
        }
            self.tableView.reloadData()
        return true
    }
}
extension HubStateListViewController{
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
            self.tableView.reloadData()
           // self.tableVIew.states = self.states
        }
    }
}
