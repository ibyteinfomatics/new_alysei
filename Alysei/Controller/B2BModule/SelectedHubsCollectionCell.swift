//
//  SelectedHubsCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class SelectedHubsCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewHubs: UIImageViewExtended!
  @IBOutlet weak var lblHubHeading: UILabel!
  @IBOutlet weak var lblHubSubHeading: UILabel!
    
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layoutIfNeeded()
  }
  
  override func layoutIfNeeded() {
    
    super.layoutIfNeeded()
    imgViewHubs.layer.cornerRadius = self.imgViewHubs.frame.height / 2
    imgViewHubs.layer.masksToBounds = true
    
  }
  
     func configData(_ data: NewFeedSearchDataModel){
        lblHubHeading.text = data.title
        lblHubSubHeading.text = (data.state?.name ?? "") + ","  + (data.country?.name ?? "")
        self.imgViewHubs.setImage(withString: kImageBaseUrl + String.getString(data.image?.attachmentUrl))
    }
}
