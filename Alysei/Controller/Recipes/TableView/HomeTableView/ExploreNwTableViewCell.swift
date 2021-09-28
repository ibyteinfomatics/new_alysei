//
//  ExploreNwTableViewCell.swift
//  Alysei
//
//  Created by Mohit on 11/08/21.
//

import UIKit
var finalheight : CGFloat?
var finalheight1 : CGFloat?
var arraySearchByMeal : [SelectMealDataModel]? = []
var arraySearchByIngridient : [IngridentArray]? = []
class ExploreNwTableViewCell: UITableViewCell {

    @IBOutlet weak var quickSearchLbl: UILabel!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var rowWithimage: [ExploreCollectionVwModl1]?
    var row: [ExploreCollectionVwModl1]?
   

    var tapViewAll:(()->())?
    let gradientLayer = CAGradientLayer()
    var checkCell = 0
    override func awakeFromNib(){
        super.awakeFromNib()
        
       
        setGradientBackground()
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
     
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "ExploreCollectionViewCell", bundle: nil)
        self.collectionVw.register(cellNib, forCellWithReuseIdentifier: "ExploreCollectionViewCell")
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
    }
    override func layoutSubviews() {
            super.layoutSubviews()
        CATransaction.begin()
         CATransaction.setDisableActions(true)
         gradientLayer.frame = self.headerView.bounds
         CATransaction.commit()
        }
    
    
    func setGradientBackground() {
     
        let colorTop =  UIColor(red: 55.0/255.0, green: 162.0/255.0, blue: 130.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 47.0/255.0, green: 151.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.shouldRasterize = true
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
   
    @IBAction func tapViewAll1(_ sender: Any) {
        
            tapViewAll?()
        
    }
    
//    func getSearchByMeal(){
//        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
//                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
//
//            let dictResponse = dictResponse as? [String:Any]
//
//            if let data = dictResponse?["data"] as? [String:Any]{
//
//                if let meals = data["meals"] as? [[String:Any]]{
//                    let meal = meals.map({SelectMealDataModel.init(with: $0)})
//                    arraySearchByMeal = meal
//                    print("\(String(describing: arraySearchByMeal?.count))")
//                }
//
//            }
//            self.collectionVw.reloadData()
//    }
//    }
//
//    func getSearchByIngridients(){
//        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeHomeScreen
//                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
//
//            let dictResponse = dictResponse as? [String:Any]
//
//            if let data = dictResponse?["data"] as? [String:Any]{
//
//                if let ingridients = data["ingredients"] as? [[String:Any]]{
//                    let ingridient = ingridients.map({IngridentArray.init(with: $0)})
//                  arraySearchByIngridient = ingridient
//                    print("\(String(describing: arraySearchByIngridient?.count))")
//                }
//            }
//            self.collectionVw.reloadData()
//    }
//    }
    
}
    
extension ExploreNwTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if checkCell == 0{
            return arraySearchByIngridient?.count ?? 0
          
        }
        else if checkCell == 1{
            return  arraySearchByMeal?.count ?? 0
        }
        else{
            return 0
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as? ExploreCollectionViewCell {
            
            if checkCell == 0{
                
                let imgUrl = (kImageBaseUrl + (arraySearchByIngridient?[indexPath.item].imageId?.imgUrl ?? ""))
                
                cell.itemImgVw.setImage(withString: imgUrl)
                cell.itemImgVw.layer.cornerRadius = cell.itemImgVw.frame.height/2
                cell.itemImgVw.contentMode = .scaleAspectFill
                cell.itemNameLbl.text = arraySearchByIngridient?[indexPath.item].ingridientTitle
               
            }
            else if checkCell == 1{
                let imgUrl = (kImageBaseUrl + (arraySearchByMeal?[indexPath.item].imageId?.imgUrl ?? ""))
                
                cell.itemImgVw.setImage(withString: imgUrl)
                cell.itemImgVw.layer.cornerRadius = cell.itemImgVw.frame.height/2
                cell.itemImgVw.contentMode = .scaleAspectFill
                cell.itemNameLbl.text = arraySearchByMeal?[indexPath.item].mealName
               
            }
            else{
                
            }
            
//            if arraySearchByMeal!.count <= 3{
//
//                finalheight = 200
//            }
//            else{
//
//                finalheight = 400
//            }
//
//            if arraySearchByIngridient!.count <= 3{
//
//                finalheight1 = 200
//            }
//            else{
//
//                finalheight1 = 400
//            }
//            finalheight = collectionViewHeight.constant
//            finalheight1 = collectionViewHeight.constant
//
//
            return cell
           
        }
        
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: self.collectionVw.frame.width / 4, height: 180.0)
       }
//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//        {
//              var collectionViewSize = collectionView.frame.size
//              collectionViewSize.width = collectionViewSize.width/4.0 //Display Three elements in a row.
//              collectionViewSize.height = collectionViewSize.height/4.0
//              return collectionViewSize
//        }
}

