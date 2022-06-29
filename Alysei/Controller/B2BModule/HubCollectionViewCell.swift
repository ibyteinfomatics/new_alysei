//
//  HubCollectionViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/25/21.
//

import UIKit

class HubCollectionViewCell: UICollectionViewCell {
    
    //var titleArray = ["Italian Restaurants in US","Importers & Distributors","Travel Agencies","Voice of Experts","Italian F&B Producers"]
    
    @IBOutlet weak var coverImage: ImageLoader!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lblUserCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configData(_ index: Int, _ data: UserRoleCount){
        title.text = data.name
        coverImage.layer.cornerRadius = self.coverImage.frame.width / 2
        lblUserCount.text = "\(data.userCount ?? 0)"
        let image = "\(data.attachment?.baseUrl ?? "")" + "\(data.attachment?.attachmentURL ?? "")"
        if let strUrl = image.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let imgUrl = URL(string: strUrl) {
             print("ImageUrl-----------------------------------------\(imgUrl)")
         //   coverImage.contentMode = .scaleAspectFill
            self.coverImage.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
        }
    }
}
