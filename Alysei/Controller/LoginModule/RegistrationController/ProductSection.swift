//
//  ProductSection.swift
//  Alysie
//
//  Created by CodeAegis on 01/02/21.
//

import UIKit

protocol SectionInfoTapped {
  
  func tapInfo(_ sectionModel: SignUpSubSectionModel) -> Void
}

class ProductSection: UITableViewHeaderFooterView {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblSectionName: UILabel!
  @IBOutlet weak var btnInfo: UIButton!
  
  //MARK: - Properties -
  
  var delegate: SectionInfoTapped?
  var currentSectionModel: SignUpSubSectionModel!
  
  //MARK: - IBAction -
  
  @IBAction func tapInfo(_ sender: UIButton) {
    
    self.delegate?.tapInfo(currentSectionModel)
  }
  
  //MARK: - Public Methods -

  public func configureData(_ sectionModel: SignUpSubSectionModel) -> Void{
    
    self.currentSectionModel = sectionModel
    self.lblSectionName.text = sectionModel.sectionName
    self.btnInfo.isHidden = (sectionModel.hint?.isEmpty == true) ? true : false
  }
}
