//
//  MyStoreVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/23/21.
//

import UIKit

class MyStoreVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var dashboardView: UIView!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var inquiryView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imgDashboard: UIImageView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var imgInquiries: UIImageView!
    @IBOutlet weak var viewContDashboard: UIView!
    @IBOutlet weak var viewContStore: UIView!
    @IBOutlet weak var viewContProduct: UIView!
    @IBOutlet weak var viewContInquiry: UIView!
    @IBOutlet weak var lblStoreName: UILabel!
    
    var userStoreName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        callGetFieldStoreApi()
        //stackView.addSubview
        self.loadDashboard()
        selectDashboardUI()
        let dashboardTap = UITapGestureRecognizer(target: self, action: #selector(loadDashboard))
        self.dashboardView.addGestureRecognizer(dashboardTap)
        
        let productTap = UITapGestureRecognizer(target: self, action: #selector(loadProduct))
        self.productView.addGestureRecognizer(productTap)
        
        let storeTap = UITapGestureRecognizer(target: self, action: #selector(loadStore))
        self.storeView.addGestureRecognizer(storeTap)
        
        let inquiryTap = UITapGestureRecognizer(target: self, action: #selector(loadinquiry))
        self.inquiryView.addGestureRecognizer(inquiryTap)
        
        // Do any additional setup after loading the view.
    }
    func selectDashboardUI(){
        viewContDashboard.layer.backgroundColor = UIColor.init(hexString: "#37A282").cgColor
        viewContStore.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        viewContProduct.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        viewContInquiry.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        imgProduct.image = UIImage(named: "product_inactive")
        imgDashboard.image = UIImage(named: "Dashboard_active")
        imgStore.image = UIImage(named: "store_inactive")
        imgInquiries.image = UIImage(named: "inquiries_inactive")
        
    }
    func selectProductUI(){
        viewContDashboard.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        viewContStore.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        viewContProduct.layer.backgroundColor = UIColor.init(hexString: "#37A282").cgColor
        viewContInquiry.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        imgProduct.image = UIImage(named: "product_active")
        imgDashboard.image = UIImage(named: "Dashboard_inactive")
        imgStore.image = UIImage(named: "store_inactive")
        imgInquiries.image = UIImage(named: "inquiries_inactive")
        
    }
    func selectStoreUI(){
        viewContDashboard.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        viewContStore.layer.backgroundColor = UIColor.init(hexString: "#37A282").cgColor
        viewContProduct.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        viewContInquiry.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        imgProduct.image = UIImage(named: "product_inactive")
        imgDashboard.image = UIImage(named: "Dashboard_inactive")
        imgStore.image = UIImage(named: "store_active")
        imgInquiries.image = UIImage(named: "inquiries_inactive")
        
    }
    
    func setDataUI(){
        self.lblStoreName.text = self.userStoreName
    }
    @objc func loadDashboard(){
        selectDashboardUI()
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MyStoreDashboardViewController") as! MyStoreDashboardViewController
        
        vc.view.frame = self.containerView.bounds
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    
    @objc func loadProduct(){
    selectProductUI()
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MyStoreProductViewController") as! MyStoreProductViewController
        
        vc.view.frame = self.containerView.bounds
        //vc.pushedFrom = .myStoreDashboard
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    @objc func loadStore(){
        selectStoreUI()
        print("load Store")
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceCreateStoreVC") as! MarketPlaceCreateStoreVC
        vc.fromVC = .myStoreDashboard
        vc.view.frame = self.containerView.bounds
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    @objc func loadinquiry(){
        print("load Inquiry")
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension MyStoreVC{
    func  callGetFieldStoreApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetStoreFilledValue, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.userStoreName = data["company_name"] as? String
                self.setDataUI()
            }
            
        }
    }}
