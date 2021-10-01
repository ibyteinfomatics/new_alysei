//
//  ExploreByMealTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 30/09/21.
//

import UIKit
var searchTitle = String()
protocol SearchRecipeDelegate {
    func cellTappedForSearchRecipe()
   }
class ExploreByMealTableViewCell: UITableViewCell {
    @IBOutlet weak var quickSearchLbl: UILabel!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var delegate: SearchRecipeDelegate?
    var tapViewAll:(()->())?
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cellNib = UINib(nibName: "ExploreCollectionViewCell", bundle: nil)
        self.collectionVw.register(cellNib, forCellWithReuseIdentifier: "ExploreCollectionViewCell")
        collectionVw.collectionViewLayout.invalidateLayout()
        setGradientBackground()
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
         CATransaction.begin()
         CATransaction.setDisableActions(true)
         gradientLayer.frame = self.headerView.bounds
         CATransaction.commit()
        }
    
    
    func setGradientBackground() {
     
        let colorTop =  UIColor(red: 94.0/255.0, green: 199.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 70.0/255.0, green: 172.0/255.0, blue: 213.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.shouldRasterize = true
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
   
    @IBAction func tapViewAll1(_ sender: Any) {
        
            tapViewAll?()
        
    }
}
extension ExploreByMealTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
            return  arraySearchByMeal?.count ?? 0
        
       

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as? ExploreCollectionViewCell {
            
           
                let imgUrl = (kImageBaseUrl + (arraySearchByMeal?[indexPath.item].imageId?.imgUrl ?? ""))
                
                cell.itemImgVw.setImage(withString: imgUrl)
                cell.itemImgVw.layer.cornerRadius = cell.itemImgVw.frame.height/2
                cell.itemImgVw.contentMode = .scaleAspectFill
                
                cell.itemNameLbl.text = arraySearchByMeal?[indexPath.item].mealName ?? ""
               
          
           
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchTitle = arraySearchByMeal?[indexPath.row].mealName ?? ""
        if delegate != nil {
            delegate?.cellTappedForSearchRecipe()
            }
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

