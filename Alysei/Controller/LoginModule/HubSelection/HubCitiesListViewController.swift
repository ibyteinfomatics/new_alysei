//
//  HubCitiesListViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class HubCitiesListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    
    var currentIndex: Int = 0
    
    var city = [CountryHubs]()
    var country: CountryModel?
    var selectedHubs = [SelectdHubs]()
    var hubsViaCity:[HubsViaCity]?
    var hasCome:HasCome? = .hubs
    var roleId: String?
    var isEditHub: Bool?
    
    var cityList:[CountryHubs]?
    var searchList:[CountryHubs]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        let state = selectedHub?.state.first
        self.postRequestToGetCity(state?.id ?? "")
        self.txtSearch.addTarget(self, action: #selector(self.searchText(_:)), for: .allEvents)
    }
    
    
    @objc func searchText(_ text:UITextField) {
        if text.text?.isEmpty ?? false {
            self.searchList = self.cityList
            self.tableView.reloadData()
            return
        }
        self.searchList = self.cityList?.filter{($0.name?.contains(ignoreCase: text.text) ?? false)}
        self.tableView.reloadData()
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextAction(_ sender: UIButton){
        let nextvc = ConfirmSelectionVC()
        nextvc.selectedHubs = self.selectedHubs
        nextvc.updatedHubs = { hubs in
            self.selectedHubs = hubs
            for hub in self.cityList ?? [] {
                for selectedHubs in hubs {
                    hub.isSelected = selectedHubs.hubs.first{$0.id == hub.id } != nil
                }
            }
            self.searchList = self.cityList
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
        nextvc.roleId = kSharedUserDefaults.loggedInUserModal.memberRoleId
        nextvc.isEditHub = false
        nextvc.isEditHubServerApi = self.isEditHub ?? false
        nextvc.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
    
}


extension HubCitiesListViewController:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        return selectedHub?.state.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HubSelectStatesCollectionViewCell", for: indexPath) as? HubSelectStatesCollectionViewCell else {return UICollectionViewCell()}
        
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        let state = selectedHub?.state[indexPath.row]
        cell.lblStateName.text = state?.name
        cell.configureData(indexPath: indexPath, currentIndex: self.currentIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 4, height: 45)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        let state = selectedHub?.state[indexPath.row]
        self.postRequestToGetCity(state?.id ?? "")
        self.collectionView.reloadData()
    }
    
    private func postRequestToGetCity(_ stateID: String) -> Void{
        let url = APIUrl.kGetCitiesByStateId + stateID
        TANetworkManager.sharedInstance.requestApi(withServiceName: url, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard let data = response["data"] as? [[String:Any]] else {return}
            self.cityList = data.map{CountryHubs(data: $0)}
            for hub in self.cityList ?? [] {
                for selectedHubs in self.selectedHubs {
                    hub.isSelected = selectedHubs.hubs.first{$0.id == hub.id && $0.name == hub.name } != nil
                }
            }
            self.searchList = self.cityList
            self.tableView.reloadData()
        }
    }
}

extension HubCitiesListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = searchList?[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HubCitiesListTableViewCell", for: indexPath) as? HubCitiesListTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.selectedHubs = { hub in self.updateSelectedHubsData(unselectedHub: hub) }
        cell.city = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func updateSelectedHubsData(unselectedHub:CountryHubs?) {
        if  kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)"{
           _ = self.cityList?.map{$0.isSelected = false}
        }
        unselectedHub?.isSelected = !(unselectedHub?.isSelected ?? false)
        let selectedCity = self.cityList?.filter{$0.isSelected}
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        selectedHub?.hubs = selectedHub?.hubs.filter{$0.id != unselectedHub?.id} ?? []
        selectedHub?.hubs = ((selectedHub?.hubs ?? []) + (selectedCity ?? [])).uniqueArray(map: {$0.id})
        self.tableView.reloadData()
    }
}
