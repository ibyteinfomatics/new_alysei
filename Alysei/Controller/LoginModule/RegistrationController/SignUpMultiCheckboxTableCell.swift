//
//  SignUpMultiCheckboxTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 08/02/21.
//

import UIKit

protocol SignUpMultiSelectDelegate {
  
  func tappedCheckBox(collectionView: UICollectionView,signUpStepTwoOptionsModel: SignUpStepTwoOptionsModel?, signUpStepTwoDataModel: SignUpStepTwoDataModel?,signUpStepOneDataModel: SignUpStepOneDataModel?, btn: UIButton, cell: SignUpMultiCheckboxTableCell) -> Void
  
  //func tappedCheckBox(collectionView: UICollectionView,indexPath: IndexPath) -> Void
}

class SignUpMultiCheckboxTableCell: UITableViewCell{
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewMultiSelect: UICollectionView!
  @IBOutlet weak var lblHeading: UILabel!
  @IBOutlet weak var btnInfo: UIButton!
  @IBOutlet weak var lblHeadingTopConst: NSLayoutConstraint!
  
  //MARK: - Properties -
  
  var stepTwoCurrentModel: SignUpStepTwoDataModel!
  var stepOneCurrentModel: SignUpStepOneDataModel!
  var delegate: SignUpMultiSelectDelegate?

  override func awakeFromNib() {
    
    super.awakeFromNib()
    self.collectionViewMultiSelect.delegate = self
    self.collectionViewMultiSelect.dataSource = self
  }
  
  //MARK: - Public Methods -
  
  public func configureData(withSignUpStepTwoDataModel model: SignUpStepTwoDataModel) -> Void{
    
    self.stepTwoCurrentModel = model
    self.btnInfo.isHidden = (model.hint?.isEmpty == true) ? true : false
    self.lblHeading.text = (model.required == AppConstants.Yes) ? String.getString(model.title) + "*" : model.title
    self.collectionViewMultiSelect.reloadData()
  }
  
  public func configureStepOneData(withSignUpStepOneDataModel model: SignUpStepOneDataModel) -> Void{
    
    self.stepOneCurrentModel = model
    self.btnInfo.isHidden = (model.hint?.isEmpty == true) ? true : false
    self.lblHeading.text = (model.required == AppConstants.Yes) ? String.getString(model.title) + "*" : model.title
    self.collectionViewMultiSelect.reloadData()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapInfo(_ sender: UIButton) {
    
    self.delegate?.tappedCheckBox(collectionView: self.collectionViewMultiSelect, signUpStepTwoOptionsModel: nil, signUpStepTwoDataModel: self.stepTwoCurrentModel, signUpStepOneDataModel: self.stepOneCurrentModel, btn: self.btnInfo, cell: self)
  }
  
  //MARK: - Private Methods -
  
  private func getSignUpMultiSelectCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let signUpMultiSelectCollectionCell = collectionViewMultiSelect.dequeueReusableCell(withReuseIdentifier: SignUpMultiSelectCollectionCell.identifier(), for: indexPath) as! SignUpMultiSelectCollectionCell
  
    let model = (stepOneCurrentModel == nil) ? stepTwoCurrentModel.arrOptions[indexPath.item] : stepOneCurrentModel.arrRestaurantOptions[indexPath.item]
        signUpMultiSelectCollectionCell.configureData(withSignUpStepTwoOptionsModel: model)
    
//    if (stepOneCurrentModel == nil){
//
//      let model = stepTwoCurrentModel.arrOptions[indexPath.item]
//      signUpMultiSelectCollectionCell.configureData(withSignUpStepTwoOptionsModel: model)
//    }
//    else{
//      let model = stepOneCurrentModel.arrRestaurantOptions[indexPath.item]
//      signUpMultiSelectCollectionCell.configureStepOneData(withSignUpOptionsDataModel: model)
//    }
    return signUpMultiSelectCollectionCell
  }
}

//MARK: - CollectionView Methods -

extension SignUpMultiCheckboxTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (stepOneCurrentModel == nil) ? self.stepTwoCurrentModel?.arrOptions.count ?? 0 : self.stepOneCurrentModel?.arrRestaurantOptions.count ?? 0
    
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getSignUpMultiSelectCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
    

    let model = (stepOneCurrentModel == nil) ? self.stepTwoCurrentModel.arrOptions[indexPath.item] : self.stepOneCurrentModel.arrRestaurantOptions[indexPath.item]
    
    if stepOneCurrentModel == nil{
      
      self.delegate?.tappedCheckBox(collectionView: collectionView, signUpStepTwoOptionsModel: model , signUpStepTwoDataModel: self.stepTwoCurrentModel, signUpStepOneDataModel: nil,btn: UIButton(), cell: self)
    }
    else{
      self.delegate?.tappedCheckBox(collectionView: collectionView, signUpStepTwoOptionsModel: model, signUpStepTwoDataModel: nil, signUpStepOneDataModel: self.stepOneCurrentModel,btn: UIButton(), cell: self)
    }


    //self.selectedIndex.append(indexPath.item)
    //self.collectionViewFilters.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: (kScreenWidth - 80.0)/2, height: 40.0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
    
    return 20.0
    
  }
}

