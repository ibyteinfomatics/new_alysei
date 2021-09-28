//
//  HubCountryListViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit

class HubCountryListViewController: AlysieBaseViewC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var roleId:String?
    var isEditHub: Bool?
    
    var hasCome:HasCome? = .initialCountry
    var countries:[CountryModel]?
    var selectedHubs = [SelectdHubs]()
    var arrActiveUpcoming: ActiveUpcomingCountry?
    // var isChckfirstEditSlcted = true
    var addOrUpdate: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postRequestToGetCountries() 
        // Do any additional setup after loading the view.
    }
    
    
}

extension HubCountryListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrActiveUpcoming?.arrActiveCountries.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryListCollectionViewCell", for: indexPath) as? CountryListCollectionViewCell else{return UICollectionViewCell()}
        cell.configCell(arrActiveUpcoming?.arrActiveCountries[indexPath.row] ?? CountryModel())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 3, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HubListViewController") as? HubListViewController else {return}
        nextVC.selectCountryId = self.arrActiveUpcoming?.arrActiveCountries[indexPath.row].id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension HubCountryListViewController {
    private func postRequestToGetCountries() -> Void{
        disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetUpcomingCountries, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            
            let dicResult = kSharedInstance.getDictionary(dictResponse)
            guard let data = dicResult["data"] as? [String:Any] else {return}
            self.arrActiveUpcoming = ActiveUpcomingCountry.init(data: data)
            //let selectedHubsC = kSharedInstance.getStringArray(self.selectedHubs.map{$0.country.id})
            // _ = self.arrActiveUpcoming?.arrActiveCountries.map{$0.isSelected = selectedHubsC.contains($0.id ?? "")}
            self.collectionView.reloadData()
            //self.activeCountryCV.countries = self.arrActiveUpcoming?.arrActiveCountries
        }
    }
}
