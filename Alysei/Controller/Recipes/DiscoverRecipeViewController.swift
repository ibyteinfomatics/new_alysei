//
//  DiscoverRecipeViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 26/07/21.
//

import UIKit

class DiscoverRecipeViewController: UIViewController, UIScrollViewDelegate, CategoryRowDelegate{
    @IBOutlet weak var discoverRecipeView: UIView!
    @IBOutlet weak var searchRecipe: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var containerTableVw: UITableView!
    @IBOutlet weak var tapPostVw: UIView!
    @IBOutlet weak var tapMarketPlaceVw: UIView!
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    
    var arrayHeader = NSMutableArray()
    var arrayCollection = NSMutableArray()
    var checkbutton = 0
   
    var selectedIndexPath : IndexPath?
    var tableIndexPath : Int?
    var currentIndex : Int? = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        discoverRecipeView.layer.masksToBounds = false
        discoverRecipeView.layer.shadowRadius = 2
        discoverRecipeView.layer.shadowOpacity = 0.2
        discoverRecipeView.layer.shadowColor = UIColor.lightGray.cgColor
        discoverRecipeView.layer.shadowOffset = CGSize(width: 0 , height:2)
        searchRecipe.layer.cornerRadius = 5
        searchTextField.attributedPlaceholder =  NSAttributedString(string:"Search recipes", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        let tapPost = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.tapPostVw.addGestureRecognizer(tapPost)
       
        let tapMarket = UITapGestureRecognizer(target: self, action: #selector(openMarketPlace))
        self.tapMarketPlaceVw.addGestureRecognizer(tapMarket)
        
       containerTableVw.register(UINib(nibName: "ExploreNwTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreNwTableViewCell")
        containerTableVw.register(UINib(nibName: "ExploreByRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreByRecipeTableViewCell")
        containerTableVw.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingTableViewCell")
        
        containerTableVw.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        containerTableVw.register(UINib(nibName: "PreferencesTableViewCell", bundle: nil), forCellReuseIdentifier: "PreferencesTableViewCell")
        
        arrayHeader = ["Quick Search by Categories", "Quick Search by Ingridients", "Quick Search by Regions", "Trending Now", "Quick Easy"]
        arrayCollection = ["Explore", "Favourite", "My Recipes", "My Preferences"]

        self.containerTableVw.delegate = self
        self.containerTableVw.dataSource = self
        
        self.discoverCollectionView.delegate = self
        self.discoverCollectionView.dataSource = self
    }
    
    @objc func openPost(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    @objc func openMarketPlace(){
                guard let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(identifier: "MarketPlaceHomeVC") as? MarketPlaceHomeVC else {return}
                self.navigationController?.pushViewController(vc, animated: true)
                self.hidesBottomBarWhenPushed = true
            }
     
    @IBAction func createNewRecipeButton(_ sender: Any) {
        let createNewRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewRecipeViewController") as! CreateNewRecipeViewController
        self.navigationController?.pushViewController(createNewRecipeVC, animated: true)
    }
    
    func cellTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UITableView
extension DiscoverRecipeViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch checkbutton{
        case 0:
            return arrayHeader.count
            
        case 1:
            
            return 1
        case 2:
            
            return 1
        case 3:
            return 1
            
        default:
            break
        }
       return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch checkbutton {
        case 0:
            switch section{
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return 1
            case 3:
                return 1
            case 4:
                return 1
            default:
                break
            }
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            break
        }
        
        return 0
    
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = containerTableVw.dequeueReusableCell(withIdentifier: "ExploreNwTableViewCell") as! ExploreNwTableViewCell
       let cell2 = tableView.dequeueReusableCell(withIdentifier: "ExploreByRecipeTableViewCell") as! ExploreByRecipeTableViewCell
       let cell3 = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        switch checkbutton{
        case 0:

           switch indexPath.section{
           case 0:

               cell.quickSearchLbl.text = "Quick Search By Meal"
               cell.quickSearchLbl?.font = UIFont(name: "Montserrat-Bold", size: 16)
               cell.tapViewAll = { [self] in
                   
                       let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
                       self.navigationController?.pushViewController(viewAll, animated: true)
                   
               }
             
               return cell
             
              
        case 1:

              cell.quickSearchLbl.text = "Quick Search By Ingridients"
              cell.quickSearchLbl?.font = UIFont(name: "Montserrat-Bold", size: 16)
             cell.tapViewAll = {[self] in
               
                   let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
                   self.navigationController?.pushViewController(viewAll, animated: true)
              
           }
           return cell
           
        case 2:

           cell2.quickSearchByRegionLabel.text = "Quick Search By Region"
            cell2.quickSearchByRegionLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
           cell2.tapViewAllRecipe = { [self] in
               
                   let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
                   self.navigationController?.pushViewController(viewAll, animated: true)
               
           }
           
           return cell2
           
           case 3:

               cell3.quickSearchTrendingLabel.text = "Trending Now"
               cell3.quickSearchTrendingLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
               cell3.delegate = self
               cell3.tapViewAllTrending = { [self] in
                   
                       let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
                       self.navigationController?.pushViewController(viewAll, animated: true)
                   
               }
              return cell3
           case 4:

               cell3.quickSearchTrendingLabel.text = "Quick Easy"
               cell3.quickSearchTrendingLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
               cell3.delegate = self
               cell3.tapViewAllTrending = { [self] in
                   
                       let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
                       self.navigationController?.pushViewController(viewAll, animated: true)
                   
               }
              return cell3
          
        default:
            break
           
           }
        case 1:
            let cell4 = containerTableVw.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell") as! FavouriteTableViewCell
            cell4.check = true
            return cell4
        case 2:
            let cell5 = containerTableVw.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell") as! FavouriteTableViewCell
            cell5.check = false
            return cell5
        case 3:
            let cell6 = containerTableVw.dequeueReusableCell(withIdentifier: "PreferencesTableViewCell") as! PreferencesTableViewCell
            cell6.delegate = self

            return cell6
        default:
            break
      
        }

       return cell2
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch checkbutton{
        case 0:
            if (indexPath.section == 0)
             {
            
                 return 280;
             }
         
             if (indexPath.section == 1)
              {
             
                  return 280;
              }
             if (indexPath.section == 2)
              {
             
                  return 180;
              }
             if (indexPath.section == 3)
              {
             
                  return 350;
              }
             if (indexPath.section == 4)
              {
             
                  return 350;
              }
        case 1:
            return self.containerTableVw.frame.height
        case 2:
            return self.containerTableVw.frame.height
        case 3:
            return self.containerTableVw.frame.height
        default:
            break
        }
       
    return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    
    }
}
extension DiscoverRecipeViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverRecipeHomeCollectionViewCell", for: indexPath) as? DiscoverRecipeHomeCollectionViewCell {
            cell1.exploreLabel.text = arrayCollection[indexPath.item] as? String
           
            if currentIndex == indexPath.item{
                cell1.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                
            }
            else{
                cell1.exploreHighlightView.backgroundColor = .clear
            }
            return cell1
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        
        
        if indexPath.item == 3  {
            return CGSize(width: 140 , height: 50.0)
        }
        else if indexPath.item == 2{
            return CGSize(width: 130 , height: 50.0)
        }
        else{
            return CGSize(width: self.discoverCollectionView.frame.width / 4 , height: 50.0)
        }
            
       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        let cell = discoverCollectionView.cellForItem(at: indexPath as IndexPath) as? DiscoverRecipeHomeCollectionViewCell
        currentIndex = indexPath.item
        
        switch indexPath.item {
        case 0:
           
            checkbutton = 0
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            discoverCollectionView.reloadData()
            containerTableVw.reloadData()
            self.containerTableVw.register(UINib(nibName: "SearchByRegionCollectionViewCell", bundle: nil), forCellReuseIdentifier: "SearchByRegionCollectionViewCell")
            
        case 1:
           
            checkbutton = 1
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            discoverCollectionView.reloadData()
            containerTableVw.reloadData()
            self.containerTableVw.register(UINib(nibName: "ExploreNwTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreNwTableViewCell")
            
        case 2:
           
            checkbutton = 2
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            discoverCollectionView.reloadData()
            containerTableVw.reloadData()
            self.containerTableVw.register(UINib(nibName: "ExploreNwTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreNwTableViewCell")
            
        case 3:
            checkbutton = 3
            selectedIndexPath = indexPath
            cell?.exploreHighlightView.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            discoverCollectionView.reloadData()
            containerTableVw.reloadData()
            self.containerTableVw.register(UINib(nibName: "PreferencesTableViewCell", bundle: nil), forCellReuseIdentifier: "PreferencesTableViewCell")
           
        default:
            break
        }
            discoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        }

    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = discoverCollectionView.cellForItem(at: indexPath as IndexPath) as? DiscoverRecipeHomeCollectionViewCell
//
//        cell?.exploreHighlightView.backgroundColor = .clear
//        self.selectedIndexPath = nil
//
//        print("previous Deselect")
//    }
}
extension DiscoverRecipeViewController: PreferencesDelegate{
    
    func pluscellTapped(){
    
            for controller in (self.navigationController?.viewControllers ?? []) as Array {
                if controller.isKind(of: CuisinePageControlViewController.self) {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
//                else{
//                    let vc = (self.storyboard?.instantiateViewController(withIdentifier: "CuisinesViewController"))!
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
            }
        }
    
    func pluscellTapped1(){
      
            for controller in (self.navigationController?.viewControllers ?? []) as Array {
                if controller.isKind(of: FoodAllergyViewController.self) {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    
    func pluscellTapped2(){
      
            for controller in (self.navigationController?.viewControllers ?? []) as Array {
                if controller.isKind(of: FollowDietsViewController.self) {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    func pluscellTapped3(){
      
            for controller in (self.navigationController?.viewControllers ?? []) as Array {
                if controller.isKind(of: DontSeeIngredientsViewController.self) {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    func pluscellTapped4(){
      
            for controller in (self.navigationController?.viewControllers ?? []) as Array {
                if controller.isKind(of: CookingSkillViewController.self) {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        }

}
