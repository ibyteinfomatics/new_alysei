//
//  EditRecipeViewController.swift
//  Filter App
//
//  Created by mac on 06/09/21.
//

import UIKit

class EditRecipeViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var cameraOpenView: UIView!
    @IBOutlet weak var selectMealView: UIView!
    @IBOutlet weak var selectCourseView: UIView!
    @IBOutlet weak var editIngredients: UIButton!
    @IBOutlet weak var hoursLable: UILabel!
    @IBOutlet weak var minutesLable: UILabel!
    @IBOutlet weak var howMuchPeopleLable: UILabel!

    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        selectMealView.layer.borderWidth = 1
        selectMealView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectMealView.layer.cornerRadius = 5
        selectCourseView.layer.borderWidth = 1
        selectCourseView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectCourseView.layer.cornerRadius = 5
        
        editIngredients.layer.cornerRadius = 6
        
        recipeImage.layer.cornerRadius = 6
        cameraOpenView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 6.0)
       
    }
    @IBAction func plusHoursButton(_ sender: UIButton) {
        if counter != 24{
        counter += 1
        
            hoursLable.text = String(counter)
             print(counter)
            self.hoursLable.slideInFromLeft()
        }
        else{
            counter = 0
            hoursLable.text = String(counter)
            print(counter)
            self.hoursLable.slideInFromLeft()
        }
        
    }
    @IBAction func minusHoursButton(_ sender: UIButton) {
        if counter != 0 {
        if counter > 0 { counter -= 1 }
        hoursLable.text = String(counter)
        print(counter)
            self.hoursLable.slideInFromLeft()
        }
    else{
        counter = 24
        hoursLable.text = String(counter)
        print(counter)
        self.hoursLable.slideInFromLeft()
    }
    }
    
    @IBAction func plusMinutesButton(_ sender: UIButton) {
        if counter != 60{
        counter += 1
        
            minutesLable.text = String(counter)
             print(counter)
            self.minutesLable.slideInFromLeft()
        }
        else{
            counter = 0
            minutesLable.text = String(counter)
            print(counter)
            self.minutesLable.slideInFromLeft()
        }
    }
    @IBAction func minusMinutesButton(_ sender: UIButton) {
        if counter != 0 {
        if counter > 0 { counter -= 1 }
        minutesLable.text = String(counter)
        print(counter)
            self.minutesLable.slideInFromLeft()
        }
    else{
        counter = 60
        minutesLable.text = String(counter)
        print(counter)
        self.minutesLable.slideInFromLeft()
    }
    }
    @IBAction func howMuchPeoplePlusButton(_ sender: UIButton) {
        if counter != 24{
        counter += 1
        
            howMuchPeopleLable.text = String(counter)
             print(counter)
            self.howMuchPeopleLable.slideInFromLeft()
        }
        else{
            counter = 0
            howMuchPeopleLable.text = String(counter)
            print(counter)
            self.howMuchPeopleLable.slideInFromLeft()
        }
    }
    @IBAction func howMuchPeopleMinusButton(_ sender: UIButton) {
        if counter != 0 {
        if counter > 0 { counter -= 1 }
        howMuchPeopleLable.text = String(counter)
        print(counter)
            self.howMuchPeopleLable.slideInFromLeft()
        }
    else{
        counter = 24
        howMuchPeopleLable.text = String(counter)
        print(counter)
        self.howMuchPeopleLable.slideInFromLeft()
    }
    }
    
    
}
//extension UIView {
//   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
//}
//extension UIView {
//     // Name this function in a way that makes sense to you...
//     // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
//    func slideInFromLeft(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
//         // Create a CATransition animation
//        let slideInFromLeftTransition = CATransition()
// 
//       // Set its callback delegate to the completionDelegate that was provided (if any)
//       if let delegate: AnyObject = completionDelegate {
//        slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
//       }
//
//        // Customize the animation's properties
//        slideInFromLeftTransition.type = CATransitionType.push
//        slideInFromLeftTransition.subtype = CATransitionSubtype.fromTop
//       slideInFromLeftTransition.duration = duration
//        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
//
//        // Add the animation to the View's layer
//        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")    }
//
//}
//   
