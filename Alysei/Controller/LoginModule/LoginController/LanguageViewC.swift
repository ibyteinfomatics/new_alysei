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
    
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapEnglish(_ sender: UIButton) {
    
    _ = pushViewController(withName: TutorialViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
  }
  
  @IBAction func tapItalian(_ sender: UIButton) {
    
    _ = pushViewController(withName: TutorialViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
  }
  
}
