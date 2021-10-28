//
//  AddReviewViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 08/10/21.
//

import UIKit

var isFromComment = String()

class AddReviewRecipeViewController: UIViewController{
    
    @IBOutlet weak var allReviewTableView: UITableView!
    @IBOutlet weak var userImageVw: UIImageView!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var btnAddReview: UIButton!
    
    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    
    var reviewStarCount: Int?
    var recipeReviewId = Int()
    var viewRecipeCommentModel: ViewRecipeDetailDataModel?
    var arrAllReviewModel: [LatestReviewDataModel]? = []
//    var imageUrl = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allReviewTableView.delegate = self
        allReviewTableView.dataSource = self
        reviewTextView.delegate = self
        reviewTextView.text = AppConstants.leaveComment
        reviewTextView.textColor = UIColor.lightGray
        reviewTextView.autocorrectionType = .no
        btnAddReview.layer.cornerRadius = 5
        reviewView.layer.cornerRadius = 5
        reviewView.layer.borderWidth = 2
        reviewView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        reviewStarCount = 0
        setStar()
        
        if let imageURLString = kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.attachment_url {
                   userImageVw.setImage(withString: "\(kImageBaseUrl)\(imageURLString)")
        }
        userImageVw.layer.cornerRadius = userImageVw.frame.height/2
        getAllReviews()

    }
    
    func setStar(){
        btnStar1.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar2.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar3.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar4.setImage(UIImage(named: "icons8_star"), for: .normal)
        btnStar5.setImage(UIImage(named: "icons8_star"), for: .normal)
    }

    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAddReview(_ sender: Any) {
        
        if (reviewStarCount == 0){
            self.showAlert(withMessage: "Please add ratings.")
        }
        else if ( reviewTextView.text == AppConstants.leaveComment){
            self.showAlert(withMessage: "Please leave a comment.")
        }
        else{
            
        postDoReview()
            reviewTextView.text = AppConstants.leaveComment
            reviewTextView.textColor = UIColor.lightGray
            reviewStarCount = 0
            setStar()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.getAllReviews()
            }
        }
        
        isFromComment = "Review"
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
    

}

extension AddReviewRecipeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrAllReviewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddReviewTableViewCell") as! AddReviewTableViewCell
        
        let imgUrl = (kImageBaseUrl + (arrAllReviewModel?[indexPath.row].user?.avatarId?.imageUrl ?? ""))
        cell.userProfileImg.setImage(withString: imgUrl)
        cell.userProfileImg.layer.cornerRadius = cell.userProfileImg.frame.height/2
        if arrAllReviewModel?[indexPath.row].user?.name == ""{
            cell.labelUserName.text = "NA"
        }
        else{
            cell.labelUserName.text = arrAllReviewModel?[indexPath.row].user?.name
        }
        
        cell.labelEmailID.text = arrAllReviewModel?[indexPath.row].user?.email
        cell.labelComment.text = arrAllReviewModel?[indexPath.row].review
        
        if arrAllReviewModel?[indexPath.row].rating ?? 0 == 0 {
            cell.rateImg1.image = UIImage(named: "icons8_star")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")

        }
//            else if recipeModel?.avgRating ?? "0.0" == "0.5" {
//                cell.rateImg1.image = UIImage(named: "Group 1142")
//                cell.rateImg2.image = UIImage(named: "icons8_star")
//                cell.rateImg3.image = UIImage(named: "icons8_star")
//                cell.rateImg4.image = UIImage(named: "icons8_star")
//               cell.rateImg5.image = UIImage(named: "icons8_star")
//            }
        else if arrAllReviewModel?[indexPath.row].rating == 1 {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
           cell.rateImg5.image = UIImage(named: "icons8_star")
        }
//            else if recipeModel?.avgRating ?? "0.0" == "1.5" {
//                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg2.image = UIImage(named: "Group 1142")
//                cell.rateImg3.image = UIImage(named: "icons8_star")
//                cell.rateImg4.image = UIImage(named: "icons8_star")
//                cell.rateImg5.image = UIImage(named: "icons8_star")
//            }
    else if arrAllReviewModel?[indexPath.row].rating == 2 {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }
//            else if recipeModel?.avgRating ?? "0.0" == "2.5" {
//                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg3.image = UIImage(named: "Group 1142")
//                cell.rateImg4.image = UIImage(named: "icons8_star")
//                cell.rateImg5.image = UIImage(named: "icons8_star")
//            }
    else if arrAllReviewModel?[indexPath.row].rating == 3 {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }
//            else if recipeModel?.avgRating ?? "0.0" == "3.5" {
//                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg4.image = UIImage(named: "Group 1142")
//                cell.rateImg5.image = UIImage(named: "icons8_star")
//            }
        else if arrAllReviewModel?[indexPath.row].rating == 4{
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "icons8_star")
        }
//            else if recipeModel?.avgRating ?? "0.0" == "4.5" {
//                cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
//                cell.rateImg5.image = UIImage(named: "Group 1142")
//            }
    else if arrAllReviewModel?[indexPath.row].rating == 5 {
            cell.rateImg1.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg2.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg3.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg4.image = UIImage(named: "icons8_christmas_star")
            cell.rateImg5.image = UIImage(named: "icons8_christmas_star")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension AddReviewRecipeViewController: UITextViewDelegate{
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.text == "Leave a comment..." {
//            reviewTextView.text = ""
//            reviewTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
//        }
//
//        textView.becomeFirstResponder()
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
//        if text == "\n"{
//            reviewTextView.text = "Leave a comment..."
//            reviewTextView.resignFirstResponder()
//        }
//        return true
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text == "" {
//            reviewTextView.text = "Leave a comment..."
//            reviewTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
//        }
//        else{
//            reviewTextView.text = textView.text
//            reviewTextView.textColor = .black
//        }
//        textView.resignFirstResponder()
//    }
    
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
extension AddReviewRecipeViewController{
    func getAllReviews(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getAllReviews + "\(recipeReviewId)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.arrAllReviewModel = data.map({LatestReviewDataModel.init(with: $0)})
               
            }
            
            self.allReviewTableView.reloadData()
            
        }
    }
    
    func postDoReview(){
        
        let params: [String:Any] = ["recipe_id": recipeReviewId ,"rating": reviewStarCount ?? 0, "review": self.reviewTextView.text ?? ""]
            
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.doReview, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            
            switch statusCode{
            case 200:
                self.showAlert(withMessage: "Review added Successfully!")
                
            case 409:
                self.showAlert(withMessage: "You have already done a review on this product")
                
            default:
                break
            }
          }
        allReviewTableView.reloadData()
        
    }
   
   
}
