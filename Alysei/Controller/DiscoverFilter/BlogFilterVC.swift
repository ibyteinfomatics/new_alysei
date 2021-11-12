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
    
    var passSpecialization: String?
    var passBlogTitle: String?
    var specializationModel: SpecializationModel?
    
    var arrProductType = [String]()
    var specializationId: Int?
    var dataDropDown = DropDown()
    
    var passSelectedDataCallback: ((Int,String) -> Void)? = nil
    
    var clearFiltercCallBack: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        vwHeader.drawBottomShadow()
        vw1.addBorder()
        vw2.addBorder()
        
        getSpecialization()
        
        let specializationTap = UITapGestureRecognizer(target: self, action: #selector(openSpecializationdropDown))
        self.vw1.addGestureRecognizer(specializationTap)
        
        
        // Do any additional setup after loading the view.
    }
    func setData(){
        if self.passSpecialization == "" || self.passSpecialization == nil{
            self.lblSpecialization.text = "Specialization"
        }else{
            self.passSpecialization = self.lblSpecialization.text
        }
        
        if self.passBlogTitle == "" || self.passBlogTitle == nil{
            self.lblBlogTitle.placeholder = "Blog Titles"
        }else{
            self.passBlogTitle = self.lblBlogTitle.text
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFilterAction(_ sender: UIButton){
        setData()
        self.passSelectedDataCallback?(specializationId ?? 0,self.lblBlogTitle.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearAction(_ sender: UIButton){
        self.passSpecialization = ""
        self.passBlogTitle = ""
        clearFiltercCallBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openSpecializationdropDown(){
        dataDropDown.dataSource = arrProductType
        dataDropDown.show()
    
        dataDropDown.anchorView = vw1

        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            self.lblSpecialization.text = item
            specializationId = Int.getInt(self.specializationModel?.data?[index].id)
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
    
}
