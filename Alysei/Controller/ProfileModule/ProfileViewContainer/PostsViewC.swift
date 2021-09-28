//
//  PostsViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit

class PostsViewC: AlysieBaseViewC{
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewPosts: UICollectionView!
    var role: String?
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  private func getPostsCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let postsCollectionCell = collectionViewPosts.dequeueReusableCell(withReuseIdentifier: PostsCollectionCell.identifier(), for: indexPath) as! PostsCollectionCell
    return postsCollectionCell
  }
    
}

//MARK: - CollectionView Methods -

extension PostsViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 20
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      return self.getPostsCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (kScreenWidth - 6)/3
    return CGSize(width: width, height: width)
  }
    
}
