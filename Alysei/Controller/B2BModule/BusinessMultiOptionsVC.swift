//
//  BusinessMultiOptionsVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/28/21.
//

import UIKit

class BusinessMultiOptionsVC: UIViewController {
    
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var vwHeader: UIView!
    
    var arrUserHubs: [HubCityArray]?
    var getRoleViewModel: GetRoleViewModel!
    var productType: ProductType?
    var stateModel: [StateModel]?
    var arrStateRegion: [SignUpOptionsDataModel]?
    var currentIndex: Int?
    var selectFieldType: String?
    var arrSelectedOption = [String]()
    var arrSelectedId = [String]()
    var doneCallBack: (([String]?, [String]?) -> Void)? = nil
    var passSelectOptionId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        if ((currentIndex == B2BSearch.Hub.rawValue || currentIndex == B2BSearch.Voyager.rawValue) && selectFieldType == AppConstants.SelectState){
            headerTitle.text = "Select State"
        }else if ((currentIndex == B2BSearch.Expert.rawValue || currentIndex == B2BSearch.TravelAgencies.rawValue) && selectFieldType == AppConstants.SelectRegion){
            headerTitle.text = "Select Region"
        }else{
        headerTitle.text = selectFieldType
        }
        
        if selectFieldType == AppConstants.Hubs{
        for i in 0..<(arrUserHubs?.count ?? 0){
            if passSelectOptionId.contains("\(self.arrUserHubs?[i].id ?? 0)"){
                self.arrUserHubs?[i].isSelected = true
            }else{
                print("check")
            }
            if self.arrUserHubs?[i].isSelected == true{
                arrSelectedOption.append(arrUserHubs?[i].title ?? "")
                arrSelectedId.append("\(arrUserHubs?[i].id ?? 0)")
                
            }
        }
        }else if selectFieldType == AppConstants.SelectUserType{
            for i in 0..<(getRoleViewModel.arrImporter.count ){
                if passSelectOptionId.contains(self.getRoleViewModel.arrImporter[i].roleId ?? ""){
                    self.getRoleViewModel.arrImporter[i].isSelected = true
                }else{
                    
                    print("check")
                }
                if self.getRoleViewModel.arrImporter[i].isSelected == true{
                   
                    arrSelectedOption.append(getRoleViewModel.arrImporter[i].name ?? "")
                    arrSelectedId.append("\(getRoleViewModel.arrImporter[i].roleId ?? "")")
                    
                }
            }
        }else if selectFieldType == AppConstants.ProductTypeBusiness || selectFieldType == AppConstants.RestaurantType || selectFieldType == AppConstants.Expertise || selectFieldType == AppConstants.Title  || selectFieldType == AppConstants.Speciality {
            for i in 0..<(self.productType?.options?.count ?? 0 ){
                    if passSelectOptionId.contains(productType?.options?[i].userFieldOptionId ?? ""){
                        self.productType?.options?[i].isSelected = true
                    }else{
                        print("check")
                    }
                if self.productType?.options?[i].isSelected == true{
                    arrSelectedOption.append(productType?.options?[i].optionName ?? "")
                    arrSelectedId.append("\(productType?.options?[i].userFieldOptionId ?? "")")
                    
                }
            }
        }
        else if (selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion)  && (currentIndex == B2BSearch.Importer.rawValue || currentIndex == B2BSearch.Producer.rawValue || currentIndex == B2BSearch.Hub.rawValue){
            for i in 0..<(self.stateModel?.count ?? 0 ){
                if passSelectOptionId.contains("\(stateModel?[i].id ?? 0)"){
                    self.stateModel?[i].isSelected = true
                }else{
                    print("check")
                }
                if self.stateModel?[i].isSelected == true{
                    arrSelectedOption.append(stateModel?[i].name ?? "")
                    arrSelectedId.append("\(stateModel?[i].id ?? 0)")
                    
                }
            }
        }
        else if (selectFieldType == AppConstants.SelectState || currentIndex == B2BSearch.Voyager.rawValue){
            for i in 0..<(self.stateModel?.count ?? 0 ){
                if passSelectOptionId.contains("\(stateModel?[i].id ?? 0)"){
                    self.stateModel?[i].isSelected = true
                }else{
                    print("check")
                }
                if self.stateModel?[i].isSelected == true{
                    arrSelectedOption.append(stateModel?[i].name ?? "")
                    arrSelectedId.append("\(stateModel?[i].id ?? 0)")
                    
                }
            }
        }else if selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion{
            for i in 0..<(self.arrStateRegion?.count ?? 0 ){
                if passSelectOptionId.contains(arrStateRegion?[i].id ?? ""){
                    self.arrStateRegion?[i].isSelected = true
                }else{
                    print("check")
                }
                if self.arrStateRegion?[i].isSelected == true{
                    arrSelectedOption.append(arrStateRegion?[i].name ?? "")
                    arrSelectedId.append("\(arrStateRegion?[i].id ?? "")")
                    
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneAction(_ sender: UIButton){
        doneCallBack?(arrSelectedOption,arrSelectedId)
        self.navigationController?.popViewController(animated: true)
       
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension BusinessMultiOptionsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectFieldType == AppConstants.Hubs{
        return arrUserHubs?.count ?? 0
        }else if selectFieldType == AppConstants.SelectUserType{
            
            return getRoleViewModel.arrImporter.count
        }else if selectFieldType == AppConstants.ProductTypeBusiness || selectFieldType == AppConstants.RestaurantType || selectFieldType == AppConstants.Expertise || selectFieldType == AppConstants.Title  || selectFieldType == AppConstants.Speciality{
            return productType?.options?.count ?? 0
        }
        else if (selectFieldType == AppConstants.SelectState ||  selectFieldType == AppConstants.SelectRegion)  && (currentIndex == B2BSearch.Importer.rawValue || currentIndex == B2BSearch.Producer.rawValue || currentIndex == B2BSearch.Hub.rawValue) || (currentIndex == B2BSearch.Voyager.rawValue) {
            

            return stateModel?.count ?? 0
        }
        else if selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion{
            return arrStateRegion?.count ?? 0
        }
        else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessMultiOptionsTableVCell", for: indexPath) as? BusinessMultiOptionsTableVCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        
        if selectFieldType == AppConstants.Hubs{
        let data = arrUserHubs?[indexPath.row]
        cell.lblOption.text = arrUserHubs?[indexPath.row].title
            cell.btnCheckBox.setImage((data?.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        }else if selectFieldType == AppConstants.SelectUserType{
            let data = getRoleViewModel?.arrImporter[indexPath.row]
            cell.lblOption.text = getRoleViewModel?.arrImporter[indexPath.row].name
            cell.btnCheckBox.setImage((data?.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        }else if selectFieldType == AppConstants.ProductTypeBusiness || selectFieldType == AppConstants.RestaurantType || selectFieldType == AppConstants.Expertise || selectFieldType == AppConstants.Title || selectFieldType == AppConstants.Speciality {
            let data = productType?.options?[indexPath.row]
            cell.lblOption.text = productType?.options?[indexPath.row].optionName
            cell.btnCheckBox.setImage((data?.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)

        }else if (selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion)  && (currentIndex == B2BSearch.Importer.rawValue || currentIndex == B2BSearch.Producer.rawValue || currentIndex == B2BSearch.Hub.rawValue || (currentIndex == B2BSearch.Voyager.rawValue)){
            let data = stateModel?[indexPath.row]
            cell.lblOption.text = data?.name
            cell.btnCheckBox.setImage((data?.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        }
        else if selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion{
            let data = arrStateRegion?[indexPath.row]
            cell.lblOption.text = data?.name
            cell.btnCheckBox.setImage((data?.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        }
        
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectFieldType == AppConstants.Hubs{
        arrUserHubs?[indexPath.row].isSelected =  !(arrUserHubs?[indexPath.row].isSelected ?? false)
        if self.arrUserHubs?[indexPath.row].isSelected == true {
            self.arrSelectedOption.append(arrUserHubs?[indexPath.row].title ?? "")
            self.arrSelectedId.append("\(arrUserHubs?[indexPath.row].id ?? 0)" )
        } else{
            if let index = arrSelectedOption.firstIndex(of: self.arrUserHubs?[indexPath.row].title ?? "") {
                self.arrSelectedOption.remove(at: index)
                self.arrSelectedId.remove(at: index)
            }
        }
        }else if selectFieldType == AppConstants.SelectUserType{
            getRoleViewModel?.arrImporter[indexPath.row].isSelected =  !(getRoleViewModel?.arrImporter[indexPath.row].isSelected ?? false)
            if self.getRoleViewModel?.arrImporter[indexPath.row].isSelected == true {
                self.arrSelectedOption.append(getRoleViewModel?.arrImporter[indexPath.row].name ?? "")
                self.arrSelectedId.append("\(getRoleViewModel?.arrImporter[indexPath.row].roleId ?? "")" )
            } else{
                if let index = arrSelectedOption.firstIndex(of: self.getRoleViewModel?.arrImporter[indexPath.row].name ?? "") {
                    self.arrSelectedOption.remove(at: index)
                    self.arrSelectedId.remove(at: index)
                }
            }
        }else if selectFieldType == AppConstants.ProductTypeBusiness || selectFieldType == AppConstants.RestaurantType || selectFieldType == AppConstants.Expertise || selectFieldType == AppConstants.Title || selectFieldType == AppConstants.Speciality {
            productType?.options?[indexPath.row].isSelected = !( productType?.options?[indexPath.row].isSelected ?? false)
            if self.productType?.options?[indexPath.row].isSelected == true {
                self.arrSelectedOption.append(productType?.options?[indexPath.row].optionName ?? "")
                self.arrSelectedId.append("\(productType?.options?[indexPath.row].userFieldOptionId ?? "")" )
            } else{
                if let index = arrSelectedOption.firstIndex(of: self.productType?.options?[indexPath.row].optionName ?? "") {
                    self.arrSelectedOption.remove(at: index)
                    self.arrSelectedId.remove(at: index)
                }
            }
            }else if (selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion) && (currentIndex == B2BSearch.Importer.rawValue || currentIndex == B2BSearch.Producer.rawValue || currentIndex == B2BSearch.Hub.rawValue || (currentIndex == B2BSearch.Voyager.rawValue)){
                stateModel?[indexPath.row].isSelected = !( stateModel?[indexPath.row].isSelected ?? false)
                if self.stateModel?[indexPath.row].isSelected == true {
                    self.arrSelectedOption.append(stateModel?[indexPath.row].name ?? "")
                    self.arrSelectedId.append("\(stateModel?[indexPath.row].id ?? 0)" )
                } else{
                    if let index = arrSelectedOption.firstIndex(of: self.stateModel?[indexPath.row].name ?? "") {
                        self.arrSelectedOption.remove(at: index)
                        self.arrSelectedId.remove(at: index)
                    }
            }
            }
        else if selectFieldType == AppConstants.SelectState || selectFieldType == AppConstants.SelectRegion{
            arrStateRegion?[indexPath.row].isSelected = !( arrStateRegion?[indexPath.row].isSelected ?? false)
                if self.arrStateRegion?[indexPath.row].isSelected == true {
                    self.arrSelectedOption.append(arrStateRegion?[indexPath.row].name ?? "")
                    self.arrSelectedId.append("\(arrStateRegion?[indexPath.row].id ?? "0")" )
                } else{
                    if let index = arrSelectedOption.firstIndex(of: self.arrStateRegion?[indexPath.row].name ?? "") {
                        self.arrSelectedOption.remove(at: index)
                        self.arrSelectedId.remove(at: index)
                    }
                
            }
            }
            
        
        print("SelectedHubs--------------------------------------------------\(arrSelectedOption )")
        print("arrSelectedId--------------------------------------------------\(arrSelectedId )")
        self.optionTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

class BusinessMultiOptionsTableVCell: UITableViewCell{
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
