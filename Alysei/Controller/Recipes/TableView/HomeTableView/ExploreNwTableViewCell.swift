//
//  ExploreNwTableViewCell.swift
//  Alysei
//
//  Created by Mohit on 11/08/21.
//

import UIKit

class ExploreNwTableViewCell: UITableViewCell {

    @IBOutlet weak var quickSearchLbl: UILabel!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    
    var rowWithimage: [ExploreCollectionVwModl1]?
    var row: [ExploreCollectionVwModl1]?
    
    var tapViewAll:(()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
        headerView.backgroundColor = UIColor.init(red: 236/255, green: 247/255, blue: 255/255, alpha:1)
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "ExploreCollectionViewCell", bundle: nil)
        self.collectionVw.register(cellNib, forCellWithReuseIdentifier: "ExploreCollectionViewCell")
        
    }
    
    @IBAction func tapViewAll1(_ sender: Any) {
        
            tapViewAll?()
        
    }
}
    
extension ExploreNwTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       return self.rowWithimage?.count ?? 0
        return 8
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as? ExploreCollectionViewCell {
            
            
            let imageName =  self.rowWithimage?[indexPath.item].image
            cell.itemImgVw.image = UIImage.init(named: "brussels_sprouts_sliders")
//            cell.itemNameLbl.text = self.rowWithimage?[indexPath.item].name ?? ""
            cell.itemImgVw.layer.cornerRadius = cell.itemImgVw.frame.height/2
            cell.itemNameLbl.text = "Appetizer"
            return cell
           
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: self.collectionVw.frame.width / 5, height: 110.0)
       }
//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//        {
//              var collectionViewSize = collectionView.frame.size
//              collectionViewSize.width = collectionViewSize.width/4.0 //Display Three elements in a row.
//              collectionViewSize.height = collectionViewSize.height/4.0
//              return collectionViewSize
//        }
}

