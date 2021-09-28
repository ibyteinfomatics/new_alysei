//
//  CuisinesViewController.swift
//  Preferences
//
//  Created by mac on 24/08/21.
//

import UIKit

class CuisinesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [UIImage]() // This is selected cell data array
    
    var imageArray = [#imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2"),#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse2"), #imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2"),#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse2"), #imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2"),#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse2"), #imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2"),#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse2"), #imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2"),#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse2"), #imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2"),#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse2"), #imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
       
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.cornerRadius = 30
        SaveButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
       


    }
    

    @IBAction func tapSave(_ sender: Any) {
        
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
        viewAll.checkbutton = 3
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
        viewAll.checkbutton = 3
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
    
}
extension CuisinesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        cell.image1.image = imageArray[indexPath.row]
        cell.image2.image = imageArray[indexPath.row]
        
                cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width)/2, height: 240)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

          let strData = imageArray[indexPath.item]

          if arrSelectedIndex.contains(indexPath) {
              arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
              arrSelectedData = arrSelectedData.filter { $0 != strData}
            print("You deselected cell #\(indexPath.item)!")

          }
          else {
              arrSelectedIndex.append(indexPath)
              arrSelectedData.append(strData)
            print("You selected cell #\(indexPath.item)!")
                      }

          collectionView.reloadData()
      }
    }




