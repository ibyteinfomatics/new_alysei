//
//  StepsViewController.swift
//  New Recipe module
//
//  Created by mac on 20/08/21.
//

import UIKit

class StepsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextStep: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var stepImage: UIImageView!
    
    var page = 1
//    var stepIngridients: [UsedIngridientDataModel]? = []
//    var stepTools: [UsedToolsDataModel]? = []
//
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeTableViewCell")
        nextStep.layer.borderWidth = 1
        nextStep.layer.cornerRadius = 24
        nextStep.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        let imgUrl = (kImageBaseUrl + (recipeModel?.image?.imgUrl ?? ""))
        stepImage.setImage(withString: imgUrl)
    }
    
   
    @IBAction func nextStepTapped(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WellDoneViewController") as! WellDoneViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @IBAction func tapDownBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapBacklToViewRecipe(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
            return 1
        }
        else if section == 2{
            return 1
        }
        else if section == 3{
            return 1
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
            cell.lblDescription.text = stepsModel?[indexPath.row].description
            return cell
        
        case 1:
            guard let cell: ViewRecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            let imgUrl = (kImageBaseUrl + (stepsModel?[indexPath.row].stepIngridient?[indexPath.row].ingridient?.imageId?.imgUrl ?? ""))
            cell.ingredientImageView.setImage(withString: imgUrl)
            
            cell.ingredientNameLabel.text = stepsModel?[indexPath.row].stepIngridient?[indexPath.row].ingridient?.ingridientTitle
            cell.ingredientQuantityLabel.text = (stepsModel?[indexPath.row].stepIngridient?[indexPath.row].quantity ?? "")  + " " + (stepsModel?[indexPath.row].stepIngridient?[indexPath.row].unit ?? "")
            
                return cell
        case 2:
            guard let cell:ToolsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToolsTableViewCell", for: indexPath) as? ToolsTableViewCell
            else{return UITableViewCell()}
            return cell
        case 3:
            guard let cell: ViewRecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            let imgUrl = (kImageBaseUrl + (stepsModel?[indexPath.row].stepTool?[indexPath.row].tool?.imageId?.imgUrl ?? ""))
            cell.ingredientImageView.setImage(withString: imgUrl)
            
            cell.ingredientNameLabel.text = stepsModel?[indexPath.row].stepTool?[indexPath.row].tool?.toolTitle
            cell.ingredientQuantityLabel.text = (stepsModel?[indexPath.row].stepTool?[indexPath.row].quantityTool ?? "") + " " + (stepsModel?[indexPath.row].stepTool?[indexPath.row].unitTool ?? "")
            
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
            return 60
        case 2:
            return 40
        default:
            return 60
        }
    }
}
    

