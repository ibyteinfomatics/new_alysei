//
//  ConnectionConfirmVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/16/21.
//

import UIKit

class ConnectionConfirmVC: AlysieBaseViewC {

    @IBOutlet weak var lblRequest: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    var userID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnClose.setTitle(MarketPlaceConstant.kClosed, for: .normal)
        lblRequest.text = AppConstants.kRequestSentSuccessfully
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnClose(_ sender: UIButton){
            
            
        }

}
