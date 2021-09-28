//
//  AddReviewViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class AddReviewViewController: UIViewController , UITextViewDelegate{
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txtReview: UITextView!
    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    @IBOutlet weak var userImage: UIImageView!

    var productStoreType: String?
    var productStoreId: String?
    var reviewStarCount: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        txtReview.delegate = self
        headerView.addShadow()
        setStar()
        txtReview.text = "Leave a comment"
        txtReview.textColor = UIColor.lightGray
        txtReview.layer.borderColor = UIColor.lightGray.cgColor
        txtReview.layer.borderWidth = 0.5
        setImage()
        // Do any additional setup after loading the view.
    }
    
    func setImage(){
        _ = UserRoles(rawValue:Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)  ) ?? .voyagers
        if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
            self.userImage.image = profilePhoto
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.masksToBounds = true
            
        }else{
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.borderColor = UIColor.white.cgColor
        }
    }
    func setStar(){
        btnStar1.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }

    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddReview(_ sender: UIButton){
        if (reviewStarCount == 0){
            self.showAlert(withMessage: "Please add ratings.")
        }else{
        callAddReviewApi()
        }
    }
    
    @IBAction func btnStar1(_ sender: UIButton){
        reviewStarCount = 1
        btnStar1.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    @IBAction func btnStar2(_ sender: UIButton){
        reviewStarCount = 2
        btnStar1.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    @IBAction func btnStar3(_ sender: UIButton){
        reviewStarCount = 3
        btnStar1.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    @IBAction func btnStar4(_ sender: UIButton){
        reviewStarCount = 4
        btnStar1.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
        
    }
    @IBAction func btnStar5(_ sender: UIButton){
        reviewStarCount = 5
        btnStar1.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_christmas_star_2"), for: .normal)
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Leave a comment"{
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

            textView.text = "Leave a comment"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
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

extension AddReviewViewController {
    func callAddReviewApi(){
        
        let params: [String:Any] = [
            APIConstants.kId: productStoreId ?? "",
            APIConstants.kType : productStoreType ?? "",
            APIConstants.kRating: reviewStarCount ?? 0,
            APIConstants.kReview: txtReview.text ?? ""
        ]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSubmitReview, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, erroType, statusCode) in
            
            switch statusCode{
            case 200:
                self.showAlert(withMessage: "Review added Successfully!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.navigationController?.popViewController(animated: true)
                }
            case 409:
                self.showAlert(withMessage: "You have already done a review on this product")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.navigationController?.popViewController(animated: true)
                }
            default:
                break
        }
        }
    }
}
