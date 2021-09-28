//
//  StateWiseHubCollectionView.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/16/21.
//

import UIKit

class StateWiseHubCollectionView: UICollectionView {

    var selectDelegate:SelectList?
    var hascome:HasCome? = .city
    var countries:[CountryModel]?{didSet{self.reloadData()}}
    var currentIndex = 0
   
    // MARK:- life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegate()
    }
    func setDelegate() {
        self.register(UINib(nibName: "StateWiseHubCollectionCell", bundle: nil), forCellWithReuseIdentifier: "StateWiseHubCollectionCell")
        self.delegate = self
        self.dataSource = self
    }
    
}
// MARK:- cextension of main class for CollectionView
extension StateWiseHubCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = self.dequeueReusableCell(withReuseIdentifier: "StateWiseHubCollectionCell", for: indexPath) as? StateWiseHubCollectionCell else {return UICollectionViewCell()}
        cell.configureData(indexPath: indexPath, currentIndex: self.currentIndex)
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4 , height: 120)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.currentIndex = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
       // self.collectionView.reloadData()
    }
}

