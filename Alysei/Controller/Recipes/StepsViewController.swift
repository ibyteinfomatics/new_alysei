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
    
    
    var imageArray = [#imageLiteral(resourceName: "Milk-Chocolate-1"),#imageLiteral(resourceName: "orange-600x600-500x500"),#imageLiteral(resourceName: "toppng.com-lettuce-600x567"),#imageLiteral(resourceName: "4ZLH33AYAAI6TOHGKZYZBQX5BA"),#imageLiteral(resourceName: "toppng.com-lettuce-600x567")]
    var ingredientNameArray = ["Chocolate","Cheese","Brockli","Egg","Brockli"]
    var ingredientsQuantityArray = ["1 cup","1 1/2 cup","1 unit","1 egg","1 unit"]
    
    
    var imageArray1 = [#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23")]
    var ingredientNameArray1 = ["Non-Stick Pan","Microwave","Cooking Spray","Cooker","Cooking Rod"]
    var ingredientsQuantityArray1 = ["1 unit ","1 unit","1 unit","1 unit","1 unit"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeTableViewCell")
        nextStep.layer.borderWidth = 1
        nextStep.layer.cornerRadius = 24
        nextStep.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
    }
    
    @IBAction func nextStepTapped(_ sender: UIButton) {
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
            return imageArray.count
        }
        else if section == 2{
            return 1
        }
        else if section == 3{
            return imageArray1.count
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
            return cell
        
        case 1:
            guard let cell: ViewRecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            cell.ingredientImageView.image = imageArray[indexPath.row]
            cell.ingredientNameLabel.text = ingredientNameArray[indexPath.row]
            cell.ingredientQuantityLabel.text = ingredientsQuantityArray[indexPath.row]
            
                return cell
        case 2:
            guard let cell:ToolsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToolsTableViewCell", for: indexPath) as? ToolsTableViewCell
            else{return UITableViewCell()}
            return cell
        case 3:
            guard let cell: ViewRecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            cell.ingredientImageView.image = imageArray1[indexPath.row]
            cell.ingredientNameLabel.text = ingredientNameArray1[indexPath.row]
            cell.ingredientQuantityLabel.text = ingredientsQuantityArray1[indexPath.row]
            
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
    

