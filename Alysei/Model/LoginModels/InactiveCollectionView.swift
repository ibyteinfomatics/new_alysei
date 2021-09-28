//
//  InactiveCollectionView.swift
//  Alysei
//
//  Created by Gitesh Dang on 22/03/21.
//

import UIKit

class InactiveCollectionView: UICollectionView {

    var countries:[CountryModel]?{didSet{self.reloadData()}}
    var selectDelegate:SelectList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegate()
    }
    func setDelegate() {
        self.register(UINib(nibName: "ActiveCountriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActiveCountriesCollectionViewCell")
        self.delegate = self
        self.dataSource = self
    }
}
// MARK:- cextension of main class for CollectionView
extension InactiveCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = self.dequeueReusableCell(withReuseIdentifier: "ActiveCountriesCollectionViewCell", for: indexPath) as? ActiveCountriesCollectionViewCell else {return UICollectionViewCell()}
        let obj = countries?[indexPath.row] ?? CountryModel()
        cell.btnCheckBox.isHidden = true
            cell.configCell(obj)
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5 , height: 120)

    }
    
}

