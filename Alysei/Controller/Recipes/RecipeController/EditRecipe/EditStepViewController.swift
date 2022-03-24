//
//  EditStepViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

var arrayselectedIngridientId : [Int]? = []
class EditStepViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
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
    @IBOutlet weak var headerLabel: UILabel!
    
    
    var newSearchModel: [AddIngridientDataModel]? = []
    var newSearchModel1: [AddToolsDataModel]? = []
    var page = Int()
    var pageEdit = Int()
    var selectedIndex: Int = 1000
    var arrSelectedIndex = [IndexPath]()
    var arrSelectedIndex1 = [IndexPath]()
    var stepTitle : String?
    var stepNumber : String?
    var stepDescription: String?
    
    var selectedIngridientArray = [UsedIngridientDataModel]()
    var selectedToolArray = [UsedToolsDataModel]()
//    var arrayIngridients = [UsedIngridientDataModel(with: [:])]
//    var arraytools = [UsedToolsDataModel(with: [:])]
//

    override func viewDidAppear(_ animated: Bool) {
        if isFromStep == "Add Step"{
            page = (editstepsModel.count) + 1
//            let cellIng = self.ingridientUsedCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! EditStepIngridientCollectionViewCell
//            let cellTool = self.toolsUsedCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! EditStepToolsCollectionViewCell
            for i in 0..<(editusedIngridientModel.count){
                editusedIngridientModel[i].isSelected = 0
//                cellIng.addStepIngeidientSelectedImageView.isHidden = true
            }
            for i in 0..<(editusedToolModel.count){
                editusedToolModel[i].isSelected = 0
//                cellTool.addStepToolSelectedImageView.isHidden = true
            }
            ingridientUsedCollectionView.reloadData()
            toolsUsedCollectionView.reloadData()
        }
        else{
          page = pageEdit
            if editstepsModel.count > selectedIndex  && selectedIndex != 1000 {
                let cell = self.addStepsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! EditStepCollectionViewCell

                let dataModel = editstepsModel[selectedIndex]
                cell.titleTextField.text = dataModel.title
                cell.desciptionTextView.text = dataModel.description

                editusedIngridientModel = dataModel.stepIngridient ?? []
                editusedToolModel =  dataModel.stepTool ?? []
                
                ingridientUsedCollectionView.reloadData()
                toolsUsedCollectionView.reloadData()
            }
        }
        step1IngridientLabel.text = "\(page)"
        step1ToolLabel.text = "\(page)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = RecipeConstants.kAddStepsRecipe
        ingridientUsedLabel.text = RecipeConstants.kIngridientUsed
        toolsUsedLabel.text = RecipeConstants.kToolUsed
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

        self.hideKeyboardWhenTappedAround()
        if isFromStep == "Add Step"{
            page = (editstepsModel.count) + 1
            
        }
        else{
            page = pageEdit

       }
        
        step1IngridientLabel.text = "\(page)"
        step1ToolLabel.text = "\(page)"
       
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        headerView.drawBottomShadow()
    }

    @IBAction func NextButton(_ sender: Any) {
        let cell = self.addStepsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! EditStepCollectionViewCell
        if cell.titleTextField.text?.isEmpty == true{
            showAlert(withMessage: AlertMessage.kEnterTitle)
            return
        }
        else if cell.desciptionTextView.text.trimWhiteSpace() == "" ||  cell.desciptionTextView.text.trimWhiteSpace() == RecipeConstants.kRecipeDirection {
            showAlert(withMessage: AlertMessage.kEnterDescription)
            return
        }
        else if cell.desciptionTextView.text.trimWhiteSpace() == "" ||  cell.desciptionTextView.text.trimWhiteSpace() == RecipeConstants.kRecipeDirection {
            showAlert(withMessage: AlertMessage.kEnterDescription)
            return
        }
        else if cell.desciptionTextView.text.trimWhiteSpace() == "" ||  cell.desciptionTextView.text.trimWhiteSpace() == RecipeConstants.kRecipeDirection {
            showAlert(withMessage: AlertMessage.kEnterDescription)
            return
        }
        else{
            let stepdata = StepsDataModel(with: [:])
            stepdata.title = cell.titleTextField.text ?? ""
            stepdata.description = cell.desciptionTextView.text ?? ""
            stepdata.stepIngridient = editusedIngridientModel
            stepdata.stepTool = editusedToolModel
            
            if selectedIndex == 1000 {
                editstepsModel.append(stepdata)
            } else {
                editstepsModel[selectedIndex] = stepdata
            }
            
        self.navigationController?.popViewController(animated: true)
    }
}
    
    @IBAction func cancelButton(_ sender: UIButton) {
        if isFromStep == "Edit Step"{
            
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditStepViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == addStepsCollectionView{
            return 1
        }
        else if collectionView == ingridientUsedCollectionView{
//            if isFromStep == "Edit Step"{
                return editusedIngridientModel.count
//            }
//            else{
//                return selectedIngridientArray.count
//            }
        }
        else if collectionView == toolsUsedCollectionView{
//            if isFromStep == "Edit Step"{
            return editusedToolModel.count
//            }
//            else{
//                return selectedToolArray.count
//            }
        }
        else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = addStepsCollectionView.dequeueReusableCell(withReuseIdentifier: "EditStepCollectionViewCell", for: indexPath) as! EditStepCollectionViewCell
        
        if collectionView == addStepsCollectionView{
            
            cell.descriptionView.layer.borderWidth = 1
            cell.descriptionView.layer.cornerRadius = 5
            cell.descriptionView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor

            cell.titleView.layer.borderWidth = 1
            cell.titleView.layer.cornerRadius = 5
            cell.titleView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            
           
            stepNumber = RecipeConstants.kStep + "\(page)"
//            cell.titleTextField.placeholder = "Enter Title for Step \(page)"
            let str = NSAttributedString(string: RecipeConstants.kEnterTitleStep + " " + "\(page)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            cell.titleTextField.attributedPlaceholder = str
//            cell.desciptionTextView.text = "Your recipe direction text here..."
            cell.step1Label.text = stepNumber
            return cell
            
        }else if collectionView == ingridientUsedCollectionView{
            
            let cell1 = ingridientUsedCollectionView.dequeueReusableCell(withReuseIdentifier: "EditStepIngridientCollectionViewCell", for: indexPath) as! EditStepIngridientCollectionViewCell
            
            let imgUrl = ((editusedIngridientModel[indexPath.row].ingridient?.imageId?.baseUrl ?? "") + (editusedIngridientModel[indexPath.row].ingridient?.imageId?.imgUrl ?? ""))
            cell1.addStepIngridientImageView.setImage(withString: imgUrl)
            cell1.addStepIngridientNameLabel.text = editusedIngridientModel[indexPath.row].ingridient?.ingridientTitle
            cell1.addStepIngridientQuantityLabel.text = (editusedIngridientModel[indexPath.row].quantity ?? "") + " " + (editusedIngridientModel[indexPath.row].unit ?? "")
            
            
            if isFromStep == "Edit Step"{
                

                if editusedIngridientModel[indexPath.row].isSelected == 1 {
                    cell1.addStepIngeidientSelectedImageView.isHidden = false
                }
                else {
                    cell1.addStepIngeidientSelectedImageView.isHidden = true
                }
            }
            else{

                cell1.addStepIngeidientSelectedImageView.isHidden = true
            }
        
            cell1.layoutSubviews()

            return cell1
            
        }
        else if collectionView == toolsUsedCollectionView {
            
            let cell2 = toolsUsedCollectionView.dequeueReusableCell(withReuseIdentifier: "EditStepToolsCollectionViewCell", for: indexPath) as! EditStepToolsCollectionViewCell
            let imgUrl = ((editusedToolModel[indexPath.row].tool?.imageId?.baseUrl ?? "") + (editusedToolModel[indexPath.row].tool?.imageId?.imgUrl ?? ""))
            cell2.addStepToolImageView.setImage(withString: imgUrl)
            cell2.addStepToolNameLabel.text = editusedToolModel[indexPath.row].tool?.toolTitle
            
           
            if isFromStep == "Edit Step"{
                if editusedToolModel[indexPath.row].isSelected == 1 {
                    cell2.addStepToolSelectedImageView.isHidden = false
                   
                } else {
                    cell2.addStepToolSelectedImageView.isHidden = true
                    
                }
            }
            else{
               
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
        let cell = ingridientUsedCollectionView.cellForItem(at: indexPath as IndexPath) as? EditStepIngridientCollectionViewCell
        let cell1 = toolsUsedCollectionView.cellForItem(at: indexPath as IndexPath) as? EditStepToolsCollectionViewCell
        
        if collectionView == ingridientUsedCollectionView {
            
            if  editusedIngridientModel[indexPath.row].isSelected == 1 {
                editusedIngridientModel[indexPath.row].isSelected = 0
                
                cell?.addStepIngeidientSelectedImageView.isHidden = true
//                selectedIngridientArray.remove(at: indexPath.row)
            } else {
                editusedIngridientModel[indexPath.row].isSelected = 1
                
                cell?.addStepIngeidientSelectedImageView.isHidden = false
//                let selectIngridientId = editusedIngridientModel[indexPath.row].ingridientId ?? 0
//                arrayselectedIngridientId?.append(selectIngridientId)
//                selectedIngridientArray.append(editusedIngridientModel[indexPath.row])
            }
        }
        else if collectionView == toolsUsedCollectionView {
            
            if  editusedToolModel[indexPath.row].isSelected == 1 {
                editusedToolModel[indexPath.row].isSelected = 0
                cell1?.addStepToolSelectedImageView.isHidden = true
            } else {
                editusedToolModel[indexPath.row].isSelected = 1
                cell1?.addStepToolSelectedImageView.isHidden = false
//              nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if collectionView == addStepsCollectionView {
            return CGSize(width: self.addStepsCollectionView.frame.width, height: 270.0)
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
