//
//  MemberWalkthroughCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 02/02/21.
//

import UIKit

protocol NextButtonDelegate {
  
  func tapNext(_ cell: MemberWalkthroughCollectionCell,currentModel: GetWalkThroughDataModel,btn: UIButton) -> Void
}

class MemberWalkthroughCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewBackground: ImageLoader!
  @IBOutlet weak var lblDescription: UILabel!
  @IBOutlet weak var btnNext: UIButtonExtended!
  @IBOutlet weak var paging: UIPageControl!
  @IBOutlet weak var btnSkip: UIButton!
  @IBOutlet weak var lblTitle: UILabel!
  
  //MARK: - Properties -
  
  var delegate: NextButtonDelegate?
  var getWalkThroughDataModel: GetWalkThroughDataModel!
  
  override func awakeFromNib() {
    
    
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapNext(_ sender: UIButton) {
    
    self.delegate?.tapNext(self, currentModel: self.getWalkThroughDataModel, btn: self.btnNext)
  }
  
  @IBAction func tapSkip(_ sender: UIButton) {
    
    self.delegate?.tapNext(self, currentModel: self.getWalkThroughDataModel, btn: self.btnSkip)
  }
  
  //MARK: - Public Methods -
  
  public func configureData(withGetWalkThroughDataModel model: GetWalkThroughDataModel?,indexPath: IndexPath, viewModel: GetWalkThroughViewModel?) -> Void{
   
    self.getWalkThroughDataModel = model
    if let strUrl = "\(kImageBaseUrl)\(model?.imageId ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
          let imgUrl = URL(string: strUrl) {
         print("ImageUrl-----------------------------------------\(imgUrl)")
        self.imgViewBackground.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
    }
    self.lblTitle.text = model?.title
    self.lblDescription.text = model?.walkthroughDescription
    //self.paging.numberOfPages = 1
    self.paging.currentPage = indexPath.item
  }
}



