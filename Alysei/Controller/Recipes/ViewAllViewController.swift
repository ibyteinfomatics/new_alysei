//
//  ViewAllViewController.swift
//  Preferences
//
//  Created by mac on 27/08/21.
//

import UIKit

class ViewAllViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [#imageLiteral(resourceName: "Ellipse3"), #imageLiteral(resourceName: "Ellipse2"),#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "Ellipse2"), #imageLiteral(resourceName: "Ellipse3")]
    var imageNameArray = ["Egg","Banana","Papaya","Oily","Lichi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension ViewAllViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewAllCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewAllCollectionViewCell", for: indexPath) as! ViewAllCollectionViewCell
        cell.ingredientsImage.image = imageArray[indexPath.row]
        cell.ingredientsLabel.text = imageNameArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width)/4, height: 100)
        return cellSize
    }
}
