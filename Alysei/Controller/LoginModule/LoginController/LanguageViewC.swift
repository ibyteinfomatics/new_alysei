//
//  LanguageViewC.swift
//  Alysie
//
//  Created by CodeAegis on 12/01/21.
//

import UIKit

class LanguageViewC: AlysieBaseViewC {

  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
      showLanguageView()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapEnglish(_ sender: UIButton) {
    
    _ = pushViewController(withName: TutorialViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
  }
  
  @IBAction func tapItalian(_ sender: UIButton) {
    
    _ = pushViewController(withName: TutorialViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
  }
   func showLanguageView() {
        let slideVC = OverLayLanguageVC()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.btnCallback =  { tag in
            switch tag {
            case 1:
                kSharedUserDefaults.setAppLanguage(language: "en")
                _ = self.pushViewController(withName: TutorialViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
            case 2:
                kSharedUserDefaults.setAppLanguage(language: "it")
                _ = self.pushViewController(withName: TutorialViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
            default:
                print("Handle")
            }
            
        }
        self.present(slideVC, animated: true, completion: nil)

       
    }
  
}
extension LanguageViewC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting, fromVC: .Language)
    }
}
