//
//  SelectOptionViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 13/01/21.
//

import UIKit

protocol TappedDoneStepOne {
  
  func tapDone(_ signUpStepOneDataModel: SignUpStepOneDataModel) -> Void
  
}

protocol TappedDoneStepTwo {
  
  func tapDone(_ signUpStepTwoDataModel: SignUpStepTwoDataModel) -> Void
}

class SelectProductViewC: AlysieBaseViewC {

  //MARK:  - Outlet -
    
  @IBOutlet weak var tblViewSelectProduct: UITableView!
  @IBOutlet weak var viewNavigation: UIView!
  @IBOutlet weak var lblNavigation: UILabel!
  //MARK:  - Properties -
  
  var signUpStepOneDataModel: SignUpStepOneDataModel!
  var signUpStepTwoDataModel: SignUpStepTwoDataModel!
  var stepOneDelegate: TappedDoneStepOne?
  var stepTwoDelegate: TappedDoneStepTwo?
   
  //MARK:  - ViewLifeCycle Methods -
    
   override func viewDidLoad() {
    super.viewDidLoad()
//    if self.signUpStepOneDataModel != nil{
//      self.lblNavigation.text = AppConstants.Select.capitalized + " " + String.getString(self.signUpStepOneDataModel.title)
//    }
//    else{
//      self.lblNavigation.text = AppConstants.Select.capitalized + " " + String.getString(self.signUpStepTwoDataModel.title)
//    }
    
    if self.signUpStepOneDataModel != nil{
        
        if self.signUpStepOneDataModel.title == AppConstants.Producttype{
            self.lblNavigation.text = String.getString(self.signUpStepOneDataModel.placeholder)
        }else{
            self.lblNavigation.text = AppConstants.Select.capitalized + " " + String.getString(self.signUpStepOneDataModel.placeholder)
        }
      
    }
    else{
        if self.signUpStepTwoDataModel.title == AppConstants.Producttype{
            self.lblNavigation.text = String.getString(self.signUpStepTwoDataModel.placeholder)
        }else{
      self.lblNavigation.text = AppConstants.Select.capitalized + " " + String.getString(self.signUpStepTwoDataModel.placeholder)
        }
    }
   
   }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK:  - IBAction -
  
  @IBAction func tapDone(_ sender: UIButton) {
    
    if self.signUpStepOneDataModel != nil{
      self.validationForMultiSelection()
    }
    else{
      self.stepTwoDelegate?.tapDone(self.signUpStepTwoDataModel)
    }
  }
  
  @IBAction func tapBack(_ sender: UIButton) {
    //kSharedInstance.signUpStepOneDataModel = nil
    self.navigationController?.popViewController(animated: true)
  }
  
  //MARK:  - Private Methods -
  
  private func validationForMultiSelection() -> Void{
    
    let filteredSelectedProduct = self.signUpStepOneDataModel.arrOptions.map({$0}).filter({$0.isSelected == true})

    for index in 0..<filteredSelectedProduct.count {
      
      let sections = filteredSelectedProduct[index].arrSubSections
      
      for sectionIndex in 0..<sections.count {
        
       // if sections[sectionIndex].arrSelectedSubOptions.isEmpty == true{
            if sections[sectionIndex].arrSelectedSubOptions == [""] {
           showAlert(withMessage: "You have to select atleast one conservation method and properties for all the selected Products.")
        }
      }
    }
    print("All Selected")
    self.stepOneDelegate?.tapDone(self.signUpStepOneDataModel)
  }

   private func getSelectProductTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let selectProductTableCell = tblViewSelectProduct.dequeueReusableCell(withIdentifier: SelectProductTableCell.identifier(), for: indexPath) as! SelectProductTableCell
    selectProductTableCell.delegate = self
    if self.signUpStepOneDataModel != nil{
      selectProductTableCell.configure(withSignUpOptionsDataModel: self.signUpStepOneDataModel.arrOptions[indexPath.row])
    }
    else{
      selectProductTableCell.configureStepTwo(withSignUpStepTwoOptionsModel: self.signUpStepTwoDataModel.arrOptions[indexPath.row])
    }
    return selectProductTableCell
   }
}

//MARK:  - TableView Methods -

extension SelectProductViewC: UITableViewDataSource, UITableViewDelegate{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
      if self.signUpStepOneDataModel != nil{
        return self.signUpStepOneDataModel?.arrOptions.count ?? 0
      }
      else{
        return self.signUpStepTwoDataModel?.arrOptions.count ?? 0
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.getSelectProductTableCell(indexPath)
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
      if signUpStepOneDataModel != nil{
        
        let model = self.signUpStepOneDataModel.arrOptions[indexPath.row]
        
        switch self.signUpStepOneDataModel.type{
        case AppConstants.Checkbox:
          if model.isSelected == true{
            
            let arrSections = self.signUpStepOneDataModel.arrOptions[indexPath.section].arrSubSections
            var totalRowCount: [Int] = []

            for index in 0...arrSections.count - 1{
               
              totalRowCount.append(self.signUpStepOneDataModel.arrOptions[indexPath.row].arrSubSections[index].arrSubOptions.count)
            }
            return CGFloat(65*totalRowCount.reduce(0, +)) + CGFloat(40*arrSections.count) + 65.0
          }
          else{
            return 65.0
          }
        case AppConstants.Multiselect:
          return 65.0
        default:
          return 0.0
        }
      }
      else{
        return 65.0
      }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      
      if self.signUpStepOneDataModel != nil{
        
        let model = self.signUpStepOneDataModel.arrOptions[indexPath.row]
        
        switch self.signUpStepOneDataModel.type {
        case AppConstants.Checkbox:
          if model.isSelected == false{
            model.isSelected = true
          }
          else{
            model.isSelected = false
            for index in 0..<model.arrSubSections.count {
              model.arrSubSections[index].arrSelectedSubOptions = []
            }
          }
        case AppConstants.Multiselect:
          model.isSelected = (model.isSelected == true) ? false : true
        default:
         break
        }
        
      }
      else{
        
        let model = self.signUpStepTwoDataModel.arrOptions[indexPath.row]
        model.isSelected = (model.isSelected == true) ? false : true
      }
      self.tblViewSelectProduct.reloadData()
  }
}


extension SelectProductViewC: SectionInfoTapped{
  
  func tapInfo(_ sectionModel: SignUpSubSectionModel) {
    showAlert(withMessage: String.getString(sectionModel.hint))
  }
}
