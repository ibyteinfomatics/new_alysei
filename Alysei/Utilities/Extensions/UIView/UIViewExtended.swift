//
//  UIViewExtended.swift
//  TheBeaconApp
//
//  Created by Ruchin Singhal on 04/11/16.
//  Copyright © 2016 finoit. All rights reserved.
//

import UIKit

class UIViewExtended: UIviewCornerRadius
{
}


extension UIView
{
  
  func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T{
        all.append(aView)
      }
      guard view.subviews.count>0 else { return }
      view.subviews.forEach{ getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
  
    func getCenter() -> CGPoint
    {
        return self.center
    }
    
    func getWidth() -> CGFloat
    {
        return self.frame.size.width
    }
  
  /// Width of view.
  public var width: CGFloat {
    get {
      return self.frame.size.width
    }
    set {
      self.frame.size.width = newValue
    }
  }
  
    func getHeight() -> CGFloat
    {
        return self.frame.size.height
    }
    
    func getSize() -> CGSize
    {
        return self.frame.size
    }
    
    func getXPos() -> CGFloat
    {
        return self.frame.origin.x
    }
    
    func getYPos() -> CGFloat
    {
        return self.frame.origin.y
    }
    
    func setCenterPoint(_ value:CGPoint) -> Void
    {
        self.center = value
    }
    
    func setY(_ value:CGFloat?) -> Void
    {
        self.frame.origin.y = value ?? 0.0
    }
    
    func setX(_ value:CGFloat?) -> Void
    {
        self.frame.origin.x = value ?? 0.0
    }
    
    func setHeight(_ value: CGFloat?) -> Void
    {
        self.frame.size.height = value ?? 0.0
    }
    
    func setWidth(_ value:CGFloat?) -> Void
    {
        self.frame.size.width = value ?? 0.0
    }
    
    func snapShotImage() -> UIImage?
    {
        UIGraphicsBeginImageContext(self.frame.size)
        
        if let context = UIGraphicsGetCurrentContext()
        {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil

    }
   
    func addBorder(rectEdge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let hasLayer = (self.layer.sublayers?.filter { $0.name == rectEdge.edgeIdentifier })?.isEmpty == false
        
        if hasLayer { return }
        
        let border = CALayer()
        border.name = rectEdge.edgeIdentifier
        border.frame = rectEdge.edgeFrame(layerFrame: self.frame, borderWidth: thickness)
        border.backgroundColor = color.cgColor;
       self.layer.shadowColor = color.cgColor
       self.layer.shadowOffset = CGSize(width: 0,height: 3)
       self.layer.shadowOpacity = 1
       self.layer.shadowRadius = 1
       self.layer.masksToBounds = false
       self.layer.addSublayer(border)
    }
    
    
    func updateBorderThickness(edge: UIRectEdge,newThickness:CGFloat) {
        
        self.layer.sublayers?.forEach {
            
            if $0.name == edge.edgeIdentifier {
                
                let newFrame = edge.edgeFrame(layerFrame: self.frame, borderWidth: newThickness)
                $0.frame = newFrame
            }
        }
    }
    
    func layerGradient() {
        
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint.zero
        self.clipsToBounds = true
        let colorDarkBlue = UIColor(red: 0.0/255, green: 47.0/255, blue: 83.0/255, alpha: 1).cgColor
        let colorLightBlue = UIColor(red: 33.0/255, green: 121.0/255, blue: 187.0/255, alpha:1).cgColor
        layer.colors = [colorDarkBlue,colorLightBlue]
        self.layer.insertSublayer(layer, at: 0)
     }
  
  func drawBottomShadow(_ color: CGColor = UIColor.lightGray.cgColor) -> Void{
    
    layer.cornerRadius = 0.0
    layer.backgroundColor = UIColor.white.cgColor
    layer.shadowColor = color
    layer.shadowOffset = CGSize(width: 0,height: 3)
    layer.shadowOpacity = 0.4
    layer.shadowRadius = 1
    layer.masksToBounds = false
    
    
//    let shadowView = UIView(frame: self.navigationController!.navigationBar.frame)
//      shadowView.backgroundColor = UIColor.whiteColor()
//      shadowView.layer.masksToBounds = false
//      shadowView.layer.shadowOpacity = 0.4 // your opacity
//      shadowView.layer.shadowOffset = CGSize(width: 0, height: 2) // your offset
//      shadowView.layer.shadowRadius =  4 //your radius
//      self.view.addSubview(shadowView)
//
    
  }
  
  func drawShadow(cornerRadius radius:CGFloat = 8.0, shadowRadius:CGFloat = 4,shadowColor color:UIColor = AppColors.liteGray.color, shadowOffset offset: CGSize = .zero){
    
    
        self.clipsToBounds = true
        let layer = self.layer
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 1
        
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        let backgroundCGColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
 
    
    func makeCornerRadius(radius: CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
   func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [corners], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
  }
  
  func roundedCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
    
      self.layer.cornerRadius = radius
    if #available(iOS 11.0, *) {
      self.layer.maskedCorners = [CACornerMask]
    } else {
      // Fallback on earlier versions
    }
  }
  
//  func roundedCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
//      let topLeftRadius = CGSize(width: topLeft, height: topLeft)
//      let topRightRadius = CGSize(width: topRight, height: topRight)
//      let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
//      let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
//      //let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
//      let shape = CAShapeLayer()
//      shape.path = maskPath.cgPath
//      layer.mask = shape
//    }
  
  
  func drawDottedLine(start p0: CGPoint, end p1: CGPoint,color: UIColor = UIColor.black) {
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = 1
    shapeLayer.lineDashPattern = [4, 3] // 7 is the length of dash, 3 is length of the gap.
    
    let path = CGMutablePath()
    path.addLines(between: [p0, p1])
    shapeLayer.path = path
    self.layer.addSublayer(shapeLayer)
  }
  
  func addDashedBorder() {
    let color = AppColors.green.color.cgColor

      let shapeLayer:CAShapeLayer = CAShapeLayer()
      let frameSize = self.frame.size
      let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

      shapeLayer.bounds = shapeRect
      shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
      shapeLayer.fillColor = UIColor.clear.cgColor
      shapeLayer.strokeColor = color
      shapeLayer.lineWidth = 1
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round
      shapeLayer.lineDashPattern = [6,3]
      shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

      self.layer.addSublayer(shapeLayer)
    }
 }

extension UIRectEdge {
    
