//
//  UINavigationControllerExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 26/10/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

//MARK:- ----------Enums----------

enum LeftBarItemType
{
  case back
  case menu
  case down
  case text
  case custom
  case none
}

enum RightBarItemType
{
  case text
  case textAndIcon
  case oneIcon
  case twoIcon
  case threeIcon
  case none
}

enum NavigationBarButton
{
  case backButton
  case menuButton
  case leftDownButton
  case leftTextButton
  case customButton
  case rightTextButton
  case rightFirstButton
  case rightSecondButton
  case rightThirdButton
  case notificationButton
}

//MARK:- ----------Delegate----------
protocol UINavigationControllerExtendedDelegate: UINavigationControllerDelegate
{
  func navigationBarButtonItemTapped(_ navigationBarButtonTapped: NavigationBarButton)
}

private var navigationButton: UINavigationControllerExtendedDelegate?

extension UINavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate
{
  var customDelegate: UINavigationControllerExtendedDelegate? {
    get
    {
      return objc_getAssociatedObject(self, &navigationButton) as? UINavigationControllerExtendedDelegate
    }
    set (newValue)
    {
      objc_setAssociatedObject(self, &navigationButton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  //MARK:- ----------View Life Cycle Methods--------
  override open func viewDidLoad()
  {
    super.viewDidLoad()
    self.delegate = self
    setupNavigationBarView()
  }
  
  //MARK:- ----------Public Methods--------
    
  func setupNavigationBar(withNavigationItem navItem: UINavigationItem, navigationTitle title: String, leftBarButtonType leftBarItemType: LeftBarItemType, rightBarButtonType rightBarItemType: RightBarItemType, rightBarButtonTitle rightBarItemTitle: String?, andRightBarButtonImages arrRightBarItemImages: [String]?)
  {
    self.interactivePopGestureRecognizer?.isEnabled = true
    //navItem.hidesBackButton = true
    navItem.title = title
    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
    //navigationBar.setBackgroundImage(UIImage(), for: .default)
    //navigationBar.shadowImage = UIImage()

    let negativeSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    negativeSpace.width = -16.0
        
    var leftBarItems = [UIBarButtonItem]()
    switch leftBarItemType
    {
    case .back:
      leftBarItems.append(getBarButton(withImage: "back", andSelector: #selector(tapMenuButton(sender:))))
    case .menu:
      leftBarItems.append(getBarButton(withImage: "sidebar", andSelector: #selector(tapMenuButton(sender:))))
    case .down:
      break
    case .text:
      let leftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapLeftBarButtonWithText(sender:)))
      leftBarButton.tintColor = .black
      leftBarItems.append(leftBarButton)
    case .custom:
      leftBarItems.append(getBarButton(withImage: "back-icon", andSelector: #selector(tapCustomBackButton(sender:))))
    case .none:
      break
    }
    leftBarItems.insert(negativeSpace, at: 0)
    navItem.leftBarButtonItems = leftBarItems
    
    var rightBarItems = [UIBarButtonItem]()
    switch rightBarItemType
    {
    case .text:
      let rightBarButton = UIBarButtonItem(title: rightBarItemTitle, style: .done, target: self, action: #selector(tapRightBarButtonWithText(sender:)))
      rightBarButton.tintColor = .white
      rightBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)], for: .normal)
      rightBarItems.append(rightBarButton)
    case .textAndIcon:
      break
    case .oneIcon:
      rightBarItems.append(getBarButton(withImage: String.getString(kSharedInstance.getArray(arrRightBarItemImages).first), andSelector: #selector(tapFirstRightBarButton(sender:))))
    case .twoIcon:
      rightBarItems.append(getBarButton(withImage: String.getString(kSharedInstance.getArray(arrRightBarItemImages).first), andSelector: #selector(tapFirstRightBarButton(sender:))))
      rightBarItems.append(getSecondBarButton(withImage: String.getString(kSharedInstance.getArray(arrRightBarItemImages)[1]), andSelector: #selector(tapSecondRightBarButton(sender:))))
    case .threeIcon:
      rightBarItems.append(getBarButton(withImage: String.getString(kSharedInstance.getArray(arrRightBarItemImages).first), andSelector: #selector(tapFirstRightBarButton(sender:))))
      rightBarItems.append(getSecondBarButton(withImage: String.getString(kSharedInstance.getArray(arrRightBarItemImages)[1]), andSelector: #selector(tapSecondRightBarButton(sender:))))
       rightBarItems.append(getThirdBarButton(withImage: String.getString(kSharedInstance.getArray(arrRightBarItemImages)[2]), andSelector: #selector(tapSecondRightBarButton(sender:))))
    case .none:
      rightBarItems = []
      break
    }
    if rightBarItemType != .text && rightBarItems.count > 0
    {
      rightBarItems.insert(negativeSpace, at: 0)
    }
    navItem.rightBarButtonItems = rightBarItems
    
    if title == ""
    {
      if let _ = navItem.titleView?.viewWithTag(1919)
      {
        return
      }
      else
      {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.tag = 1919
        imageView.image = #imageLiteral(resourceName: "logo-middle")
        imageView.contentMode = .center
        view.addSubview(imageView)
        navItem.titleView = imageView
      }
    }
  }
  
  func setupNavigationBarView()
  {
    navigationBar.isTranslucent = false
    navigationBar.barTintColor = .white
    //let view = UIView(frame: CGRect(x: 0, y: -20, width: kScreenWidth, height: 20))
    //view.backgroundColor = kBlackColor
    //navigationBar.addSubview(view)
  }
    
    
//    func setupNavigationBarView()
//    {
//        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = APP_THEME_UP
//        let view = UIView(frame: CGRect(x: 0, y: -20, width: kScreenWidth, height: 20))
//        view.backgroundColor = APP_THEME_UP
//        navigationBar.addSubview(view)
//    }
  
//  func setStatusBar(withHiddenStatus isHidden: Bool, andNavigationBarWithHiddenStatus isNavigationBarHidden: Bool)
//  {
//    UIApplication.shared.statusBarStyle = .default
//    UIApplication.shared.isStatusBarHidden = isHidden
//    setNavigationBarHiddenStatus(isHidden: isNavigationBarHidden)
//  }
  
  func setNavigationBarHiddenStatus(isHidden: Bool)
  {
    isNavigationBarHidden = isHidden
  }
  
  //MARK:- ----------Private Methods--------
  fileprivate func getBarButton(withImage strImageName: String, andSelector selector:(Selector)) -> UIBarButtonItem
  {
    let viewBarButton = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
    button.setImage(UIImage(named: strImageName), for: .normal)
    button.tintColor = .black
    button.titleLabel?.text = ""
    button.addTarget(self, action: selector, for: .touchUpInside)
    viewBarButton.addSubview(button)
    
    let barButton = UIBarButtonItem(customView: viewBarButton)
    return barButton
  }
  
  fileprivate func getSecondBarButton(withImage strImageName: String, andSelector selector:(Selector)) -> UIBarButtonItem
  {
    let viewBarButton = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 16, y: 0, width: 44, height: 44)
    button.setImage(UIImage(named: strImageName), for: .normal)
    button.tintColor = .black
    button.addTarget(self, action: selector, for: .touchUpInside)
    viewBarButton.addSubview(button)
    
    let barButton = UIBarButtonItem(customView: viewBarButton)
    return barButton
  }
  
  fileprivate func getThirdBarButton(withImage strImageName: String, andSelector selector:(Selector)) -> UIBarButtonItem
  {
    let viewBarButton = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 32, y: 0, width: 44, height: 44)
    button.setImage(UIImage(named: strImageName), for: .normal)
    button.tintColor = .black
    button.addTarget(self, action: selector, for: .touchUpInside)
    viewBarButton.addSubview(button)
    
    let barButton = UIBarButtonItem(customView: viewBarButton)
    return barButton
  }
  
  
  //MARK:- ----------IBAction Methods--------
//  func tapBackButton(sender: UIButton)
//  {
//    TANetworkManager.sharedInstance.cancelAllRequests {
//      DispatchQueue.main.async {
//        self.popViewController(animated: true)
//      }
//    }
//  }
  
    @objc func tapCustomBackButton(sender: UIButton)
  {
    customDelegate?.navigationBarButtonItemTapped(.backButton)
  }
  
    @objc func tapLeftBarButtonWithText(sender: UIButton)
  {
    
  }
  
    @objc func tapMenuButton(sender: UIButton)
  {
    //kSharedAppDelegate.swRevealViewC.revealToggle(animated: true)
  }
  
    @objc func tapRightBarButtonWithText(sender: UIButton)
  {
    customDelegate?.navigationBarButtonItemTapped(.rightTextButton)
  }
  
    @objc func tapFirstRightBarButton(sender: UIButton)
  {
    customDelegate?.navigationBarButtonItemTapped(.rightFirstButton)
  }
  
    @objc func tapSecondRightBarButton(sender: UIButton)
  {
    customDelegate?.navigationBarButtonItemTapped(.rightSecondButton)
  }
  
  func tapThirdRightBarButton(sender: UIButton)
  {
    customDelegate?.navigationBarButtonItemTapped(.rightThirdButton)
  }

  
  //MARK:- ----------UINavigationController Delegates--------
  
  public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
  {
    if operation == .push
    {
      navigationController.interactivePopGestureRecognizer?.delegate = nil
      navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
    else if operation == .pop
    {
    }
    return nil
  }
  
  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool)
  {
    
    if self.responds(to: #selector(getter: interactivePopGestureRecognizer))
    {
      if navigationController.children.count > 1
      {
        navigationController.interactivePopGestureRecognizer?.delegate = self
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
      }
    }
    else
    {
      navigationController.interactivePopGestureRecognizer?.delegate = nil
      navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
  }
}
