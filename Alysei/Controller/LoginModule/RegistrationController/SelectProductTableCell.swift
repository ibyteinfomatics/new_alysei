//
//  SelectOptionTableCell.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 13/01/21.
//

import UIKit

class SelectProductTableCell: UITableViewCell {

  //MARK:  - IBOutlet -
    
  @IBOutlet weak var lblSelectProduct: UILabel!
  @IBOutlet weak var imgViewSelectProduct: UIImageView!
  @IBOutlet weak var tblViewSubProducts: UITableView!
  
  //MARK:  - Properties -
  
  var signUpOptionsDataModel: SignUpOptionsDataModel!
  var signUpStepTwoOptionsModel: SignUpStepTwoOptionsModel!
  var currentSection: [Int] = []
  
  var delegate: SectionInfoTapped?
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    self.loadSectionHeader()
    self.tblViewSubProducts.delegate = self
    self.tblViewSubProducts.dataSource = self
  }
    
  //MARK: - Public Methods -
    
  public func configure(withSignUpOptionsDataModel model: SignUpOptionsDataModel){
      
    self.signUpOptionsDataModel = model
    lblSelectProduct.text = String.getString(model.optionName)
    lblSelectProduct.textColor = (model.isSelected == true) ? AppColors.blue.color : UIColor.black
    self.imgViewSelectProduct.image  = (model.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox")
    
    
    
    for index in 0..<model.arrSubSections.count {
      
      for i in 0..<model.arrSubSections[index].arrSubOptions.count{
        
        let subOptionModel = model.arrSubSections[index].arrSubOptions[i]
        
        if subOptionModel.isSelected == true{
          model.arrSubSections[index].arrSelectedSubOptions.append(String.getString(subOptionModel.userFieldOptionId))
        }
      
     }
    }
    
    self.tblViewSubProducts.reloadData()
  }
  
  public func configureStepTwo(withSignUpStepTwoOptionsModel model: SignUpStepTwoOptionsModel){
      
    self.signUpStepTwoOptionsModel = model
    lblSelectProduct.text = String.getString(model.optionName)
    lblSelectProduct.textColor = (model.isSelected == true) ? AppColors.blue.color : UIColor.black
    self.imgViewSelectProduct.image  = (model.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox")
    //self.tblViewSubProducts.reloadData()
  }
  
  public func loadSectionHeader() -> Void{
    
    let headerNib = UINib.init(nibName: "ProductSection", bundle: Bundle.main)
    self.tblViewSubProducts.register(headerNib, forHeaderFooterViewReuseIdentifier: "ProductSection")
  }
    
  //MARK:  - Private Methods -
   
  private func getSelectSubProductTableCell(_ indexPath: IndexPath) -> UITableViewCell{
     
     let selectSubProductTableCell = tblViewSubProducts.dequeueReusableCell(withIdentifier: SelectSubProductTableCell.identifier(), for: indexPath) as! SelectSubProductTableCell
    selectSubProductTableCell.configure(withSignUpOptionsDataModel: self.signUpOptionsDataModel, indexPath: indexPath)

     return selectSubProductTableCell
  }

}

//MARK:  - TableView Methods -

extension SelectProductTableCell: UITableViewDataSource, UITableViewDelegate{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return self.signUpOptionsDataModel?.arrSubSections.count ?? 0
  }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       
    return self.signUpOptionsDataModel?.arrSubSections[section].arrSubOptions.count ?? 0
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    return self.getSelectSubProductTableCell(indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
    return 65.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    let model = self.signUpOptionsDataModel.arrSubSections[indexPath.section].arrSubOptions[indexPath.row]
    
    if self.signUpOptionsDataModel.arrSubSections[indexPath.section].arrSelectedSubOptions.contains(String.getString(model.userFieldOptionId)){
      
      let index = self.signUpOptionsDataModel.arrSubSections[indexPath.section].arrSelectedSubOptions.firstIndex{ $0 == String.getString(model.userFieldOptionId)}
      self.signUpOptionsDataModel.arrSubSections[indexPath.section].arrSelectedSubOptions.remove(at: index!)
      
    }
    else{
      self.signUpOptionsDataModel.arrSubSections[indexPath.section].arrSelectedSubOptions.append(String.getString(model.userFieldOptionId))
    }
    self.tblViewSubProducts.reloadData()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let headerView = self.tblViewSubProducts.dequeueReusableHeaderFooterView(withIdentifier: "ProductSection") as! ProductSection
    headerView.delegate = self
    let model = self.signUpOptionsDataModel.arrSubSections[section]
    headerView.configureData(model)
    headerView.backgroundColor = UIColor.white
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50.0
  }
}


extension SelectProductTableCell: SectionInfoTapped{
  
  func tapInfo(_ sectionModel: SignUpSubSectionModel) {
    
    self.delegate?.tapInfo(sectionModel)
  }
}
