           //
//  MyStoreDashboardPresenter.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyStoreDashboardPresentationLogic
{
  func presentSomething(response: MyStoreDashboard.Something.Response)
    func passDashboardData(_ imgProfile: String, _ imgCover: String, _ totalProduct: Int, _ totalCategory: Int, _ totalEnquiry: Int, _ totalReview: Int, _ productcount: Int)
    func getCategoryValue(_ categoryValue: Int)
}

class MyStoreDashboardPresenter: MyStoreDashboardPresentationLogic
{
    
  weak var viewController: MyStoreDashboardDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MyStoreDashboard.Something.Response)
  {
    let viewModel = MyStoreDashboard.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func passDashboardData(_ imgProfile: String, _ imgCover: String, _ totalProdcut: Int, _ totalCategory: Int, _ totalEnquiry: Int, _ totalReview: Int,  _ productcount: Int){
        self.viewController?.displayDashboardData(imgProfile,imgCover,totalProdcut,totalCategory , totalEnquiry , totalReview, productcount)
    }
    
    func getCategoryValue(_ categoryCount : Int){
        self.viewController?.categoryCount(categoryCount)
    }
}
