//
//  AddStepsViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 30/07/21.
//

import UIKit

var allStepViewControllerArray: [AddStepsViewController] = []
var stepData: [String:Any] = [:]

var arrayStepFinalData:[stepDataModel] = []
class AddStepsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addStepLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollVw: UIScrollView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var addStepsCollectionView: UICollectionView!
    @IBOutlet weak var ingridientUsedLabel: UILabel!
    @IBOutlet weak var ingridientUsedCollectionView: UICollectionView!
    @IBOutlet weak var toolsUsedLabel: UILabel!
    @IBOutlet weak var toolsUsedCollectionView: UICollectionView!
    @IBOutlet weak var step1IngridientLabel: UILabel!
    @IBOutlet weak var step1ToolLabel: UILabel!
    
    var newSearchModel: [AddIngridientDataModel]? = []
    var newSearchModel1: [AddToolsDataModel]? = []
    var page = 1
    var selectedIndex: Int = 1000
    var arrSelectedIndex = [IndexPath]()
    var arrSelectedIndex1 = [IndexPath]()
    var stepTitle : String?
    var stepNumber : String?
    var stepDescription: String?
    var isbackdata : Bool?
    var arrayIngridients = [IngridentArray()]
    var arraytools = [ToolsArray()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = RecipeConstants.kAddStepsRecipe
        ingridientUsedLabel.text = RecipeConstants.kIngridientUsed
        toolsUsedLabel.text = RecipeConstants.kToolUsed
        addStepLbl.text = RecipeConstants.kAddStep
        nextButton.setTitle(RecipeConstants.kNext, for: .normal)
        
        addStepsCollectionView.delegate = self
        addStepsCollectionView.dataSource = self
        
        ingridientUsedCollectionView.delegate = self
        ingridientUsedCollectionView.dataSource = self
        ingridientUsedCollectionView.reloadData()
        
        toolsUsedCollectionView.delegate = self
        toolsUsedCollectionView.dataSource = self
        toolsUsedCollectionView.reloadData()
        
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 24
        nextButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        setStepTitle()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if arrayStepFinalData.count > selectedIndex  && selectedIndex != 1000 {
            let cell = self.addStepsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! AddStepsCollectionViewCell
            let dataModel = arrayStepFinalData[selectedIndex]
            cell.titleTextField.text = dataModel.title
            cell.desciptionTextView.text = dataModel.description
            arrayIngridients = dataModel.ingridentsArray ?? []
            arraytools =  dataModel.toolsArray ?? []
            
            if cell.desciptionTextView.text != RecipeConstants.kRecipeDirection {
                cell.desciptionTextView.textColor = UIColor.black
            }
            else{
                cell.desciptionTextView.textColor = UIColor.lightGray
            }
            ingridientUsedCollectionView.reloadData()
            toolsUsedCollectionView.reloadData()
            
         }

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        headerView.drawBottomShadow()
    }
    func setStepTitle(){
        step1IngridientLabel.text = "\(page)"
        step1ToolLabel.text = "\(page)"
        
    }
