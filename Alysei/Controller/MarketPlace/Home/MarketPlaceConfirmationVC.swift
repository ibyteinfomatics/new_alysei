//
//  MarketPlaceConfirmationVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/4/21.
//

import UIKit

class MarketPlaceConfirmationVC: AlysieBaseViewC {
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnBackToMarketPlace: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDesc.text = MarketPlaceConstant.kThanksForsubmittingInformation
        btnBackToMarketPlace.setTitle(MarketPlaceConstant.kBackToMarketplace, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMarketAction(_ sender: UIButton){
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: MarketPlaceHomeVC.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
        let controller = pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MarketplaceHomePageVC
        controller?.isCreateStore = true
    }

}
