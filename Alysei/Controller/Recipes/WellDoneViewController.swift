//
//  WellDoneViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

class WellDoneViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var writeReviewLabel: UILabel!
    @IBOutlet weak var wellDoneLabel: UILabel!
    @IBOutlet weak var timeToEnjoyLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var rateImageView: UIImageView!
    
    @IBOutlet weak var profileImageVw: UIImageView!
    @IBOutlet weak var reviewView: UIView!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var btnAddReview: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var reviewOuterView: UIView!
    
    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tapToRateLabel: UILabel!
    
    var reviewStarCount: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark: set localization string---
        writeReviewLabel.text = RecipeConstants.kWriteReview
        wellDoneLabel.text = RecipeConstants.kWellDone
        timeToEnjoyLabel.text = RecipeConstants.kEnjoyRecipeMsg
        doneBtn.setTitle(RecipeConstants.kDone, for: .normal)
        tapToRateLabel.text = RecipeConstants.kTapToRate
        btnAddReview.setTitle(RecipeConstants.kAddReview, for: .normal)
        btnCancel.setTitle(RecipeConstants.kCancel, for: .normal)
        
        
        self.popupView.isHidden = true
        
        self.commentTextView.delegate = self
        commentTextView.autocorrectionType = .no
        btnAddReview.layer.cornerRadius = 5
        btnCancel.layer.cornerRadius = 5
        reviewOuterView.layer.cornerRadius = 5
       
        if let imageURLString = kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.attachment_url {
            profileImageVw.setImage(withString: "\(kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.baseUrl ?? "")\(imageURLString)")
            self.profileImageVw.layer.cornerRadius = (self.profileImageVw.frame.width / 2.0)
            self.profileImageVw.layer.borderWidth = 5.0
            self.profileImageVw.layer.masksToBounds = true
        }
        let imgUrl1 = ((recipeModel?.image?.baseUrl ?? "") + (recipeModel?.image?.imgUrl ?? ""))
        recipeImageView.setImage(withString: imgUrl1)
        
        reviewView.layer.cornerRadius = 5
        reviewView.layer.borderWidth = 2
        reviewView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        
        commentTextView.text = AppConstants.leaveComment
        commentTextView.textColor = UIColor.darkGray
        reviewStarCount = 0
        setStar()
        // Do any additional setup after loading the view.
    }
    
    func setStar(){
        btnStar1.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }
    
    @IBAction func tapForRateFinal(_ sender: Any) {
        self.popupView.isHidden = false
    }
    
    @IBAction func addReviewFinal(_ sender: Any) {
        if (reviewStarCount == 0){
            self.showAlert(withMessage: RecipeConstants.kAddRatingAlert)
        }
        else if ( commentTextView.text == AppConstants.leaveComment){
            self.showAlert(withMessage: RecipeConstants.kLeaveCommentAlert)
        }
        else{
            
           postDoReview()
            commentTextView.text = AppConstants.leaveComment
            commentTextView.textColor = UIColor.darkGray
            reviewStarCount = 0
            setStar()
        }
        
    }
    
    @IBAction func cancelReview(_ sender: Any) {
        
        commentTextView.text = AppConstants.leaveComment
        commentTextView.textColor = UIColor.darkGray
        self.popupView.isHidden = true
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapDone(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func tap1star(_ sender: Any) {
        
        reviewStarCount = 1
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }
    
    @IBAction func tap2star(_ sender: Any) {
        reviewStarCount = 2
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }
    
    @IBAction func tap3star(_ sender: Any) {
        reviewStarCount = 3
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }
    
    @IBAction func tap4star(_ sender: Any) {
        reviewStarCount = 4
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }
    
    @IBAction func tap5star(_ sender: Any) {
        reviewStarCount = 5
        btnStar1.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_christmas_star"), for: .normal)
    }
    
    func postDoReview(){
        
        let params = ["recipe_id": recipeId ,"rating": 2, "review" : self.commentTextView.text ?? ""] as [String : Any]
            
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.doReview, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                self.showAlert(withMessage: RecipeConstants.kReviewAddedMsg)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                
            case 409:
                self.showAlert(withMessage: RecipeConstants.kAlreadyReviewAlert)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            default:
                break
            }
           
          }
        
    }
   
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == AppConstants.leaveComment{
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

            textView.text = AppConstants.leaveComment
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