//    override func viewDidLayoutSubviews() {
//        self.scrollVw.contentSize = CGSize(width: self.view.frame.size.width, height: 800)
//    }
    
    @IBAction func NextButton(_ sender: Any) {
        
        let cell = self.addStepsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! AddStepsCollectionViewCell
        if cell.titleTextField.text?.isEmpty == true{
            showAlert(withMessage: AlertMessage.kEnterTitle)
            return
        }
        else if cell.desciptionTextView.text.trimWhiteSpace() == "" ||  cell.desciptionTextView.text.trimWhiteSpace() == RecipeConstants.kRecipeDirection {
            showAlert(withMessage: AlertMessage.kEnterDescription)
            return
        }
        
        else{
            let stepdata = stepDataModel()
            stepdata.title = cell.titleTextField.text ?? ""
            stepdata.description = cell.desciptionTextView.text ?? ""
            stepdata.ingridentsArray = arrayIngridients
            stepdata.toolsArray = arraytools
            
            if selectedIndex == 1000 {
                arrayStepFinalData.append(stepdata)
            } else {
                arrayStepFinalData[selectedIndex] = stepdata
            }
            
            let recipeIngredients = self.storyboard?.instantiateViewController(withIdentifier: "RecipeIngredientsUseViewController") as! RecipeIngredientsUseViewController
            self.navigationController?.pushViewController(recipeIngredients, animated: true)
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        var isBack = false
       
       if selectedIndex > 0 && selectedIndex != 1000{
            let addSteps = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
            addSteps.page = (page - 1)
            addSteps.selectedIndex = (page - 2)
            self.navigationController?.pushViewController(addSteps, animated: true)
        }

        else {
            if selectedIndex != 1000 {
                
                if let destinationViewController = navigationController?.viewControllers
                    .filter(
                        {$0 is RecipeIngredientsUseViewController})
                    .first {
                    isBack = true
                    navigationController?.popToViewController(destinationViewController, animated: true)
                }
                if isBack == false{
                    if let destinationViewController = navigationController?.viewControllers
                        .filter(
                            {$0 is AddToolsViewController})
                        .first {
                        
                        navigationController?.popToViewController(destinationViewController, animated: true)
                    }
                }
                
            }
            else
            {
                if isbackdata == true{
                    let addSteps = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
                    addSteps.page = (page - 1)
                    addSteps.selectedIndex = (page - 2)
                    self.navigationController?.pushViewController(addSteps, animated: true)
                }
                else{
                self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        let cancelPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "CancelPopUpViewController") as! CancelPopUpViewController
        
        cancelPopUpVC.modalPresentationStyle = .overFullScreen
        cancelPopUpVC.modalTransitionStyle = .crossDissolve
        cancelPopUpVC.Callback = {
            let cancelPopVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
            cancelPopVC.checkbutton = 2
            cancelPopVC.currentIndex = 2
            self.navigationController?.pushViewController(cancelPopVC, animated: true)
            
        }
        self.present(cancelPopUpVC, animated: true)
        
    }
    @IBAction func tapForAddNewStep(_ sender: Any) {
        
        let addSteps = self.storyboard?.instantiateViewController(withIdentifier: "AddStepsViewController") as! AddStepsViewController
        
        let cell = self.addStepsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! AddStepsCollectionViewCell
        
        if cell.titleTextField.text?.isEmpty == true{
            
            showAlert(withMessage: AlertMessage.kEnterTitle)
            
            return
            
        }
        
        else if cell.desciptionTextView.text.trimWhiteSpace() == "" ||  cell.desciptionTextView.text.trimWhiteSpace() == RecipeConstants.kRecipeDirection {
            
            showAlert(withMessage: AlertMessage.kEnterDescription)
            
            return
            
        }
        
        else{
          
            
            if (page + 1) > arrayStepFinalData.count {
                
                var ingridentsArray : [IngridentArray] = []
                
                for item in selectedIngridentsArray{
                    
                    let ingridients: IngridentArray = IngridentArray.init()
                    
                    ingridients.recipeIngredientIds = item.recipeIngredientIds
                    
                    ingridients.ingridientTitle = item.ingridientTitle
                    
                    ingridients.imageId = item.imageId
                    
                    ingridients.parent = item.parent
                    
                    ingridients.pickerData = item.pickerData
                    
                    ingridients.quantity = item.quantity
                    
                    ingridients.unit = item.unit
                    
                    ingridients.createdAt = item.createdAt
                    
                    ingridients.updatedAt = item.updatedAt
                    
                    ingridients.isSelected = false
                    
                    ingridentsArray.append(ingridients)
                    
                }
                
                
                
                var toolsArray : [ToolsArray] = []
                
                for item in selectedToolsArray{
                    
                    let tools: ToolsArray = ToolsArray.init()
                    
                    tools.recipeToolIds = item.recipeToolIds
                    
                    tools.toolTitle = item.toolTitle
                    
                    tools.imageId = item.imageId
                    
                    tools.parent = item.parent
                    
                    tools.pickerData = item.pickerData
                    
                    tools.quantity = item.quantity
                    
                    tools.unit = item.unit
                    
                    tools.isSelected = false
                    
                    toolsArray.append(tools)
                    
                }
                
                addSteps.arrayIngridients = ingridentsArray
                
                addSteps.arraytools = toolsArray
                
                addSteps.page = page + 1
                
                let stepdata = stepDataModel()
                
                stepdata.title = cell.titleTextField.text ?? ""
                
                stepdata.description = cell.desciptionTextView.text ?? ""
                
                stepdata.ingridentsArray = arrayIngridients
                
                stepdata.toolsArray = arraytools
                
                
                
                if selectedIndex == 1000 {
                   
                    arrayStepFinalData.append(stepdata)
                    addSteps.isbackdata = true

                } else {
                    addSteps.isbackdata = true
                    arrayStepFinalData[selectedIndex] = stepdata

                }
                
            }
            else {

                addSteps.page = page + 1

                addSteps.selectedIndex = page

            }
            
            self.navigationController?.pushViewController(addSteps, animated: true)
            
        }
        
    }
    
}

extension AddStepsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == addStepsCollectionView{
            return 1
        }
        else if collectionView == ingridientUsedCollectionView{
            return arrayIngridients.count
        }
        else if collectionView == toolsUsedCollectionView{
            return arraytools.count
        }
        else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = addStepsCollectionView.dequeueReusableCell(withReuseIdentifier: "AddStepsCollectionViewCell", for: indexPath) as! AddStepsCollectionViewCell
        
        if collectionView == addStepsCollectionView{
            
            cell.descriptionView.layer.borderWidth = 1
            cell.descriptionView.layer.cornerRadius = 5
            cell.descriptionView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            
            cell.titleView.layer.borderWidth = 1
            cell.titleView.layer.cornerRadius = 5
            cell.titleView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            
            
            stepNumber = RecipeConstants.kStep + "" + "\(page)"
//            cell.titleTextField.placeholder = "Enter Title for Step \(page)"
            let str = NSAttributedString(string: RecipeConstants.kEnterTitleStep + "" + "\(page)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            cell.titleTextField.attributedPlaceholder = str
            //            cell.desciptionTextView.text = "Your recipe direction text here..."
            cell.step1Label.text = stepNumber
            return cell
            
        }else if collectionView == ingridientUsedCollectionView{
            
            let cell1 = ingridientUsedCollectionView.dequeueReusableCell(withReuseIdentifier: "AddStepIngridientCollectionViewCell", for: indexPath) as! AddStepIngridientCollectionViewCell
            
            let imgUrl = ((arrayIngridients[indexPath.row].imageId?.baseUrl ?? "") + (arrayIngridients[indexPath.row].imageId?.imgUrl ?? ""))
            cell1.addStepIngridientImageView.setImage(withString: imgUrl)
            cell1.addStepIngridientNameLabel.text = arrayIngridients[indexPath.row].ingridientTitle
            cell1.addStepIngridientQuantityLabel.text = arrayIngridients[indexPath.row].pickerData ?? ""
//            cell1.addStepIngridientNameLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
            if  arrayIngridients[indexPath.row].isSelected == true {
                cell1.addStepIngeidientSelectedImageView.isHidden = false
            } else {
                cell1.addStepIngeidientSelectedImageView.isHidden = true
                
            }
            cell1.layoutSubviews()
            
            return cell1
        } else if collectionView == toolsUsedCollectionView {
            
            let cell2 = toolsUsedCollectionView.dequeueReusableCell(withReuseIdentifier: "AddStepToolCollectionViewCell", for: indexPath) as! AddStepToolCollectionViewCell
            let imgUrl = ((arraytools[indexPath.row].imageId?.baseUrl ?? "") + (arraytools[indexPath.row].imageId?.imgUrl ?? ""))
            cell2.addStepToolImageView.setImage(withString: imgUrl)
            cell2.addStepToolNameLabel.text = arraytools[indexPath.row].toolTitle
            
//            cell2.addStepToolNameLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
            
            if  arraytools[indexPath.row].isSelected == true {
                cell2.addStepToolSelectedImageView.isHidden = false
            } else {
                cell2.addStepToolSelectedImageView.isHidden = true
                
            }
            cell2.layoutSubviews()
            return cell2
        }
        
        else{
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = ingridientUsedCollectionView.cellForItem(at: indexPath as IndexPath) as? AddStepIngridientCollectionViewCell
        let cell1 = toolsUsedCollectionView.cellForItem(at: indexPath as IndexPath) as? AddStepToolCollectionViewCell
        
        if collectionView == ingridientUsedCollectionView {
            
            if  arrayIngridients[indexPath.row].isSelected == true {
                arrayIngridients[indexPath.row].isSelected = false
                cell?.addStepIngeidientSelectedImageView.isHidden = true
            } else {
                arrayIngridients[indexPath.row].isSelected = true
                cell?.addStepIngeidientSelectedImageView.isHidden = false
                //                nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            }
        }
        if collectionView == toolsUsedCollectionView {
            
            if  arraytools[indexPath.row].isSelected == true {
                arraytools[indexPath.row].isSelected = false
                cell1?.addStepToolSelectedImageView.isHidden = true
            } else {
                arraytools[indexPath.row].isSelected = true
                cell1?.addStepToolSelectedImageView.isHidden = false
                //                nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if collectionView == addStepsCollectionView{
            return CGSize(width: self.addStepsCollectionView.frame.width, height: 292.0)
        }
        if collectionView == ingridientUsedCollectionView{
            return CGSize(width: self.ingridientUsedCollectionView.frame.width/5, height: 180)
        }
        if collectionView == toolsUsedCollectionView{
            return CGSize(width: self.toolsUsedCollectionView.frame.width/5, height: 150)
        }
        else{
            return CGSize.zero
        }
        
    }
    
    
}

