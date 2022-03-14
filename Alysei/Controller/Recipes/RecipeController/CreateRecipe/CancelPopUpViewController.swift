//
//  CancelPopUpViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 04/08/21.
//

import UIKit

class CancelPopUpViewController: UIViewController {
    
    @IBOutlet weak var areYouSureLabel: UILabel!
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
        areYouSureLabel.text = RecipeConstants.kDiscardAlert
        confirmButton.setTitle(RecipeConstants.kDiscard, for: .normal)
        cancelButton.setTitle(RecipeConstants.kSaveInDraft, for: .normal)
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
        }
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            selectedIngridentsArray.removeAll()
            selectedToolsArray.removeAll()
            arrayStepFinalData.removeAll()
            self.Callback?()
        }
        
    }
    
    @IBAction func tapCross(_ sender: Any) {
        
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
        
        var savedIngridientArray : [[String : Any]] = []
        
        for item in selectedIngridentsArray{
            var ingridientDictionary : [String : Any] = [:]
            ingridientDictionary["ingredient_id"] = item.recipeIngredientIds
            ingridientDictionary["quantity"] = item.quantity
            ingridientDictionary["unit"] = item.unit
            savedIngridientArray.append(ingridientDictionary)
        }
        
        var savedToolsArray : [[String : Any]] = []
        
        for item in selectedToolsArray{
            var toolDictionary : [String : Any] = [:]
            toolDictionary["tool_id"] = item.recipeToolIds
            savedToolsArray.append(toolDictionary)
        }
        
        var savedStepArray : [[String : Any]] = []
        for item in arrayStepFinalData{
            var stepDictionary : [String : Any] = [:]
            stepDictionary["description"] = item.description
            stepDictionary["title"] = item.title
            stepDictionary["ingredients"] = item.ingridentsArray?.map{ (selectedIngridentsArray) -> Int in
                if selectedIngridentsArray.isSelected == true{
                    return selectedIngridentsArray.recipeIngredientIds!
                }
              return 0
            }
            stepDictionary["tools"] = item.toolsArray?.map{ (selectedToolsArray) -> Int in
                if selectedToolsArray.isSelected == true{
                    return selectedToolsArray.recipeToolIds!
                }
              return 0
            }
            savedStepArray.append(stepDictionary)
        }
       
        let params: [String:Any] = [APIConstants.kImageId: imageId!, APIConstants.kName: name!, APIConstants.kMealId: mealId!, APIConstants.kCourseId: courseId!, APIConstants.kHours: hour!, APIConstants.kminutes: minute!, APIConstants.kServing: serving!, APIConstants.kCousinId: cousinId!, APIConstants.kRegionId: regionId!, APIConstants.kDietId: dietId!, APIConstants.kIntoleranceId: foodIntoleranceId ?? 0, APIConstants.kCookingSkillId: cookingSkillId!,"status": "0",APIConstants.kSavedIngridient: savedIngridientArray, APIConstants.kSavedTools: savedToolsArray, APIConstants.kRecipeStep: savedStepArray]

        let paramsMain: [String: Any] = ["params": params]
        print(params)
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.draftRecipe, requestMethod: .POST, requestParameters: paramsMain, withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
//             let resultNew = dictResponse as? [String:Any]
//            if let message = resultNew?["message"] as? String{
//                self.showAlert(withMessage: message)
//            }
            self.Callback?()
        }
    }
}
