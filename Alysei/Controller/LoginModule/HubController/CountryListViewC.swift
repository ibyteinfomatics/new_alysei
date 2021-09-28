//
//  CountryListViewC.swift
//  Alysei
//
//  Created by Gitesh Dang on 19/03/21.
//

import UIKit

class CountryListViewC: UIViewController {
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var activeCountriesCV: UICollectionView!
    @IBOutlet weak var inactiveCountriesCV: UICollectionView!
    @IBOutlet weak var lblHeading: UILabel!
   // @IBOutlet weak var viewBlur: UIView!
    
    var arrActiveUpcoming: ActiveUpcomingCountry?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewNavigation.drawBottomShadow()
        self.callCountryApi()
        // Do any additional setup after loading the view.
    }
  
}

extension CountryListViewC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == activeCountriesCV{
            return arrActiveUpcoming?.arrActiveCountries.count ?? 0
        }else{
            return arrActiveUpcoming?.arrUpcomingCountries.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == activeCountriesCV {
           guard let cell = activeCountriesCV.dequeueReusableCell(withReuseIdentifier: "ActiveCollectionViewCell", for: indexPath) as? ActiveCollectionViewCell else {return UICollectionViewCell()}
            let obj = arrActiveUpcoming?.arrActiveCountries[indexPath.row] ?? CountryModel()
            cell.configCell(obj)
            return cell
        }else{
            guard let cell = inactiveCountriesCV.dequeueReusableCell(withReuseIdentifier: "InactiveCollectionViewCell", for: indexPath) as? InactiveCollectionViewCell else {return UICollectionViewCell()}
            let obj = arrActiveUpcoming?.arrUpcomingCountries[indexPath.row] ?? CountryModel()
            cell.configCell(obj)
             return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == activeCountriesCV{
        return CGSize(width: collectionView.frame.width / 4 , height: 120)
        }else{
            return CGSize(width: collectionView.frame.width / 5 , height: 120)
        }
    }
    
}

extension CountryListViewC{
    func callCountryApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetUpcomingCountries, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result, error, errorType, statusCode) in
            let dicResult = kSharedInstance.getDictionary(result)
            guard let data = dicResult["data"] as? [String:Any] else {return}
            self.arrActiveUpcoming = ActiveUpcomingCountry.init(data: data)
            self.activeCountriesCV.reloadData()
            self.inactiveCountriesCV.reloadData()
        }
    }
}
