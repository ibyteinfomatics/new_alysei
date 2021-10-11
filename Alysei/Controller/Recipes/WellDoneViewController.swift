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
    @IBOutlet weak var reviewOuterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popupView.isHidden = true
        let imgUrl = (kImageBaseUrl + (recipeModel?.userMain?.avatarId?.imageUrl ?? ""))
        self.commentTextView.delegate = self
        commentTextView.autocorrectionType = .no
        btnAddReview.layer.cornerRadius = 5
        reviewOuterView.layer.cornerRadius = 5
        self.profileImageVw.setImage(withString: imgUrl)
        
        reviewView.layer.cornerRadius = 5
        reviewView.layer.borderWidth = 2
        reviewView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        
        commentTextView.text = "Your review text here..."
        commentTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapForRateFinal(_ sender: Any) {
        self.popupView.isHidden = false
    }
    
    @IBAction func addReviewFinal(_ sender: Any) {
        commentTextView.text = "Your review text here..."
        commentTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        postDoReview()
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func postDoReview(){
        
        let params = ["recipe_id": recipeId ,"rating": 2]
            
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.doReview, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            
            
          }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Your review text here..." {
       
            commentTextView.text = ""
            commentTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
        }
        
        textView.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == ""{
            commentTextView.text = "Your recipe direction text here..."
            commentTextView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            commentTextView.text = "Your recipe direction text here..."
            commentTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        else{
            
            commentTextView.textColor = .black
        }
        textView.resignFirstResponder()
    }
    

}
