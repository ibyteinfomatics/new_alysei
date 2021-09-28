//
//  MarketPlaceConfirmationVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/4/21.
//

import UIKit

class MarketPlaceConfirmationVC: AlysieBaseViewC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMarketAction(_ sender: UIButton){
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: MarketPlaceHomeVC.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
        let controller = pushViewController(withName: MarketPlaceHomeVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MarketPlaceHomeVC
        controller?.isCreateStore = true
    }

}