    var TopEdgeLayerName: String { return "UIRectEdge.top" }
    var BottomEdgeLayerName: String { return "UIRectEdge.bottom" }
    var LeftEdgeLayerName: String { return "UIRectEdge.left" }
    var RightEdgeLayerName: String { return "UIRectEdge.right" }
    var edgeIdentifier:String {
        
        switch self {
            
        case UIRectEdge.top: return TopEdgeLayerName
        case UIRectEdge.bottom: return BottomEdgeLayerName
        case UIRectEdge.left: return LeftEdgeLayerName
        case UIRectEdge.right: return RightEdgeLayerName
        default: return ""
            
        }
    }
    
    func edgeFrame(layerFrame frame:CGRect, borderWidth thickness:CGFloat) -> CGRect {
        
        switch self {
            
        case UIRectEdge.top:
            return CGRect(x: 0, y: 0, width: frame.width, height: thickness);
            
        case UIRectEdge.bottom: return CGRect(x: 0, y: frame.height - thickness, width:frame.width, height: thickness)
        case UIRectEdge.left: return CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case UIRectEdge.right: return CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default: return CGRect.zero
        }
    }
}

extension UITableView {
    
    func reloadDataInMainQueue() -> Void {
        
        DispatchQueue.main.async { self.reloadData() }
    }
        
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        
            return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
        }
        
    func scrollToTop() {
        
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: true)
            }
    }
  
    

    
    func scrollToLastCell(withList arrList:Array<Any>) -> Void{
      
      if arrList.count == 0 { return }
      if arrList.count-1 > 0 {
        
        if arrList.count-1 == 0 { return }
        
        let index = IndexPath(row: arrList.count-1, section: 0)
        
        
        if self.contentSize.height > 0 {
          
          self.scrollToRow(at: index, at: .bottom, animated: false)
        }
      }
    }
  
}

extension UIViewController {
  
  var alertController: UIAlertController? {
    guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
    return alert
  }
}

//extension UIViewController{
//     func disableWindowInteraction(){
//        if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
//             window.isUserInteractionEnabled = false
//        }
//    }
//}
extension UIApplication {
  
  class func topViewController(_ viewController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
    
    if let nav = viewController as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    if let tab = viewController as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    if let presented = viewController?.presentedViewController {
      return topViewController(presented)
    }
    
    return viewController
  }
}

extension UITextField{
  
  func underlined(borderColor: UIColor = AppColors.gray.color){
    
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor = borderColor.cgColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
    border.borderWidth = width
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}
