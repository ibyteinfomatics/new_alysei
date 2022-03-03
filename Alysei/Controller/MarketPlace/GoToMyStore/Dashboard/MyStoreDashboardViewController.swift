//
//  MyStoreDashboardViewController.swift
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
import DropDown

protocol MyStoreDashboardDisplayLogic: class
{
  func displaySomething(viewModel: MyStoreDashboard.Something.ViewModel)
    func displayDashboardData(_ imgProfile: String, _ imgCover: String, _ totalProduct: Int, _ totalCategory: Int, _ totalEnquiry: Int, _ totalReview: Int, _ productCount: Int, _ logobaseUrl: String, _ bannerbaseUrl: String)
    func categoryCount(_ CategoryCount: Int)
}

class MyStoreDashboardViewController: UIViewController, MyStoreDashboardDisplayLogic
{
    
  var interactor: MyStoreDashboardBusinessLogic?
  var router: (NSObjectProtocol & MyStoreDashboardRoutingLogic & MyStoreDashboardDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MyStoreDashboardInteractor()
    let presenter = MyStoreDashboardPresenter()
    let router = MyStoreDashboardRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    selectSort = 1
    imgStore.layer.borderWidth = 1.5
    imgStore.layer.borderColor = UIColor.white.cgColor
      lblTitleProduct.text = MarketPlaceConstant.kProduct
      lblTitleCategories.text = MarketPlaceConstant.kCategories
      
    self.interactor?.callDashBoardApi()
    self.interactor?.callCategoryApi()
  }
    
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgCoverImg: UIImageView!
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var lblTotalProduct: UILabel!
    @IBOutlet weak var lblTotalCategories: UILabel!
    @IBOutlet weak var lblTitleProduct: UILabel!
    @IBOutlet weak var lblTitleCategories: UILabel!
  
    
    var totalProduct: Int?
    var totalCategory: Int?
    var totalEnquiry: Int?
    var totalReview: Int?
    var logobaseUrl:String?
    var bannerbaseUrl: String?
   
    
  func doSomething()
  {
    let request = MyStoreDashboard.Something.Request()
    interactor?.doSomething(request: request)
    
  }
  
  func displaySomething(viewModel: MyStoreDashboard.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    func displayDashboardData(_ imgProfile: String, _ imgCover: String, _ totalProduct: Int, _ totalCategory: Int, _ totalEnquiry: Int, _ totalReview: Int, _ productCount: Int,_ logobaseUrl: String,_ bannerbaseUrl: String) {
        self.imgStore.setImage(withString: logobaseUrl + String.getString(imgProfile))
        self.imgCoverImg.setImage(withString: bannerbaseUrl + String.getString(imgCover))
        self.lblTotalProduct.text = "\(productCount)"
        self.totalProduct = totalProduct
        self.totalCategory = totalCategory
        self.totalEnquiry = totalEnquiry
        self.totalReview = totalReview
        self.logobaseUrl = logobaseUrl
        self.bannerbaseUrl = bannerbaseUrl
        self.tableView.reloadData()
        
    }
    func categoryCount(_ CategoryCount: Int) {
        self.lblTotalCategories.text = "\(CategoryCount)"
    }
   
}

//Mark: TableView DataSource , Delegate

extension MyStoreDashboardViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnalyticsTableViewCell", for: indexPath) as? AnalyticsTableViewCell else{return UITableViewCell()}
        cell.selectionStyle = .none
        cell.configeCell(self.totalProduct ?? 0, self.totalCategory ?? 0, self.totalEnquiry ?? 0, self.totalReview ?? 0 , logobaseUrl ?? "", bannerbaseUrl ?? "")
        cell.callApi = {
            self.interactor?.callDashBoardApi()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}
