//
//  AddEditReviewRecipeViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 29/11/21.
//

import UIKit

class AddEditReviewRecipeViewController: UIViewController , UITextViewDelegate{
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tapToRateLabel: UILabel!
    @IBOutlet weak var txtReview: UITextView!
    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var btnAddReview: UIButton!
    
    var recipeReviewId = Int()
    var reviewStarCount = 0
    var editReviewData : LatestReviewDataModel?
    var isEditReview : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtReview.delegate = self
        txtReview.autocorrectionType = .no
        headerView.drawBottomShadow()
        tapToRateLabel.text = RecipeConstants.kTapToRate
        
        if isEditReview == true
        {
            headerLabel.text = RecipeConstants.kEditReview
            btnAddReview.setTitle(RecipeConstants.kEditReview, for: .normal)
            setReviewStarUI()
            txtReview.textColor = UIColor.black
            txtReview.text = editReviewData?.review
        }else {
            headerLabel.text = RecipeConstants.kAddReview
            btnAddReview.setTitle(RecipeConstants.kAddReview, for: .normal)
            txtReview.textColor = UIColor.darkGray
            setStar()
            txtReview.text = RecipeConstants.kLeaveComment
        }
        
        txtReview.layer.borderColor = UIColor.darkGray.cgColor
        txtReview.layer.borderWidth = 0.5
        setImage()
        
        // Do any additional setup after loading the view.
    }
    
    func setImage(){
        //        _ = UserRoles(rawValue:Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)  ) ?? .voyagers
        //        if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
        //            self.userImage.image = profilePhoto
        //            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
        //            self.userImage.layer.borderWidth = 5.0
        //            self.userImage.layer.masksToBounds = true
        //
        //        }else{
        //            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
        //            self.userImage.layer.borderWidth = 5.0
        //            self.userImage.layer.borderColor = UIColor.white.cgColor
        //        }
        if let imageURLString = kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.attachment_url {
            userImage.setImage(withString: "\(kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.baseUrl ?? "")\(imageURLString)")
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.masksToBounds = true
        }
    }
    
    func setStar(){
        btnStar1.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }
    
    func setReviewStarUI(){
        if (editReviewData?.rating ?? 0) == 0 {
            reviewStarCount = 0
            btnStar1.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
            
        }else if (editReviewData?.rating ?? 0) == 1 {
            reviewStarCount = 1
            btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
            
        }else if (editReviewData?.rating ?? 0) == 2 {
            reviewStarCount = 2
            btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        }else if (editReviewData?.rating ?? 0) == 3 {
            reviewStarCount = 3
            btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
            btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        }else if (editReviewData?.rating ?? 0) == 4 {
            reviewStarCount = 4
            btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar4.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        }else if (editReviewData?.rating ?? 0) == 5 {
            reviewStarCount = 5
            btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar4.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
            btnStar5.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        }
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddReview(_ sender: UIButton){
        if (reviewStarCount == 0){
            self.showAlert(withMessage: MarketPlaceConstant.kPleaseAddRatings)
            return
        }
        else if (txtReview.text == AppConstants.leaveComment && txtReview.textColor == UIColor.darkGray) || txtReview.text == ""{
            self.showAlert(withMessage:  MarketPlaceConstant.kEnterSomeReview)
            return
            //txtReview.text = ""
        }else{
            if isEditReview == true {
                callEditRecipeReviewApi()
            }else{
                postDoReview()
            }
        }
    }
    
    
    @IBAction func btnStar1(_ sender: UIButton){
        reviewStarCount = 1
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    
    @IBAction func btnStar2(_ sender: UIButton){
        reviewStarCount = 2
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    
    @IBAction func btnStar3(_ sender: UIButton){
        reviewStarCount = 3
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    
    @IBAction func btnStar4(_ sender: UIButton){
        reviewStarCount = 4
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    
    @IBAction func btnStar5(_ sender: UIButton){
        reviewStarCount = 5
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView.text == AppConstants.leaveComment && txtReview.textColor == UIColor.darkGray{
            textView.text = ""
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = RecipeConstants.kLeaveComment
            textView.textColor = UIColor.darkGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        
        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
        else if textView.textColor == UIColor.darkGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        
        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }
        
        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
}

extension AddEditReviewRecipeViewController {
    
    func postDoReview(){
        
        let params: [String:Any] = ["recipe_id": recipeReviewId ,"rating": reviewStarCount, "review": self.txtReview.text ?? ""]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.doReview, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            
            switch statusCode{
            case 200:
                self.showAlert(withMessage: RecipeConstants.kReviewAddedMsg) {
                    self.navigationController?.popViewController(animated: true)
                }
            case 409:
                self.showAlert(withMessage: RecipeConstants.kAlreadyReviewAlert) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            default:
                break
            }
            
        }
        
    }
    
    func callEditRecipeReviewApi(){
        print("Edit Review")
        let params: [String:Any] = [
            APIConstants.kRecipeReviewRatingId: editReviewData?.recipeReviewRateId ?? "",
            APIConstants.kRating: reviewStarCount ,
            APIConstants.kReview: txtReview.text ?? ""
        ]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.editReview, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, erroType, statusCode) in
            
            switch statusCode{
            case 200:
                
                self.showAlert(withMessage: RecipeConstants.kReviewUpdatedMsg) {
                    self.navigationController?.popViewController(animated: true)
                }
            case 409:
                print("Error")
            default:
                break
            }
        }
    }
}
