//
//  InquiryChatVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/8/21.
//

import UIKit

class InquiryChatVC: UIViewController {
    @IBOutlet weak var vwNew: UIView!
    @IBOutlet weak var vwOpened: UIView!
    @IBOutlet weak var vwClosed: UIView!
    @IBOutlet weak var vwBottomNew: UIView!
    @IBOutlet weak var vwBottomOpened: UIView!
    @IBOutlet weak var vwBottomClosed: UIView!
    @IBOutlet weak var lblNew: UILabel!
    @IBOutlet weak var lblOpened: UILabel!
    @IBOutlet weak var lblClosed: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let newTap = UITapGestureRecognizer.init(target: self, action: #selector(openNewChatList))
        self.vwNew.addGestureRecognizer(newTap)
        
        let openTap = UITapGestureRecognizer.init(target: self, action: #selector(openOpenedList))
        self.vwOpened.addGestureRecognizer(openTap)
        
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(openClosedList))
        self.vwClosed.addGestureRecognizer(closeTap)
        // Do any additional setup after loading the view.
    }
    
    @objc func openNewChatList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
      
        vwBottomNew.layer.backgroundColor = UIColor.init(hexString: "009A9E").cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    @objc func openOpenedList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        vwBottomNew.layer.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.init(hexString: "009A9E").cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    @objc func openClosedList(){
        lblNew.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblOpened.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
        lblClosed.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        vwBottomNew.layer.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomOpened.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        vwBottomClosed.layer.backgroundColor = UIColor.init(hexString: "009A9E").cgColor
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ProductDetailVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

}
