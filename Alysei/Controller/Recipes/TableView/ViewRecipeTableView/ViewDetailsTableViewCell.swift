//
//  ViewDetailsTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 18/08/21.
//

import UIKit

class ViewDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cell1View: UIView!
    @IBOutlet weak var energyCircularProgressView: CircularProgressView!
    @IBOutlet weak var proteinCircularProgressView: CircularProgressView!
    @IBOutlet weak var carbsCircularProgressView: CircularProgressView!
    @IBOutlet weak var fatCircularProgressView: CircularProgressView!
    @IBOutlet weak var utencilButton: UIButton!
    @IBOutlet weak var ingredientsButton: UIButton!
    @IBOutlet weak var ingredientsStatusView: UIView!
    @IBOutlet weak var utencilsStatusView: UIView!
    @IBOutlet weak var labelRecipeName: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var labelLike: UILabel!
    
    @IBOutlet weak var rateImg1: UIImageView!
    @IBOutlet weak var rateImg2: UIImageView!
    @IBOutlet weak var rateImg3: UIImageView!
    @IBOutlet weak var rateImg4: UIImageView!
    @IBOutlet weak var rateImg5: UIImageView!
    
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelServing: UILabel!
    @IBOutlet weak var labelMealType: UILabel!
    @IBOutlet weak var imagLike: UIImageView!

    @IBOutlet weak var labelEnergyValue: UILabel!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var viewshare: UIView!
    
    var reloadTableViewCallback:((Int) ->Void)? = nil
    var shareCallback:(() ->Void)? = nil
    var islike: Int?
    enum source {
        case button1
        case button2
    }

    var likeCallback:( () -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUi()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        self.viewLike.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(shareAction))
        self.viewshare.addGestureRecognizer(tap1)
    }
    
    @objc func likeAction(_ tap: UITapGestureRecognizer){
        
        if recipeModel?.isFav == 1 {
            islike = 0
        }else{
            islike = 1
        }
        
        postReqtoFavUnfavRecipe(islike, recipeId)

    }
    
   @objc func shareAction(){
    shareCallback?()
    }
    
    func setUi(){
        energyCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        energyCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        energyCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.3)
        
        
        proteinCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        proteinCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        proteinCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.5)
        
        
        carbsCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        carbsCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        carbsCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.7)
        
        
        
        fatCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        fatCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        fatCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.9)

        
      
    }
    
    @IBAction func utencilsButton(_ sender: UIButton) {
//        self.source = .button2
            self.utencilButton.setTitleColor(.black, for: .normal)
                        self.utencilButton.setImage(#imageLiteral(resourceName: "icons8_kitchen"), for: .normal)
                        utencilsStatusView.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.ingredientsButton.setTitleColor(.lightGray, for: .normal)
            self.ingredientsButton.setImage(#imageLiteral(resourceName: "icons8_kitchen1"), for: .normal)
            self.ingredientsStatusView.layer.backgroundColor = UIColor.clear.cgColor
        reloadTableViewCallback?(sender.tag)
         

    }
        
    @IBAction func ingredientsButton(_ sender: UIButton) {
//        self.source = .button1
        self.ingredientsButton.setTitleColor(.black, for: .normal)
                    self.ingredientsButton.setImage(#imageLiteral(resourceName: "icons8_kitchen"), for: .normal)
                    ingredientsStatusView.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        self.utencilButton.setTitleColor(.lightGray, for: .normal)
        self.utencilButton.setImage(#imageLiteral(resourceName: "icons8_kitchen1"), for: .normal)
        self.utencilsStatusView.layer.backgroundColor = UIColor.clear.cgColor
        reloadTableViewCallback?(sender.tag)
    

    }
    
    func postReqtoFavUnfavRecipe(_ islike1: Int?, _ recipeId: Int?){
        
        let params: [String:Any] = ["recipe_id": recipeId ?? 0 ,"favourite_or_unfavourite": islike1 ?? 0 ]
            
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFavUnfavRecipe, requestMethod: .POST, requestParameters: params, withProgressHUD:  true){ (dictResponse, error, errorType, statusCode) in
            recipeModel?.isFav = islike1
            if islike1 == 0{
                recipeModel?.favCount = ((recipeModel?.favCount ?? 1) - 1)
            }else{
                recipeModel?.favCount = ((recipeModel?.favCount ?? 1) + 1)
               
            }
            self.likeCallback?()
            
          }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
