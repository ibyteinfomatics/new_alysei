//
//  EditPostPresenter.swift
//  Alysei
//
//  Created by Gitesh Dang on 29/09/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EditPostPresentationLogic
{
  //func presentSomething(response: EditPost.Something.Response)
    func postEdit()
}

class EditPostPresenter: EditPostPresentationLogic
{
  weak var viewController: EditPostDisplayLogic?
  
  // MARK: Do something
  
//  func presentSomething(response: EditPost.Something.Response)
//  {
//    let viewModel = EditPost.Something.ViewModel()
//    viewController?.displaySomething(viewModel: viewModel)
//  }
    func postEdit() {
        self.viewController?.dismissSelf()
    }
}
