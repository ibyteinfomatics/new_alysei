//
//  ConnectionProductTypeViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/14/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ConnectionProductTypeDisplayLogic: class
{
  func displaySomething(viewModel: ConnectionProductType.Something.ViewModel)
    func  displayProductData(_ productData: [SignUpOptionsDataModel]?)
}

class ConnectionProductTypeViewController: UIViewController, ConnectionProductTypeDisplayLogic
{
    
    
  var interactor: ConnectionProductTypeBusinessLogic?
  var router: (NSObjectProtocol & ConnectionProductTypeRoutingLogic & ConnectionProductTypeDataPassing)?
    
   
    //var userModel: BasicConnectFlow.userDataModel!
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
    let interactor = ConnectionProductTypeInteractor()
    let presenter = ConnectionProductTypePresenter()
    let router = ConnectionProductTypeRouter()
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
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var vwProduct : UIView!
    @IBOutlet weak var lblSelectedProduct: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
   
    
    var userName: String?
    var productData: Data?
    var selectedProductId = [String]()
    var userID: Int?
  
  func doSomething()
  {
    let request = ConnectionProductType.Something.Request()
    interactor?.doSomething(request: request)
    lblSelectedProduct.text = "Select product type"
    lblSelectedProduct.textColor = UIColor.lightGray
   print("UserName---------------------\(self.userName!)")
    
    
    let messageAttributedString = NSMutableAttributedString()
    messageAttributedString.append(NSAttributedString(string: "Sending a request to connect with \n", attributes: [NSAttributedString.Key.font: AppFonts.regular(16.0).font]))
    messageAttributedString.append(NSAttributedString(string: "@\(self.userName!)", attributes: [NSAttributedString.Key.font: AppFonts.bold(16.0).font]))
    
    lblUserName.attributedText = messageAttributedString
    vwProduct.layer.borderWidth = 0.5
    vwProduct.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  func displaySomething(viewModel: ConnectionProductType.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    
    func displayProductData(_ productData: [SignUpOptionsDataModel]?) {
        print("Show Data")
       // self.productData = productData
       // router?.routeToProductScreen()uc
        let controller = pushViewController(withName: UserProductListViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? UserProductListViewController
        controller?.productData = productData
        controller?.selectedProductId = self.selectedProductId
        controller?.selectProductCallback = { selectedProductId, selectedProductName in
            self.selectedProductId = selectedProductId
            self.lblSelectedProduct.textColor = UIColor.black
            let productsName = selectedProductName.joined(separator: ",")
            self.lblSelectedProduct.text = "\(productsName)"
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        if self.selectedProductId.count == 0{
            self.showAlert(withMessage: "Please select any product")
        }else{
        let controller = pushViewController(withName: CompanyViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? CompanyViewC
            controller?.selectedProductId = self.selectedProductId
            controller?.fromVC = .connectionRequest
            controller?.userID = self.userID
            controller?.userName = self.userName
        }
    }
    
    @IBAction func viewProductTapped(_ sender: UIButton) {
        
        self.interactor?.showConnectionProduct()
       
        
    }
   
    public func pushViewController(withName name: String, fromStoryboard storyboard: String) -> UIViewController {

        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)

        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }
}
