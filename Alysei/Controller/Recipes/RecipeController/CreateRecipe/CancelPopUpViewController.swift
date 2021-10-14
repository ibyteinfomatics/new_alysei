//
//  CancelPopUpViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 04/08/21.
//

import UIKit

class CancelPopUpViewController: UIViewController {
    @IBOutlet weak var circularImageView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var popUpView1: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelView: UIView!
    var Callback:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.definesPresentationContext = true

        lineView.roundCorners(corners: [.topLeft,.topRight], radius: 2)
        popUpView1.roundCorners(corners: [.topLeft,.topRight,.bottomRight,.bottomLeft], radius: 3)
        cancelView.roundCorners(corners: [.bottomRight,.bottomLeft], radius: 3)
        cancelButton.layer.cornerRadius = 5
        confirmButton.layer.cornerRadius = 5
        circularImageView.layer.cornerRadius = circularImageView.frame.size.width/2
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.postRequestToSaveInDraftRecipe()
           
            self.Callback?()
        }
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            selectedIngridentsArray.removeAll()
            selectedToolsArray.removeAll()
            self.Callback?()
        }
        
        
           
        
    
    }
    @IBAction func tapCross(_ sender: Any) {
        selectedIngridentsArray.removeAll()
        selectedToolsArray.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
extension CancelPopUpViewController{
    
    func postRequestToSaveInDraftRecipe(){
        
        let imageId = createRecipeJson["recipeImage"] as? String
        let name = createRecipeJson["name"]
        let mealId = createRecipeJson["mealId"]
        let courseId = createRecipeJson["courseId"]
        let cousinId = createRecipeJson["cusineId"]
        let regionId = createRecipeJson["regionId"]
        let dietId = createRecipeJson["dietId"]
        let foodIntoleranceId = createRecipeJson["foodIntoleranceId"]
        let cookingSkillId = createRecipeJson["cookingSkillId"]
        let hour = createRecipeJson["hour"]
        let minute = createRecipeJson["minute"]
        let serving = createRecipeJson["serving"]
       
        let params: [String:Any] = [APIConstants.kImageId: imageId!, APIConstants.kName: name!, APIConstants.kMealId: mealId!, APIConstants.kCourseId: courseId!, APIConstants.kHours: hour!, APIConstants.kminutes: minute!, APIConstants.kServing: serving!, APIConstants.kCousinId: cousinId!, APIConstants.kRegionId: regionId!, APIConstants.kDietId: dietId!, APIConstants.kIntoleranceId: foodIntoleranceId ?? 0, APIConstants.kCookingSkillId: cookingSkillId!,"status": "0",APIConstants.kSavedIngridient: [[APIConstants.kIngridientId: strIngridientId, APIConstants.kQuantity: finalquantityIngridirnt ?? 0, APIConstants.kUnit: finalUnitIngridirnt ?? ""]],APIConstants.kSavedTools: [[APIConstants.kToolId: strToolId , APIConstants.kQuantity: finalquantityTool ?? 0, APIConstants.kUnit: finalUnitTool ?? ""]], APIConstants.kRecipeStep: [[APIConstants.kTitle: strTitle ?? "", APIConstants.kDescription: strDescription ?? "", APIConstants.kIngridients: [ingridientArray] , APIConstants.kTools: [toolArray]]]]

    
        let paramsMain: [String: Any] = ["params": params]
        
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.draftRecipe, requestMethod: .POST, requestParameters: paramsMain, withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
             let resultNew = dictResponse as? [String:Any]
            if let message = resultNew?["message"] as? String{
                self.showAlert(withMessage: message, nil)
            }
            
        }
    }

    
}
