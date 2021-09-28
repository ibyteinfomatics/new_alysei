//
//  AboutViewCCollectionViewCell.swift
//  Alysei
//
//  Created by Janu Gandhi on 04/07/21.
//

import UIKit

enum AboutViewCModels {
    struct collectionViewCellData {
        var products = [String]()
        var title = String()
    }
}

class AboutViewTableCellWithCollection: UITableViewCell {

    @IBOutlet var titleLabel: UILabelExtended!
    @IBOutlet var collectionView: UICollectionView!


    var model = AboutViewCModels.collectionViewCellData()

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }

    func seutp(_ model: AboutViewCModels.collectionViewCellData) {
        self.model = model
        self.titleLabel.text = model.title
        self.collectionView.reloadData()
    }

}

extension AboutViewTableCellWithCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutSubviewCollectionViewCell", for: indexPath) as? AboutViewCollectionViewCell else {
            return UICollectionViewCell()
        }

        let product = model.products[indexPath.row]
        cell.titleLabel.text = "\(product)"
        cell.contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 5.0
        cell.titleLabel.sizeToFit()
        cell.contentView.sizeToFit()
        cell.sizeToFit()
        return cell
    }


}
