//
//  StateWiseHubListVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/16/21.
//

import UIKit

class StateWiseHubListVC: AlysieBaseViewC,SelectList {
    @IBOutlet weak var collectionView: StateWiseHubCollectionView!
    
    var currentIndex: Int = 0
    var hasCome:HasCome? = .initialCountry
    var countries:[CountryModel]?
    var selectedHubs = [SelectdHubs]()
    var roleId: String?
    var isEditHub : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.hascome = .showCountry
        self.collectionView.selectDelegate = self
        // Do any additional setup after loading the view.
    }
    func didSelectList(data: Any?, index: IndexPath) {
        guard let data = data as? CountryModel else {return}
        if self.hasCome == .showCountry && self.selectedHubs.first?.country.id != data.id {
            self.selectedHubs.removeAll()
        }
        let commmingHub = SelectdHubs.createHub(country: data)
        if checkDataIsFillOrNot(commmingHub: commmingHub) { return }
        let firstIndex = self.selectedHubs.first{$0.country.id == commmingHub.country.id}
        if firstIndex == nil {
            self.selectedHubs.append(SelectdHubs.createHub(country: data))
        }
        let nextVC = StateListVC()
        nextVC.country = data
        nextVC.selectedHubs = self.selectedHubs
        nextVC.isEditHub = self.isEditHub
        nextVC.roleId = kSharedUserDefaults.loggedInUserModal.memberRoleId
        enableWindowInteraction()
        self.navigationController?.pushViewController(nextVC, animated: true)
        print(data)
    }
    func checkDataIsFillOrNot(commmingHub:SelectdHubs)->Bool {
        return  self.selectedHubs.first{$0.country.id == commmingHub.country.id} != nil && self.selectedHubs.first{$0.state.count != 0} != nil
    }

    func didSelectReviewList(data: Any?, index: IndexPath, isEdithub: Bool) {
        print(data,index)
    }
}


