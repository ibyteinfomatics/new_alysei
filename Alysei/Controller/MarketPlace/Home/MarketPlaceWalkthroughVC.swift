//
//  MarketPlaceWalkthroughVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/31/21.
//

import UIKit

class MarketPlaceWalkthroughVC: AlysieBaseViewC {
    
    @IBOutlet weak var imageCentre: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btn1Animation()
        btn2Animation()
        btn3Animation()
                // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTopAction(_ sender: UIButton){
        showMarketplaceDescView("0")
       // btnAnimation()
    }

    @IBAction func btnSideAction(_ sender: UIButton){
        
        showMarketplaceDescView("1")
        
    }
    
    @IBAction func btnBottomAction(_ sender: UIButton){
        showMarketplaceDescView("2")
    }
   func btn1Animation() {

        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            //Frame Option 1:
            self.btn1.frame = CGRect(x: self.btn1.frame.origin.x, y: 20, width: self.btn1.frame.width, height: self.btn1.frame.height)

            //Frame Option 2:
            //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)

            },completion: { finish in

                UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations: {

           // self.btn1.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                    self.btn1.frame = CGRect(x: self.btn1.frame.origin.x, y: 95, width: self.btn1.frame.width, height: self.btn1.frame.height)

          //  self.btn1.isEnabled = false // If you want to restrict the button not to repeat animation..You can enable by setting into true

            },completion: nil)})

    }
    
    func btn2Animation() {

         UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
             //Frame Option 1:
            self.btn2.frame = CGRect(x: self.btn2.frame.origin.x, y: 20, width: self.btn2.frame.width, height: self.btn2.frame.height)

             //Frame Option 2:
            // self.btn2.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)

             },completion: { finish in

                 UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations: {

            // self.btn1.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                    self.btn2.frame = CGRect(x: self.btn2.frame.origin.x, y: self.btn2.frame.origin.y, width: self.btn2.frame.width, height: self.btn2.frame.height)

           //  self.btn1.isEnabled = false // If you want to restrict the button not to repeat animation..You can enable by setting into true

             },completion: nil)})

     }
    func btn3Animation() {

         UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
             //Frame Option 1:
            // self.btn3.frame = CGRect(x: self.btn3.frame.origin.x, y: 20, width: self.btn3.frame.width, height: self.btn3.frame.height)
            self.btn3.frame = CGRect(x: self.view.frame.minX, y: self.view.frame.midY, width: self.btn3.frame.width, height: self.btn3.frame.height)

             //Frame Option 2:
            // self.btn3.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)

             },completion: { finish in

                 UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations: {

            // self.btn1.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                    self.btn3.frame = CGRect(x: self.btn3.frame.origin.x, y: self.btn3.frame.origin.y, width: self.btn3.frame.width, height: self.btn3.frame.height)

           //  self.btn1.isEnabled = false // If you want to restrict the button not to repeat animation..You can enable by setting into true

             },completion: nil)})

     }
    func showMarketplaceDescView(_ tab: String){
        let controller = pushViewController(withName: MarketPlaceWalkThroughDescVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MarketPlaceWalkThroughDescVC
        controller?.identifyTab = tab
    }
    
    @IBAction func btnGetStartedAction(_ sender: UIButton){
        _ = pushViewController(withName: SelectMemberShipVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
    }
}
