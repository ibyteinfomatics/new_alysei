//
//  UpdateProfileDescVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/11/21.
//

import UIKit

class UpdateProfileDescVC: AlysieBaseViewC {
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var headerTitle: UILabel!

    var passUserFieldId: Int?
    var passheaderTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.addShadow()
        txtDesc.addBorder()
        headerTitle.text = passheaderTitle
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton){
        if txtDesc.text == ""{
            self.showAlert(withMessage: "Please enter some description")
        }else{
            callSaVeApi()
        }
    }

}

extension UpdateProfileDescVC{
    func callSaVeApi(){
        
        let params: [String:Any] = [
            APIConstants.userFieldId: passUserFieldId ?? 0,
            "value": String.getString(txtDesc.text),
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSaveUpdateProfileField, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { dictResponse, error, errType, statusCode in
            
            switch statusCode {
            case 200:
            self.navigationController?.popViewController(animated: true)
            default:
                print("Error")
        }
    }
}
}
