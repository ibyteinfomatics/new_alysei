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
  
  @IBOutlet weak var imgViewBackground: CustomImageView!
  @IBOutlet weak var lblDescription: UILabel!
  @IBOutlet weak var btnNext: UIButtonExtended!
  @IBOutlet weak var paging: UIPageControl!
  @IBOutlet weak var btnSkip: UIButton!
  @IBOutlet weak var lblTitle: UILabel!
  
  //MARK: - Properties -
  
  var delegate: NextButtonDelegate?
  var getWalkThroughDataModel: GetWalkThroughDataModel!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
      btnSkip.setTitle(LogInSignUp.kskip, for: .normal)
      btnNext.setTitle(RecipeConstants.kNext, for: .normal)
  }
    override func prepareForReuse() {
        super.prepareForReuse()
        imgViewBackground.image = UIImage(named: "image_placeholder")
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
      if let strUrl = "\(model?.attachment?.baseUrl ?? "")\(model?.attachment?.attachmenThumbnailUrl ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
          let imgUrl = URL(string: strUrl) {
         print("ImageUrltrex-----------------------------------------\(imgUrl)")
        //self.imgViewBackground.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
          self.imgViewBackground.loadCacheImage(urlString: strUrl)
    }
    self.lblTitle.text = model?.title
    self.lblDescription.text = model?.walkthroughDescription
    //self.paging.numberOfPages = 1
   // self.paging.currentPage = indexPath.item
    
  }
}



