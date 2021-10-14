//
//  WellDoneViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

class WellDoneViewController: UIViewController, UITextViewDelegate {

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
    
    var reviewStarCount: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popupView.isHidden = true
        
        self.commentTextView.delegate = self
        commentTextView.autocorrectionType = .no
        btnAddReview.layer.cornerRadius = 5
        btnCancel.layer.cornerRadius = 5
        reviewOuterView.layer.cornerRadius = 5
        let imgUrl = (kImageBaseUrl + (recipeModel?.userMain?.avatarId?.imageUrl ?? ""))
        self.profileImageVw.setImage(withString: imgUrl)
        
        let imgUrl1 = (kImageBaseUrl + (recipeModel?.image?.imgUrl ?? ""))
        recipeImageView.setImage(withString: imgUrl1)
        
        reviewView.layer.cornerRadius = 5
        reviewView.layer.borderWidth = 2
        reviewView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        
        commentTextView.text = "Leave a comment..."
        commentTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha:
                                                    1)
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
            self.showAlert(withMessage: "Please add ratings.")
        }else{
            
           postDoReview()
            commentTextView.text = "Leave a comment..."
            commentTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            reviewStarCount = 0
            setStar()
           
        }
        
    }
    
    @IBAction func cancelReview(_ sender: Any) {
        
        commentTextView.text = "Leave a comment..."
        commentTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
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
                self.showAlert(withMessage: "Review added Successfully!")
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                
            case 409:
                self.showAlert(withMessage: "You have already done a review on this product")
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            default:
                break
            }
           
            
          }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Leave a comment..." {
       
            commentTextView.text = ""
            commentTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
        }
        
        textView.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == ""{
            commentTextView.text = "Leave a comment..."
            commentTextView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            commentTextView.text = "Leave a comment..."
            commentTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        else{
            
            commentTextView.textColor = .black
        }
        textView.resignFirstResponder()
    }
    

}