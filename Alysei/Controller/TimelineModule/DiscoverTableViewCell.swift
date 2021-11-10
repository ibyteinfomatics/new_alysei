//
//  DiscoverTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/26/21.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    
    var storyUser = ["Events","Trips","Blogs","Restaurants"]
    var storyImage  = ["select_role2","select_role3","select_role1","select_role4"]
    var pushCallback: ((Int) ->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DiscoverTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = discoverCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCollectionViewCell", for: indexPath) as? DiscoverCollectionViewCell else{return UICollectionViewCell()}
        cell.imgStory.image = UIImage(named: storyImage[indexPath.row])
        cell.userName.text = storyUser[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: discoverCollectionView.width / 5, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushCallback?(indexPath.row)
        print("Name ",storyUser[indexPath.item])
    }
    
}
