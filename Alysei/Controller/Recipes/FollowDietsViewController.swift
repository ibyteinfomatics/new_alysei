//
//  FollowDietsViewController.swift
//  Preferences
//
//  Created by mac on 25/08/21.
//
import Foundation
import UIKit
import SVGKit

var arraySelectedDiet: [Int]? = []
class FollowDietsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var followDietLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var selectedIndexPath : IndexPath?
    var arrDiet: [SelectRecipeDietDataModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceNumber = 3
        
       // followDietLabel.text = RecipeConstants.kPreference3
        
        
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        self.view.isUserInteractionEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 30
        nextButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        postRequestToGetDiet()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextButton.setTitle(RecipeConstants.kSave, for: .normal)
        backButton.setTitle(RecipeConstants.kBack, for: .normal)
        skipBtn.setTitle(RecipeConstants.kSkip, for: .normal)
    }
    
    @IBAction func tapNextToingridient(_ sender: Any) {
        if nextButton.layer.backgroundColor == UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor{
            let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "DontSeeIngredientsViewController") as! DontSeeIngredientsViewController
            arrayPreference = PreferencesDataModel.init(id: arraySelectedDiet ?? [], preference: preferenceNumber)
            arrayPreferencesModelData.append(arrayPreference ?? PreferencesDataModel(id: [], preference: 0))
            self.navigationController?.pushViewController(viewAll, animated: true)
        }
        else{
            
        }
    }
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSkip(_ sender: Any) {
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "DontSeeIngredientsViewController") as! DontSeeIngredientsViewController
        for i in 0..<(arrDiet?.count ?? 0){
            
            self.arrDiet?[i].isSelected = false
            self.arrSelectedIndex.removeAll()
            arraySelectedDiet?.removeAll()
            nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            
            collectionView.reloadData()
            
            
        }
        
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
}
extension FollowDietsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDiet?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        
        let imgUrl = ((arrDiet?[indexPath.row].imageId?.baseUrl ?? "") + (arrDiet?[indexPath.row].imageId?.imgUrl ?? ""))
        print(imgUrl)
        let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
       
        cell.image1.contentMode = .scaleAspectFit
        let imageExtensions = ["png", "jpg", "gif","jpeg"]
                
                // Iterate & match the URL objects from your checking results
                let url: URL? = NSURL(fileURLWithPath: imgUrl) as URL
                let pathExtention = url?.pathExtension
                    if imageExtensions.contains(pathExtention!)
                    {
                        cell.image1.setImage(withString: imgUrl)
                       
                    }else
                    {
                        cell.image1.image = mySVGImage.uiImage
                    }
       
        cell.imageNameLabel.text = arrDiet?[indexPath.row].dietName
        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        cell.layoutSubviews()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell
        selectedIndexPath = indexPath
        if  arrDiet?[indexPath.row].isSelected == true {
            arrDiet?[indexPath.row].isSelected = false
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            for (index,item) in arrSelectedIndex.enumerated(){
                if item == indexPath{
                    arrSelectedIndex.remove(at: index)
                    
                }
            }
            
            for (index,item) in arraySelectedDiet!.enumerated(){
                if item == arrDiet?[indexPath.row].dietId{
                    arraySelectedDiet?.remove(at: index)
                }
            }
            if arrSelectedIndex.count == 0{
                nextButton.layer.backgroundColor = UIColor.init(red: 141/255, green: 141/255, blue: 141/255, alpha: 1).cgColor
            }
            
        } else {
            arrDiet?[indexPath.row].isSelected = true
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            nextButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
            arraySelectedDiet?.append(arrDiet?[indexPath.row].dietId ?? 0)
            arrSelectedIndex.append(selectedIndexPath!)
            print("\(String(describing: arrSelectedIndex.count))")
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3 - 10 , height: 140)
        return cellSize
        
    }
    
}

extension FollowDietsViewController{
    
    func postRequestToGetDiet() -> Void{
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeDiet, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            let title = res?["title"] as? String
            self.followDietLabel.text = title
            if let data = res?["data"] as? [[String:Any]]{
                self.arrDiet = data.map({SelectRecipeDietDataModel.init(with: $0)})
            }
            
            self.collectionView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
        
    }
}
