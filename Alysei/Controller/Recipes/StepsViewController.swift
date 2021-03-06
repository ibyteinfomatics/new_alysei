//
//  StepsViewController.swift
//  New Recipe module
//
//  Created by mac on 20/08/21.
//

import UIKit

class StepsViewController: UIViewController, StepDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextStep: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var stepImage: UIImageView!
    
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var nextBtnLeading: NSLayoutConstraint!
    
    
    var choosestepIngridient : [UsedIngridientDataModel]? = []
    var choosestepTool : [UsedToolsDataModel]? = []
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeTableViewCell")
        nextStep.layer.borderWidth = 1
        nextStep.layer.cornerRadius = 24
        nextStep.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        for i in 0..<(stepsModel?[page].stepIngridient?.count ?? 0) {
            if stepsModel?[page].stepIngridient?[i].isSelected == 1{
                choosestepIngridient?.append((stepsModel?[page].stepIngridient?[i] ?? UsedIngridientDataModel(with: [:])))
            }
            tableView.reloadData()
        }
        
        for i in 0..<(stepsModel?[page].stepTool?.count ?? 0) {
            if stepsModel?[page].stepTool?[i].isSelected == 1{
                choosestepTool?.append((stepsModel?[page].stepTool?[i] ?? UsedToolsDataModel(with: [:])))
            }
            
            tableView.reloadData()
        }
        
        stepTableViewCellCurrentIndex = page
        if page == ((stepsModel?.count ?? 0) - 1){
            nextStep.setTitle(RecipeConstants.kFinishCooking, for: .normal)
            nextStep.setImage(UIImage(named: "icons8_cooking_pot.png"), for: .normal)
            backButton.isHidden = true
            backBtnWidth.constant = 0
            
        }
        else{
            nextStep.setTitle(RecipeConstants.kNext, for: .normal)
            nextStep.setImage(UIImage(named: "icons8_left1.png"), for: .normal)
            backButton.isHidden = false
            backBtnWidth.constant = 55
        }
        
        let imgUrl = ((recipeModel?.image?.baseUrl ?? "") + (recipeModel?.image?.imgUrl ?? ""))
        stepImage.setImage(withString: imgUrl)
    }
    
    
    @IBAction func nextStepTapped(_ sender: UIButton) {
        
        if page < ((stepsModel?.count ?? 0) - 1){
            page = page + 1
            
            choosestepIngridient?.removeAll()
            choosestepTool?.removeAll()
            for i in 0..<(stepsModel?[page].stepIngridient?.count ?? 0) {
                if stepsModel?[page].stepIngridient?[i].isSelected == 1{
                    choosestepIngridient?.append((stepsModel?[page].stepIngridient?[i] ?? UsedIngridientDataModel(with: [:])))
                    tableView.reloadData()
                }
                
            }
            
            for i in 0..<(stepsModel?[page].stepTool?.count ?? 0) {
                if stepsModel?[page].stepTool?[i].isSelected == 1{
                    choosestepTool?.append((stepsModel?[page].stepTool?[i] ?? UsedToolsDataModel(with: [:])))
                    tableView.reloadData()
                }
                
            }
            
            nextStep.setTitle(RecipeConstants.kNext, for: .normal)
            nextStep.setImage(UIImage(named: "icons8_left1.png"), for: .normal)
            backButton.isHidden = false
            backBtnWidth.constant = 55
            stepTableViewCellCurrentIndex = page
            tableView.reloadData()
            
            if page == ((stepsModel?.count ?? 0) - 1){
                nextStep.setTitle(RecipeConstants.kFinishCooking, for: .normal)
                nextStep.setImage(UIImage(named: "icons8_cooking_pot.png"), for: .normal)
                backBtnWidth.constant = 0
                backButton.isHidden = true
            }
        }
        else{
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WellDoneViewController") as! WellDoneViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
    
    @IBAction func tapDownBack(_ sender: Any) {
        
        
        if page > 0{
            page = page - 1
            
            
            choosestepIngridient?.removeAll()
            choosestepTool?.removeAll()
            for i in 0..<(stepsModel?[page].stepIngridient?.count ?? 0) {
                if stepsModel?[page].stepIngridient?[i].isSelected == 1{
                    choosestepIngridient?.append((stepsModel?[page].stepIngridient?[i] ?? UsedIngridientDataModel(with: [:])))
                    tableView.reloadData()
                }
                
            }
            
            for i in 0..<(stepsModel?[page].stepTool?.count ?? 0) {
                if stepsModel?[page].stepTool?[i].isSelected == 1{
                    choosestepTool?.append((stepsModel?[page].stepTool?[i] ?? UsedToolsDataModel(with: [:])))
                    tableView.reloadData()
                }
                
            }
            
            stepTableViewCellCurrentIndex = page
            nextStep.setTitle(RecipeConstants.kNext, for: .normal)
            nextStep.setImage(UIImage(named: "icons8_left1.png"), for: .normal)
            tableView.reloadData()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func tapBacklToViewRecipe(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func cellStepTapped(index: Int){
        page = index
        
        choosestepIngridient?.removeAll()
        choosestepTool?.removeAll()
        for i in 0..<(stepsModel?[page].stepIngridient?.count ?? 0) {
            if stepsModel?[page].stepIngridient?[i].isSelected == 1{
                choosestepIngridient?.append((stepsModel?[page].stepIngridient?[i] ?? UsedIngridientDataModel(with: [:])))
                tableView.reloadData()
            }
            
        }
        
        for i in 0..<(stepsModel?[page].stepTool?.count ?? 0) {
            if stepsModel?[page].stepTool?[i].isSelected == 1{
                
                choosestepTool?.append((stepsModel?[page].stepTool?[i] ?? UsedToolsDataModel(with: [:])))
                tableView.reloadData()
            }
            
        }
        if page < ((stepsModel?.count ?? 0) - 1){
            nextStep.setTitle(RecipeConstants.kNext, for: .normal)
            nextStep.setImage(UIImage(named: "icons8_left1.png"), for: .normal)
            backButton.isHidden = false
            backBtnWidth.constant = 55
            tableView.reloadData()
        }
        else{
            
            nextStep.setTitle(RecipeConstants.kFinishCooking, for: .normal)
            nextStep.setImage(UIImage(named: "icons8_cooking_pot.png"), for: .normal)
            backButton.isHidden = true
            backBtnWidth.constant = 0
            tableView.reloadData()
        }
        
        
    }
}
extension StepsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            
            if stepsModel?.count ?? 0 > page{
                return choosestepIngridient?.count ?? 0
            }
            else{
                return 0
            }
        }
        else if section == 2{
            return 1
        }
        else if section == 3{
            if (stepsModel?.count ?? 0) > page{
                return choosestepTool?.count ?? 0
            }
            else{
                return 0
            }
            
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell:StepTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StepTableViewCell", for: indexPath) as? StepTableViewCell
            else{return UITableViewCell()}
            cell.lblDescription.text = stepsModel?[page].description
            cell.lblTitle.text = stepsModel?[page].title
            cell.stepLabel.text = RecipeConstants.kStep + " " + "\(page + 1)"
            
            cell.delegate = self
            cell.collectionView.reloadData()
            
            return cell
            
        case 1:
            guard let cell: ViewRecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            let imgUrl = ((choosestepIngridient?[indexPath.row].ingridient?.imageId?.baseUrl ?? "") + (choosestepIngridient?[indexPath.row].ingridient?.imageId?.imgUrl ?? ""))
            
            cell.ingredientImageView.setImage(withString: imgUrl)
            
            cell.ingredientNameLabel.text = choosestepIngridient?[indexPath.row].ingridient?.ingridientTitle
            
            
            cell.ingredientQuantityLabel.text = (choosestepIngridient?[indexPath.row].quantity ?? "")  + " " + (choosestepIngridient?[indexPath.row].unit ?? "")
            cell.openImageCallback = { image , index in
                
                let imgUrl =  ((self.choosestepIngridient?[indexPath.row].ingridient?.imageId?.baseUrl ?? "") + (self.choosestepIngridient?[indexPath.row].ingridient?.imageId?.imgUrl ?? ""))
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: RecipeFullImageViewController.id()) as? RecipeFullImageViewController else{return}
                vc.imageUrl = imgUrl
                self.navigationController?.pushViewController(vc, animated: false)
                //let mainImage = UIImage(named:"image_placeholder")
                
            }
            
            return cell
        case 2:
            guard let cell:ToolsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToolsTableViewCell", for: indexPath) as? ToolsTableViewCell
            else{return UITableViewCell()}
            return cell
        case 3:
            guard let cell: ViewRecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            let imgUrl = ((choosestepTool?[indexPath.row].tool?.imageId?.baseUrl ?? "") + (choosestepTool?[indexPath.row].tool?.imageId?.imgUrl ?? ""))
            
            cell.ingredientImageView.setImage(withString: imgUrl)
            
            cell.ingredientNameLabel.text = choosestepTool?[indexPath.row].tool?.toolTitle
            
            cell.ingredientQuantityLabel.text = (choosestepTool?[indexPath.row].quantityTool ?? "") + " " + (choosestepTool?[indexPath.row].unitTool ?? "")
            cell.openImageCallback = { image , index in
                
                let imgUrl = ((self.choosestepTool?[indexPath.row].tool?.imageId?.baseUrl ?? "") + (self.choosestepTool?[indexPath.row].tool?.imageId?.imgUrl ?? ""))
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: RecipeFullImageViewController.id()) as? RecipeFullImageViewController else{return}
                vc.imageUrl = imgUrl
                self.navigationController?.pushViewController(vc, animated: false)
                //let mainImage = UIImage(named:"image_placeholder")
                
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch  indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 95
        case 2:
            return 40
        default:
            return 95
        }
    }
}


