//
//  TabBarViewC.swift
//  Alysie
//
//  Created by CodeAegis on 17/01/21.
//

import UIKit
//import Instructions

class TabBarViewC: UITabBarController {

    
//    let coachMarksController = CoachMarksController()
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.coachMarksController.stop(immediately: true)
//
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        if  kSharedUserDefaults.alyseiReview == 1{
////            if isprofileComplete == false{
////                if !AppManager.getUserSeenAppInstructionPost() {
//
//                    self.coachMarksController.start(in: .viewController(self))
//                    self.tabBarController?.tabBar.backgroundColor = .gray
//                    self.tabBarController?.tabBar.alpha = 0.7
//                    tabBarController?.tabBar.isUserInteractionEnabled = false
//
////                }
////                else{
////                    tabBarController?.tabBar.backgroundColor = .white
////                    tabBarController?.tabBar.alpha = 1.0
////                    tabBarController?.tabBar.isUserInteractionEnabled = true
////
////                }
////            }
////            else{
////                self.tabBarController?.tabBar.backgroundColor = .white
////                self.tabBarController?.tabBar.alpha = 1.0
////                tabBarController?.tabBar.isUserInteractionEnabled = true
////
////            }
//        }
//        else{
//            self.tabBarController?.tabBar.backgroundColor = .white
//            self.tabBarController?.tabBar.alpha = 1.0
//            tabBarController?.tabBar.isUserInteractionEnabled = true
//
//        }
//
//    }
  override func viewDidLoad() {
    super.viewDidLoad()
//      let skipView = CoachMarkSkipDefaultView()
//      skipView.setTitle(RecipeConstants.kSkip, for: .normal)
//      self.coachMarksController.skipView = skipView
//      self.coachMarksController.dataSource = self
//      self.coachMarksController.delegate = self
      
    if  kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.voyagers.rawValue)" {
    if let viewController2 = self.tabBarController?.viewControllers?[1] {

       // viewController2.tabBarItem.image = UIImage(named: "b2btab1_icon")
        viewController2.tabBarItem.title = "Hubs"
       
       // viewController2.tabBarItem.isEnabled = false
        //viewController2.tabBarItem.selectedImage = UIImage(named: "turnoff_comments_icon")
    }else{
        if let viewController2 = self.tabBarController?.viewControllers?[1] {

            //viewController2.tabBarItem.image = UIImage(named: "b2b_normal")
            viewController2.tabBarItem.title = "B2B"
           // viewController2.tabBarItem.isEnabled = true
            //viewController2.tabBarItem.selectedImage = UIImage(named: "turnoff_comments_icon")
            
        }
    }
        
    
  }

     
}


}

//extension TabBarViewC : CoachMarksControllerDataSource, CoachMarksControllerDelegate{
//
//    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
//        return 4
//    }
//
//    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
//
//        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
//
//        switch index {
//        case 0:
//            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
//            case "3", "4", "5", "6", "7", "9":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kProdImpDistRestVoiceExprtMarketPlace
//
//            case "8", "10":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kTravelAgenciesVoygersMarketPlace
//            default: break
//
//            }
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//        case 1:
//            coachViews.bodyView.hintLabel.text = TourGuideConstants.kForAllRecipe
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//        case 2:
//            switch kSharedUserDefaults.loggedInUserModal.memberRoleId{
//            case "3", "4", "5", "6", "7", "8", "9":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kForEveryMemberB2B
//
//            case "10":
//                coachViews.bodyView.hintLabel.text = TourGuideConstants.kForVoyagersB2B
//            default: break
//
//            }
//
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//
//        case 3:
//            coachViews.bodyView.hintLabel.text = TourGuideConstants.kForAllPost
//            coachViews.bodyView.nextLabel.text = ButtonTitle.kOk
//
//
//
//        default: break
//        }
//
//        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
//    }
//
//    func coachMarksController(_ coachMarksController: CoachMarksController,
//                              coachMarkAt index: Int) -> CoachMark {
//
//        let b2bTab = tabBarController?.tabBar.items?[1].value(forKey: "view") as? UIView
//
//        let addPostTab = tabBarController?.tabBar.items?[2].value(forKey: "view") as? UIView
//        let child = self.children.last as? PostsViewController
//        switch index {
//        case 0: return coachMarksController.helper.makeCoachMark(for: child?.marketplaceView)
//        case 1: return coachMarksController.helper.makeCoachMark(for: child?.recipesView)
//        case 2:
//            return coachMarksController.helper.makeCoachMark(for: b2bTab)
//        case 3:
//            return coachMarksController.helper.makeCoachMark(for: addPostTab)
//
//        default:
//            return coachMarksController.helper.makeCoachMark()
//        }
//    }
//
//
//    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
//        AppManager.setUserSeenAppInstructionPost()
//
//        self.tabBarController?.tabBar.backgroundColor = .white
//        self.tabBarController?.tabBar.alpha = 1.0
//        self.tabBarController?.tabBar.isUserInteractionEnabled = true
//
//
//    }
//
//}
