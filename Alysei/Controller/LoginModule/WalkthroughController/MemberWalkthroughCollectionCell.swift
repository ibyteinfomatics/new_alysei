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
  
    var prodArray = ["Prod1","Prod2","Prod3","Prod4"]
    var impArray = ["Importer1","Importer2","Importer03","Importer4"]
    var restArray = ["Restaurant1","Restaurant2","Restaurant3","Restaurant4"]
    var expertArray = ["VOE1","VOE2","VOE3","VOE4"]
    var travelArray = ["travel1","travel2","travel3","travel4"]
    var voyagerArray = ["voyager1","voyager2","voyager3","voyager4"]
    
    var loadArray : [String]?
    
  override func awakeFromNib() {
    
    super.awakeFromNib()
      btnSkip.setTitle(LogInSignUp.kskip, for: .normal)
      btnNext.setTitle(RecipeConstants.kNext, for: .normal)
      
    
  }
    
    func loadImages(){
        if getWalkThroughDataModel.roleId == "\(UserRoles.producer.rawValue)" {
            loadArray = prodArray
        }else if (getWalkThroughDataModel.roleId == "\(UserRoles.distributer1.rawValue)" ) || (getWalkThroughDataModel.roleId == "\(UserRoles.distributer2.rawValue)") || ( getWalkThroughDataModel.roleId == "\(UserRoles.distributer3.rawValue)" ) {
            loadArray = impArray
        } else if getWalkThroughDataModel.roleId == "\(UserRoles.restaurant.rawValue)" {
            loadArray = restArray
        }else if getWalkThroughDataModel.roleId == "\(UserRoles.voiceExperts.rawValue)" {
            loadArray = expertArray
        }else if getWalkThroughDataModel.roleId == "\(UserRoles.travelAgencies.rawValue)" {
            loadArray = travelArray
        }else{
            loadArray = voyagerArray
        }
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
      self.loadImages()
      self.imgViewBackground.image = UIImage(named: loadArray?[indexPath.row] ?? "image_placeholder")
//      if let strUrl = "\(model?.attachment?.baseUrl ?? "")\(model?.attachment?.attachmenThumbnailUrl ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
//          let imgUrl = URL(string: strUrl) {
//         print("ImageUrltrex-----------------------------------------\(imgUrl)")
//        //self.imgViewBackground.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
//          self.imgViewBackground.loadCacheImage(urlString: strUrl)
//    }
    self.lblTitle.text = model?.title
    self.lblDescription.text = model?.walkthroughDescription
    //self.paging.numberOfPages = 1
   // self.paging.currentPage = indexPath.item
    
  }
}



