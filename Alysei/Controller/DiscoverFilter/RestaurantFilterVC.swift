//
//  RestaurantFilterVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/9/21.
//

import UIKit
import DropDown

class RestaurantFilterVC: AlysieBaseViewC {
    
    @IBOutlet weak var vwHeader: UIView!
    
    @IBOutlet weak var lblhubs:UILabel!
    @IBOutlet weak var lblreatau: UILabel!
    
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClearFilter: UIButton!
    @IBOutlet weak var btnApplyFilter: UIButton!
    
    var passHubs: String?
    var passRestType:String?
    
    var restaurantModel: SpecializationModel?
    var hubModel: SpecializationModel?
    
    var arrRestauType = [String]()
    var restauId: Int?
    var arrHubType = [String]()
    var hubId: Int?
    var dataDropDown = DropDown()
    
    var passSelectedDataCallback: ((Int,Int) -> Void)? = nil
    
    var clearFiltercCallBack: (() -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = MarketPlaceConstant.kFilter
        btnClearFilter.setTitle(MarketPlaceConstant.kClearFilters, for: .normal)
        btnApplyFilter.setTitle(MarketPlaceConstant.kApplyFilters, for: .normal)
        vwHeader.drawBottomShadow()
        vw1.addBorder()
        vw2.addBorder()
        setData()
        getRestaurant()
        getHub()
        
        let hubTap = UITapGestureRecognizer(target: self, action: #selector(openHubdropDown))
        self.vw1.addGestureRecognizer(hubTap)
        
        let restauTap = UITapGestureRecognizer(target: self, action: #selector(openRestaurantdropDown))
        self.vw2.addGestureRecognizer(restauTap)
        // Do any additional setup after loading the view.
    }
    
    func setData(){
        if self.passHubs == "" || self.passHubs == nil{
            self.lblhubs.text = AppConstants.Hubs
        }else{
            self.passHubs = self.lblhubs.text
        }
        
        if self.passRestType == "" || self.passRestType == nil{
            self.lblreatau.text = AppConstants.kRestaurantType
        }else{
            self.passRestType = self.lblreatau.text
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFilterAction(_ sender: UIButton){
        setData()
        self.passSelectedDataCallback?(hubId ?? 0,restauId ?? 0)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearAction(_ sender: UIButton){
        self.passHubs = ""
        self.passRestType = ""
        clearFiltercCallBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func openHubdropDown(){
        dataDropDown.dataSource = arrHubType
        dataDropDown.show()
    
        dataDropDown.anchorView = vw1

        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            self.lblhubs.text = item
            hubId = Int.getInt(self.hubModel?.hubdata?[index].id)
            
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    @objc func openRestaurantdropDown(){
        dataDropDown.dataSource = arrRestauType
        dataDropDown.show()
    
        dataDropDown.anchorView = vw2

        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            self.lblreatau.text = item
            restauId = Int.getInt(self.restaurantModel?.data?[index].id)
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    private func getRestaurant() -> Void{
      
      disableWindowInteraction()
    
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kRestaurantTypes, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let response = dictResponse as? [String:Any]
          
            self.restaurantModel = SpecializationModel.init(with: response)
            for product in 0..<(self.restaurantModel?.data?.count ?? 0) {
                self.arrRestauType.append(self.restaurantModel?.data?[product].title ?? "")
            }
        
      }
      
    }
    
    private func getHub() -> Void{
      
      disableWindowInteraction()
    
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kAllHubs, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let response = dictResponse as? [String:Any]
          
            self.hubModel = SpecializationModel.init(with: response)
            for product in 0..<(self.hubModel?.hubdata?.count ?? 0) {
                self.arrHubType.append(self.hubModel?.hubdata?[product].title ?? "")
            }
        
      }
      
    }


}
