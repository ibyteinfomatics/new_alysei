//
//  ViewRecipeViewController.swift
//  New Recipe module
//
//  Created by mac on 12/08/21.
//

import UIKit

class ViewRecipeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!

    var checkbutton = 0
    

    var imageArray = [#imageLiteral(resourceName: "Milk-Chocolate-1"),#imageLiteral(resourceName: "orange-600x600-500x500"),#imageLiteral(resourceName: "toppng.com-lettuce-600x567"),#imageLiteral(resourceName: "4ZLH33AYAAI6TOHGKZYZBQX5BA"),#imageLiteral(resourceName: "toppng.com-lettuce-600x567")]
    var ingredientNameArray = ["Chocolate","Cheese","Brockli","Egg","Brockli"]
    var ingredientsQuantityArray = ["1 cup","1 1/2 cup","1 unit","1 egg","1 unit"]
    
    
    var imageArray1 = [#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "23")]
    var ingredientNameArray1 = ["Non-Stick Pan","Microwave","Cooking Spray","Cooker","Cooking Rod"]
    var ingredientsQuantityArray1 = ["1 unit ","1 unit","1 unit","1 unit","1 unit"]
    
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeTableViewCell")
//        tableView.register(UINib(nibName: "LikeRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "LikeRecipeTableViewCell")
        }
    
    
    @IBAction func tapBackHome(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapForStartCooking(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepsViewController") as! StepsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension ViewRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
            
        }else if section == 1{
     switch checkbutton {
        case 0:
            print("Check 0 Count------------------\(ingredientNameArray.count)")
            return ingredientNameArray.count
        case 1:
            return ingredientNameArray1.count
        
     default:
        print("Invalid")
        }
        }
        else if section == 2{
            return 1
        }
        else{
        return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // if indexPath.section = 0
        switch indexPath.section {
        case 0:
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "ViewDetailsTableViewCell", for: indexPath) as? ViewDetailsTableViewCell else {return UITableViewCell()}
            cell.reloadTableViewCallback = { tag in
                self.checkbutton = tag
                self.tableView.reloadData()
                cell.layer.cornerRadius = 50
                cell.layer.masksToBounds = true

            }
           
          
            return cell
        case 1:
            guard let cell:ViewRecipeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeTableViewCell", for: indexPath) as? ViewRecipeTableViewCell else {return UITableViewCell()}
            if checkbutton == 0{
                cell.ingredientImageView.image = imageArray[indexPath.row]
                            cell.ingredientNameLabel.text = ingredientNameArray[indexPath.row]
                            cell.ingredientQuantityLabel.text = ingredientsQuantityArray[indexPath.row]
        
                
            }else{
                cell.ingredientImageView.image = imageArray1[indexPath.row]
                           cell.ingredientNameLabel.text = ingredientNameArray1[indexPath.row]
                           cell.ingredientQuantityLabel.text = ingredientsQuantityArray1[indexPath.row]
            }
            
            return cell
            
        case 2:
            guard let cell:RecipeByTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "RecipeByTableViewCell") as? RecipeByTableViewCell else {return UITableViewCell()}
        return cell
            
        default:
            guard let cell:LikeRecipeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "LikeRecipeTableViewCell") as? LikeRecipeTableViewCell else {return UITableViewCell()}
        return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 300
        case 1:
            return 50
        case 2:
            return 350
        case 3:
            return 350
        default:
            return 400
        }
      
    }
}
        




