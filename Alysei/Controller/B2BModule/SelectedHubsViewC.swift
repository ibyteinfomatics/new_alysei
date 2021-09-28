//
//  SelectedHubsViewC.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class SelectedHubsViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewSelectedHubs: UICollectionView!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - Private Methods -
  
  private func getSelectedHubsCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let selectedHubsCollectionCell = collectionViewSelectedHubs.dequeueReusableCell(withReuseIdentifier: SelectedHubsCollectionCell.identifier(), for: indexPath) as! SelectedHubsCollectionCell
    return selectedHubsCollectionCell
  }
    
}

//MARK: - CollectionView Methods -

extension SelectedHubsViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 12
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getSelectedHubsCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
   // _ = pushViewController(withName: HubsViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (kScreenWidth - 75.0)/3
    return CGSize(width: width, height: width + 32.0)
  }
    
}
