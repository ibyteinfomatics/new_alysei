//
//  SelectedHubsTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 27/01/21.
//

import UIKit

protocol TappedHubs {
  
    func tapOnHub(_ hubId:String?,_ hubName: String?,_ hubLocation: String?) -> Void
}

class SelectedHubsTableCell: UITableViewCell {
  
  @IBOutlet weak var collectionViewSelectedHubs: UICollectionView!
  
  var delegate: TappedHubs?
    var arrSearchData : [NewFeedSearchDataModel]?
  override func awakeFromNib() {
    
    super.awakeFromNib()
    collectionViewSelectedHubs.delegate = self
    collectionViewSelectedHubs.dataSource = self
  }
  
  public func getSelectedHubsCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let selectedHubsCollectionCell = collectionViewSelectedHubs.dequeueReusableCell(withReuseIdentifier: SelectedHubsCollectionCell.identifier(), for: indexPath) as! SelectedHubsCollectionCell
    selectedHubsCollectionCell.configData(arrSearchData?[indexPath.row] ?? NewFeedSearchDataModel(with: [:]))
    return selectedHubsCollectionCell
  }
    
     func configData(_ arrData: [NewFeedSearchDataModel]){
        self.arrSearchData = arrData
        
    }
}


//MARK: - CollectionView Methods -

extension SelectedHubsTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return arrSearchData?.count ?? 0
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getSelectedHubsCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {

    self.delegate?.tapOnHub("\(arrSearchData?[indexPath.row].id ?? 0)",arrSearchData?[indexPath.row].title, ((arrSearchData?[indexPath.row].state?.name ?? "") + "," + (arrSearchData?[indexPath.row].country?.name ?? "")))
    //_ = pushViewController(withName: HubsViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (kScreenWidth - 70.0)/3
    //return CGSize(width: width, height: width + 48.0)
    return CGSize(width: width, height: 168)
  }
    
}
