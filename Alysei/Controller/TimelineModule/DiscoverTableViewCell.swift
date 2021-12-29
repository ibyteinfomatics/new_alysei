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
    var data: [NewDiscoverDataModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(_ data: [NewDiscoverDataModel]){
        self.data = data
        self.discoverCollectionView.reloadData()
    }
}

extension DiscoverTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = discoverCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCollectionViewCell", for: indexPath) as? DiscoverCollectionViewCell else{return UICollectionViewCell()}
        if String.getString(data?[indexPath.row].image?.attachmentUrl) == ""{
            cell.imgStory.image = UIImage(named: "profile_icon")
        }else{
            cell.imgStory.setImage(withString: String.getString(data?[indexPath.row].image?.baseUrl) + String.getString(data?[indexPath.row].image?.attachmentUrl))
        }
        
        cell.imgStory.layer.cornerRadius = (cell.imgStory.frame.width / 2.0)
        cell.imgStory.layer.borderWidth = 5.0
        
        cell.imgStory.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
        
        cell.userName.text = data?[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: discoverCollectionView.width / 4.5 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushCallback?(indexPath.row)
        print("Name ",storyUser[indexPath.item])
    }
    
}
