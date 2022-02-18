//
//  WebKitViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 2/17/22.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {

    @IBOutlet weak var vwWebKit: WKWebView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwHeader: UIView!
   
    var strngTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        lblTitle.text = strngTitle
        if  strngTitle == "Privacy Policy"{
            loadPrivacyUrl()
        }else{
            loadTermsUrl()
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func loadPrivacyUrl(){
        guard let url = URL(string: "https://alyseiapi.ibyteworkshop.com/public/privacy-policy") else { return }
       
        vwWebKit.load(URLRequest(url: url))
    }
    func loadTermsUrl(){
    guard let url = URL(string: "https://alyseiapi.ibyteworkshop.com/public/terms") else {
      return //be safe
    }

    vwWebKit.load(URLRequest(url: url))
    
}
}
