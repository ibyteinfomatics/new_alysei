//
//  MarketPlaceWalkthroughVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/31/21.
//

import UIKit

class MarketPlaceWalkthroughVC: AlysieBaseViewC {
    
    @IBOutlet weak var imageCentre: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTopAction(_ sender: UIButton){
        showMarketplaceDescView("0")
    }

    @IBAction func btnSideAction(_ sender: UIButton){
        
        showMarketplaceDescView("1")
        
    }
    
    @IBAction func btnBottomAction(_ sender: UIButton){
        showMarketplaceDescView("2")
    }
    
    func showMarketplaceDescView(_ tab: String){
        let controller = pushViewController(withName: MarketPlaceWalkThroughDescVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MarketPlaceWalkThroughDescVC
        controller?.identifyTab = tab
    }
    
    @IBAction func btnGetStartedAction(_ sender: UIButton){
        _ = pushViewController(withName: SelectMemberShipVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
    }
}
