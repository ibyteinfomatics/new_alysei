//
//  BlogFilterVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/9/21.
//

import UIKit
import DropDown

class BlogFilterVC: AlysieBaseViewC {
    @IBOutlet weak var vwHeader: UIView!
    
    @IBOutlet weak var lblSpecialization:UILabel!
    @IBOutlet weak var lblBlogTitle: UITextField!
    
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClearFilter: UIButton!
    @IBOutlet weak var btnApplyFilter: UIButton!
    var productType: ProductType?
    var arrProductType = [String]()
    var arrProductType1 = [String]()
    var passSpecialization: String?
    var passBlogTitle: String?
    var specializationModel: SpecializationModel?
    
   
    var specializationId: String?
    var TitleId: String?
    var dataDropDown = DropDown()
    
    var passSelectedDataCallback: ((String,String) -> Void)? = nil
    
    var clearFiltercCallBack: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        lblTitle.text = MarketPlaceConstant.kFilter
        btnClearFilter.setTitle(MarketPlaceConstant.kClearFilters, for: .normal)
        btnApplyFilter.setTitle(MarketPlaceConstant.kApplyFilters, for: .normal)
        vwHeader.drawBottomShadow()
        vw1.addBorder()
        vw2.addBorder()
        
        getSpecialization()
        callTitleApi()
        let specializationTap = UITapGestureRecognizer(target: self, action: #selector(openSpecializationdropDown))
        self.vw1.addGestureRecognizer(specializationTap)
        
        let blogTitleTap = UITapGestureRecognizer(target: self, action: #selector(openblogTitledropDown))
        self.vw2.addGestureRecognizer(blogTitleTap)
        
        
        // Do any additional setup after loading the view.
    }
    func setData(){
        if self.passSpecialization == "" || self.passSpecialization == nil{
            self.lblSpecialization.text = AppConstants.kSpecialization
        }else{
            self.passSpecialization = self.lblSpecialization.text
        }
        
        if self.passBlogTitle == "" || self.passBlogTitle == nil{
            self.lblBlogTitle.placeholder = AppConstants.kBlogTitles
        }else{
            self.passBlogTitle = self.lblBlogTitle.text
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFilterAction(_ sender: UIButton){
        setData()
        self.passSelectedDataCallback?(specializationId ?? "",TitleId ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearAction(_ sender: UIButton){
        self.passSpecialization = ""
        self.passBlogTitle = ""
        clearFiltercCallBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openblogTitledropDown(){
        
         dataDropDown.dataSource = arrProductType1
         dataDropDown.show()
     
         dataDropDown.anchorView = vw2

         dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
         dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
         
             self.lblBlogTitle.text = item
             TitleId = self.productType?.options?[index].userFieldOptionId     
         }
         dataDropDown.cellHeight = 40
         dataDropDown.backgroundColor = UIColor.white
         dataDropDown.selectionBackgroundColor = UIColor.clear
         dataDropDown.direction = .bottom
    }
    
    @objc func openSpecializationdropDown(){
       
        dataDropDown.dataSource = arrProductType
        dataDropDown.show()
    
        dataDropDown.anchorView = vw1

        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            self.lblSpecialization.text = item
            specializationId = "\(self.specializationModel?.data?[index].id)"
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    
    private func getSpecialization() -> Void{
      
      disableWindowInteraction()
    
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kGetSpecialization, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let response = dictResponse as? [String:Any]
          
            self.specializationModel = SpecializationModel.init(with: response)
            for product in 0..<(self.specializationModel?.data?.count ?? 0) {
                self.arrProductType.append(self.specializationModel?.data?[product].title ?? "")
            }
        
      }
      
    }
    
    func callTitleApi(){
    TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFieldValue + "12", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, errorType, statusCode in
      
        let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.productType = ProductType.init(with: data)
                print("Count ------------------------------\(self.productType?.options?.count ?? 0)")
                for product in 0..<(self.productType?.options?.count ?? 0) {
                    self.arrProductType1.append(self.productType?.options?[product].optionName ?? "")
                }
            }
        }
    }
    
}
