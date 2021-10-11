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
   
    var recipeReviewId = Int()
    var viewRecipeCommentModel: ViewRecipeDetailDataModel?
    var arrAllReviewModel: [LatestReviewDataModel]? = []
    var imageUrl = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allReviewTableView.delegate = self
        allReviewTableView.dataSource = self
        reviewTextView.delegate = self
        reviewTextView.text = "Your review text here..."
        reviewTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        reviewTextView.autocorrectionType = .no
        btnAddReview.layer.cornerRadius = 5
        reviewView.layer.cornerRadius = 5
        reviewView.layer.borderWidth = 2
        reviewView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        
       
        userImageVw.setImage(withString: imageUrl)
        
        getAllReviews()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAddReview(_ sender: Any) {
        reviewTextView.text = "Your review text here..."
        reviewTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        postDoReview()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.getAllReviews()
        }
        isFromComment = "Review"
    }
    
    @IBAction func tap1star(_ sender: Any) {
    }
    @IBAction func tap2star(_ sender: Any) {
    }
    @IBAction func tap3star(_ sender: Any) {
    }
    @IBAction func tap4star(_ sender: Any) {
    }
    @IBAction func tap5star(_ sender: Any) {
    }
    
//    func ratingVaiewSet()
//    {
//        self.rateView.notSelectedImage = UIImage.init(named: "blank")
//        self.rateView.halfSelectedImage = UIImage.init(named: "halfStar")
//        self.rateView.fullSelectedImage = UIImage.init(named: "fullStar")
//        self.rateView.rating = 0;
//        self.rateView.editable = true;
//        self.rateView.maxRating = 5;
//        self.rateView.delegate = self;
//    }
//
//    func rateView(_ rateView: RateView!, ratingDidChange rating: Float) {
//        let rate = String(rating)
//        let testRate = Int(rating)
//        self.strRating = String(testRate)
//        print(rate)
//    }
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
        return 160
    }
    
}

extension AddReviewRecipeViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Your review text here..." {
            reviewTextView.text = ""
            reviewTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
        }
        
        textView.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == ""{
            reviewTextView.text = "Your recipe direction text here..."
            reviewTextView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            reviewTextView.text = "Your recipe direction text here..."
            reviewTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        else{
            
            reviewTextView.textColor = .black
        }
        textView.resignFirstResponder()
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
        
        let params = ["recipe_id": recipeReviewId ,"rating": 2]
            
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.doReview, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            
            
          }
        allReviewTableView.reloadData()
        
    }
   
   
}
