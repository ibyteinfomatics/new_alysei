//
//  MyStoreProductViewController.swift
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

protocol MyStoreProductDisplayLogic: class
{
  func displaySomething(viewModel: MyStoreProduct.Something.ViewModel)
    func displayProductListData(_ productArr: [MyStoreProductDetail]?)
}

class MyStoreProductViewController: AlysieBaseViewC, MyStoreProductDisplayLogic
{
    func displayProductListData(_ productArr: [MyStoreProductDetail]?) {
        print("------------------------Show Data----------------------------------------------")
        self.productList = productArr
        self.myTotalProducts.text = "(\(productArr?.count ?? 0))"
        collectionView.reloadData()
    }
    
    
  var interactor: MyStoreProductBusinessLogic?
  var router: (NSObjectProtocol & MyStoreProductRoutingLogic & MyStoreProductDataPassing)?

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
    let interactor = MyStoreProductInteractor()
    let presenter = MyStoreProductPresenter()
    let router = MyStoreProductRouter()
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
      lblMyProduct.text = MarketPlaceConstant.kMyProducts
      lblAddProduct.setTitle(MarketPlaceConstant.kAddProduct, for: .normal)
      lblAllProduct.text = MarketPlaceConstant.kAllProducts
    self.interactor?.callMyStoreProductApi()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.interactor?.callMyStoreProductApi()

    }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var myTotalProducts: UILabel!
    @IBOutlet weak var lblMyProduct:UILabel!
    @IBOutlet weak var lblAddProduct:UIButton!
    @IBOutlet weak var lblAllProduct:UILabel!
    
    var productList: [MyStoreProductDetail]?
  
  func doSomething()
  {
    let request = MyStoreProduct.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: MyStoreProduct.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    
    @IBAction func addProductAction(_ sender: UIButton){
        let controller = self.pushViewController(withName: AddProductMarketplaceVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddProductMarketplaceVC
        controller?.fromVC = .addProduct
       
    }
}

extension MyStoreProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 15
        return productList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyStoreProductCVCell", for: indexPath) as? MyStoreProductCVCell else {return UICollectionViewCell()}
        cell.configCell(productList?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
        cell.deleteButton.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.totalRating.text = "\(productList?[indexPath.row].total_reviews ?? "0") Reviews"
        cell.deleteCallBack = { deleteProductId in
            let refreshAlert = UIAlertController(title: "", message: MarketPlaceConstant.kDeleteProduct, preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                  // Handle Ok logic here
                self.interactor?.callDeleteProductApi(deleteProductId)
               // self.reloadSections(indexPath.section, with: .automatic)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
                self.dismiss(animated: true, completion: nil)
            }))
            //let parent = self.parentViewController?.presentedViewController as? HubsListVC
            self.present(refreshAlert, animated: true, completion: nil)
           
        }
        cell.editCallBack = { editProductId, tag in
            DispatchQueue.main.async {
                let controller = self.pushViewController(withName: AddProductMarketplaceVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddProductMarketplaceVC
                controller?.fromVC = .myStoreDashboard
                controller?.marketPlaceProductId = "\(editProductId)"
                controller?.passEditProductDetail = self.productList?[tag]
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 2, height: 250)
    }
}
