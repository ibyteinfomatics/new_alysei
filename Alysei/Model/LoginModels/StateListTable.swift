//
//  StateListTable.swift
//  Alysie
//
//


import Foundation
import UIKit
import SwiftUI


class StateListTable: UITableView {
  
    var selectDelegate:SelectList?
    var states:[CountryHubs]?{didSet{self.reloadData()}}
   var roleId: String?
    var hasCome: HasCome?
    var hubCountCallBack:(() -> Void)? = nil
   var hubcount = 0
    var hubLatitude: String?
    var hubLongitude:String?
    var hubRadius:Int?
    var arrhubsViaCity:[HubsViaCity]?
    var isRestroRentSeleted = false

   // var hubsViaCity:[HubsViaCity]?{didSet{self.reloadData()}}
   
    // MARK:- life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegate()
    }
    func setDelegate() {
        self.register(UINib(nibName: "SelectCityTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectCityTableViewCell")
        self.delegate = self
        self.dataSource = self
    }
    
}

// MARK:- cextension of main class for CollectionView

extension StateListTable : UITableViewDelegate   , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hasCome == .hubs{
        return 190
        }else{
            return 70
        }
    }
 
    
    func dequeueReusableCell(indexPath:IndexPath)->UITableViewCell {
        guard let states = self.states?[indexPath.row] else { return UITableViewCell() }
        let cell = self.dequeueReusableCell(withIdentifier: "SelectCityTableViewCell", for: indexPath) as! SelectCityTableViewCell
        cell.selectionStyle = .none
        cell.viewContainer.backgroundColor = UIColor.white
        
        cell.tag = indexPath.row
        cell.hubLatitude = self.hubLatitude
        cell.hubLongitude = self.hubLongitude
        cell.hubRadius = self.hubRadius
        cell.buttonRightCheckBox.isHidden = self.hasCome == .hubs ? false : true
        if self.hasCome == .hubs {
            cell.imgViewHght.constant = 135
        }else{
            cell.imgViewHght.constant = 0
        }
        
        if self.hasCome == .hubs {
            cell.viewContainer.layer.backgroundColor = UIColor.white.cgColor
                cell.labelCityName.textColor = UIColor.black
            cell.imgHub.isHidden = false
            cell.buttonRightCheckBox.isHidden = false
            cell.buttonRightCheckBox.isHidden =  false
            cell.buttonLeftCheckWidth.constant =  20
            cell.buttonLeftHeight.constant =  20
            
            cell.buttonLeftLeading.constant = 15
        }else{
            cell.viewContainer.layer.backgroundColor = states.isSelected == true ? UIColor.init(hexString: "#4BB3FD").cgColor : UIColor.white.cgColor
            cell.labelCityName.textColor = states.isSelected == true ? UIColor.white : UIColor.black
            cell.imgHub.isHidden = true
            cell.buttonRightCheckBox.isHidden = true
            cell.buttonRightCheckBox.isHidden = true
            cell.buttonLeftCheckWidth.constant = 25
            cell.buttonLeftHeight.constant = 25
            
            cell.buttonLeftLeading.constant = 15
//            self.buttonRightCheckBox.isHidden = hideEyeIcon == true ? true : false
//            self.buttonLeftCheckWidth.constant = hideEyeIcon == true ? 25 : 20
//            self.buttonLeftHeight.constant = hideEyeIcon == true ? 25 : 20
//
//            self.buttonLeftLeading.constant = hideEyeIcon == true ? 15 : 15
            
        }
        if self.hasCome == .hubs {
            cell.labelCityName.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        }else{
            cell.labelCityName.font = UIFont(name: "HelveticaNeue-Regular", size: 16.0)
        }
        cell.configCell(states, indexPath.row, .city)
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
     // if  roleId == "9"{
        if  kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)"{
            for i in 0..<(self.arrhubsViaCity?.count ?? 0){
                for j in 0..<(self.arrhubsViaCity?[i].hubs_array?.count ?? 0){
                _ = self.arrhubsViaCity?[i].hubs_array?[j].isSelected = false
                  //  print("False or true ---------------------\(self.arrhubsViaCity?[i].hubs_array?[j].name ?? "") is \(self.arrhubsViaCity?[i].hubs_array?[j].isSelected ?? true)")
        }
            }
            for i in 0..<(self.states?.count ?? 0){
            _ = self.states?[i].isSelected = false
        }
            self.states?[indexPath.row].isSelected = true
            hubCountCallBack?()
            self.reloadData()
        }else{
          self.states?[indexPath.row].isSelected = !(self.states?[indexPath.row].isSelected ?? true)
            //self.reloadData()
            self.reloadRows(at: [indexPath], with: .none)
        }
        hubCountCallBack?()
       // print("Call HubCout")
        
    }
}
