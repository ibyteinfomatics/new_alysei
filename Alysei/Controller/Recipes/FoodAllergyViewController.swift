//
//  FoodAllergyViewController.swift
//  Preferences
//
//  Created by mac on 25/08/21.
//

import UIKit
import SVGKit

var arraySelectedFood : [Int]? = []
class FoodAllergyViewController: AlysieBaseViewC {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var selectedIndexPath : IndexPath?
    var arrFoodIntolerance: [SelectFoodIntoleranceDataModel]? = []
    var isFirStTimeLoading = true
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: nil ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        //disableWindowInteraction()
        self.view.isUserInteractionEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 30
        nextButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        
        postRequestToGetFoodIntolerance()

    }
    @IBAction func tapNextToDiets(_ sender: Any) {
        if nextButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FollowDietsViewController") as! FollowDietsViewController
            self.navigationController?.pushViewController(viewAll, animated: true)
        }
        else{
            
        }
       
    }
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSkip(_ sender: Any) {
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FollowDietsViewController") as! FollowDietsViewController
        
     
        for i in 0..<(arrFoodIntolerance?.count ?? 0){
            self.arrFoodIntolerance?[i].isSelected = false
            
            self.arrSelectedIndex.removeAll()
            arraySelectedFood?.removeAll()
            nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            collectionView.reloadData()
        }
    
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
    func postRequestToGetFoodIntolerance() -> Void{
       
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFoodIntolerance, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrFoodIntolerance = data.map({SelectFoodIntoleranceDataModel.init(with: $0)})
           }
           
           self.collectionView.reloadData()
           self.view.isUserInteractionEnabled = true
       }
    }


}
extension FoodAllergyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFoodIntolerance?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
        let imgUrl = (kImageBaseUrl + (arrFoodIntolerance?[indexPath.row].imageId?.imgUrl ?? ""))
        let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
        cell.image1.contentMode = .scaleAspectFit
        cell.image1.image = mySVGImage.uiImage
        cell.imageNameLabel.text = arrFoodIntolerance?[indexPath.row].foodName
//        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
//        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        cell.layoutSubviews()
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell

        selectedIndexPath = indexPath
        if  arrFoodIntolerance?[indexPath.row].isSelected == true {
            arrFoodIntolerance?[indexPath.row].isSelected = false
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            
            for (index,item) in arrSelectedIndex.enumerated(){
                if item == indexPath{
                    arrSelectedIndex.remove(at: index)
                }
            }
            
            for (index,item) in arraySelectedFood!.enumerated(){
                if item == arrFoodIntolerance?[indexPath.row].foodId{
                    arraySelectedFood?.remove(at: index)
                }
            }
            if arrSelectedIndex.count == 0{
                nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            }

        } else {
            arrFoodIntolerance?[indexPath.row].isSelected = true
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            nextButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
            arraySelectedFood?.append(arrFoodIntolerance?[indexPath.row].foodId ?? 0)
            arrSelectedIndex.append(selectedIndexPath!)
            print("\(String(describing: arrSelectedIndex.count))")
        }

       
        
      }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10 , height: 130)
        return cellSize

    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        //Where elements_count is the count of all your items in that
//        //Collection view...
//        let cellCount = CGFloat(arrFoodIntolerance?.count ?? 0)
//
//        //If the cell count is zero, there is no point in calculating anything.
//        if cellCount > 0 {
//            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//            let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
//
//            //20.00 was just extra spacing I wanted to add to my cell.
//            let totalCellWidth = cellWidth*cellCount + 20.00 * (cellCount-1)
//            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
//
//            if (totalCellWidth < contentWidth) {
//                //If the number of cells that exists take up less room than the
//                //collection view width... then there is an actual point to centering them.
//
//                //Calculate the right amount of padding to center the cells.
//                let padding = (contentWidth - totalCellWidth) / 2.0
//                return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
//            } else {
//                //Pretty much if the number of cells that exist take up
//                //more room than the actual collectionView width, there is no
//                // point in trying to center them. So we leave the default behavior.
//                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            }
//        }
//        return UIEdgeInsets.zero
//    }
}
