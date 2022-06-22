//
//  PreferencesTableViewCell.swift
//  Filter App
//
//  Created by mac on 15/09/21.
//

import UIKit
import SVGKit

protocol PreferencesDelegate: AnyObject {
    func pluscellTapped()
    func pluscellTapped1()
    func pluscellTapped2()
    func pluscellTapped3()
    func pluscellTapped4()
   }
var finalHeight = CGFloat()
var showCuisine: [MapDataModel]? = []
var showFood: [MapDataModel]? = []
var showDiet: [MapDataModel]? = []
var showIngridient: [MapDataModel]? = []
var showCookingSkill: [MapDataModel]? = []
var getSavedPreferencesModel : [GetSavedPreferencesDataModel]? = []

var first = Int()
var second = Int()
var third = Int()
var fourth = Int()
var fifth = Int()
class PreferencesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var PrefrenceImageCollectionView: UICollectionView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    weak var delegate: PreferencesDelegate?

    let titleArray = [RecipeConstants.kFavCuisine,RecipeConstants.kFoodAlrgy,RecipeConstants.kDiet,RecipeConstants.kIngredient,RecipeConstants.kCkngSkill]
   
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PrefrenceImageCollectionView.delegate = self
        PrefrenceImageCollectionView.dataSource = self
        let cellNib = UINib(nibName: "PreferencesImageCollectionViewCell", bundle: nil)
        self.PrefrenceImageCollectionView.register(cellNib, forCellWithReuseIdentifier: "PreferencesImageCollectionViewCell")
        PrefrenceImageCollectionView.collectionViewLayout.invalidateLayout()
        self.PrefrenceImageCollectionView.register(PreferencesSectionCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PreferencesSectionCollectionReusableView")
        self.PrefrenceImageCollectionView.register(MyPreferenceCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MyPreferenceCollectionReusableView")
        
        self.PrefrenceImageCollectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")

    }
   
    var post: Bool?{
        didSet{
            self.PrefrenceImageCollectionView.reloadData()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        CATransaction.begin()
         CATransaction.setDisableActions(true)
       
         CATransaction.commit()
        }

}
extension PreferencesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return titleArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            if showCuisine?.count == 0{
            return 1
        }
        else{
            return (showCuisine?.count ?? 0) + 1
        }
        case 1:
            if showFood?.count == 0{
                return 1
            }
            else{
            return (showFood?.count ?? 0) + 1
            }
        case 2:
            if showDiet?.count == 0{
                return 1
            }
            else{
            return (showDiet?.count ?? 0) + 1
            }
        case 3:
            if showIngridient?.count == 0{
                return 1
            }
            else{
            return (showIngridient?.count ?? 0) + 1
            }
        case 4:
            if showCookingSkill?.count == 0{
                return 1
            }
            else{
            return (showCookingSkill?.count ?? 0) + 1
            }
        default:
            break
            
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PreferencesImageCollectionViewCell", for: indexPath) as! PreferencesImageCollectionViewCell
            cell.imageView1.isHidden = true
            
            if indexPath.row < showCuisine!.count {
                let imgUrl = ((showCuisine?[indexPath.item].imageId?.baseUrl ?? "") + (showCuisine?[indexPath.item].imageId?.imgUrl ?? ""))
                
                if imgUrl == ""{
                    cell.imageView.image = UIImage(named: "image_placeholder")
                }
                else{
                    cell.imageView.setImage(withString: imgUrl)
                }
                
                cell.imageView.contentMode = .scaleAspectFill
                cell.imageNameLabel.text = showCuisine?[indexPath.item].name
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.borderWidth = 3
                cell.vwImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
           //     cell.vwImage.image = UIImage(named: "")
                cell.vwImage.clipsToBounds = true
            }else {
                cell.imageView.image = UIImage(named: "")
               
                cell.imageView.contentMode = .scaleAspectFit

                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.borderWidth = 3
                cell.vwImage.layer.borderColor = UIColor.clear.cgColor
             //   cell.vwImage.image = UIImage(named: "")
                cell.vwImage.clipsToBounds = true
            }
            return cell
        case 1:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PreferencesImageCollectionViewCell", for: indexPath) as! PreferencesImageCollectionViewCell
            cell.imageView1.isHidden = true
            
            if indexPath.row < showFood!.count {

                let imgUrl = ((showFood?[indexPath.item].imageId?.baseUrl ?? "") + (showFood?[indexPath.row].imageId?.imgUrl ?? ""))
                let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
               cell.imageView.contentMode = .center
                if imgUrl == ""{
                    cell.imageView.image = UIImage(named: "image_placeholder")
                }
                else{
                    cell.imageView.image = mySVGImage.uiImage
                }
                
                cell.imageNameLabel.text = showFood?[indexPath.row].name
              
            cell.vwImage.layer.cornerRadius = cell.vwImage.frame.height/2
            cell.vwImage.layer.borderWidth = 3
                cell.vwImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
             //   cell.vwImage.image = UIImage(named: "")
            cell.vwImage.clipsToBounds = true
            }else {
                cell.imageView.image = UIImage(named: "Group 122845")
               cell.imageView.contentMode = .center
          
                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.borderWidth = 3
                cell.vwImage.layer.borderColor = UIColor.lightGray.cgColor
           //     cell.vwImage.image = UIImage(named: "")
                cell.vwImage.clipsToBounds = true
            }
        return cell
        case 2:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
            cell.image2.isHidden = true
            cell.image1.contentMode = . scaleAspectFit
//            let imgUrl = ((showAllFood?[indexPath.row].imageId?.baseUrl ?? "") + (showAllFood?[indexPath.row].imageId?.imgUrl ?? ""))
//            let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
//            cell.image1.contentMode = .scaleAspectFit
//            cell.image1.image = mySVGImage.uiImage
//            cell.imageNameLabel.text = showAllFood?[indexPath.row].name
//
//            cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
//
//            if showAllFood?[indexPath.row].isSelected == 1{
//                cell.viewOfImage.layer.borderWidth = 4
//                cell.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            if indexPath.row < showDiet!.count {
                let imgUrl = ((showDiet?[indexPath.item].imageId?.baseUrl ?? "") + (showDiet?[indexPath.row].imageId?.imgUrl ?? ""))
                let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
                    //cell.imageView.contentMode = .center
               
              
                if imgUrl == ""{
                    cell.image1.image = UIImage(named: "image_placeholder")
                }
                else{
                    cell.image1.image = mySVGImage.uiImage
                }
                cell.imageNameLabel.text = showDiet?[indexPath.row].name
               
            cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.frame.height/2
            cell.viewOfImage.layer.borderWidth = 3
                cell.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
           //     cell.vwImage.image = UIImage(named: "")
            cell.viewOfImage.clipsToBounds = true
            }else {
                  cell.image1.image = UIImage(named: "Group 122845")
                cell.image1.contentMode = .center
                
                cell.imageNameLabel.text = ""
              //  cell.image1.layer.cornerRadius = cell.imageView.frame.height/2
                cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.frame.height/2
                cell.viewOfImage.layer.borderWidth = 3
                cell.viewOfImage.layer.borderColor = UIColor.lightGray.cgColor
            //    cell.vwImage.image = UIImage(named: "")
                cell.viewOfImage.clipsToBounds = true
            }
            
         return cell
        case 3:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PreferencesImageCollectionViewCell", for: indexPath) as! PreferencesImageCollectionViewCell
            if indexPath.row < showIngridient!.count {
                let imgUrl = ((showIngridient?[indexPath.item].imageId?.baseUrl ?? "") + (showIngridient?[indexPath.item].imageId?.imgUrl ?? ""))
                
                if imgUrl == ""{
                    cell.imageView.image = UIImage(named: "image_placeholder")
                }
                else{
                    cell.imageView.setImage(withString: imgUrl)
                }
             
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = showIngridient?[indexPath.row].title
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.isHidden = false
                cell.imageView1.image = UIImage(named: "Group 1165")
               // cell.vwImage.layer.cornerRadius = cell.imageView.frame.height/2
               // cell.vwImage.layer.borderWidth = 3
                //cell.vwImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
          //  cell.vwImage.image = UIImage(named: "Group 1165")
            //cell.vwImage.clipsToBounds = true
            }else {
                cell.imageView.image = UIImage(named: "Group 122845")
                cell.imageView.contentMode = .center
             
                cell.imageNameLabel.text = ""
                //cell.imageView.layer.cornerRadius = cell.vwImage.frame.height/2
                cell.vwImage.layer.cornerRadius = cell.vwImage.frame.height/2
                cell.vwImage.layer.borderWidth = 3
                cell.vwImage.layer.borderColor = UIColor.lightGray.cgColor
             //   cell.vwImage.image = UIImage(named: "")
                cell.vwImage.clipsToBounds = true
            }
            
return cell
        case 4:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PreferencesImageCollectionViewCell", for: indexPath) as! PreferencesImageCollectionViewCell
            cell.imageView1.isHidden = true
            if indexPath.row < showCookingSkill!.count {
                let imgUrl = ((showCookingSkill?[indexPath.item].imageId?.baseUrl ?? "") + (showCookingSkill?[indexPath.row].imageId?.imgUrl ?? ""))
                let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
                cell.imageView.contentMode = .center
                if imgUrl == ""{
                    cell.imageView.image = UIImage(named: "image_placeholder")
                }
                else{
                    cell.imageView.image = mySVGImage.uiImage
                }
                cell.imageNameLabel.text = showCookingSkill?[indexPath.row].name
             
            cell.vwImage.layer.cornerRadius = cell.vwImage.frame.height/2
            cell.vwImage.layer.borderWidth = 3
                cell.vwImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
             //   cell.vwImage.image = UIImage(named: "")
            cell.vwImage.clipsToBounds = true
            }else {
              
                cell.imageView.image = UIImage(named: "Group 122845")
                cell.imageView.contentMode = .center
                
                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.cornerRadius = cell.imageView.frame.height/2
                cell.vwImage.layer.borderWidth = 3
                cell.vwImage.layer.borderColor = UIColor.lightGray.cgColor
              //  cell.vwImage.image = UIImage(named: "")
                cell.vwImage.clipsToBounds = true
            }
         return cell
        default:
            return UICollectionViewCell()
        }
      
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        return CGSize(width: (self.frame.size.width)/3 - 10, height: 140)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PreferencesSectionCollectionReusableView", for: indexPath) as! PreferencesSectionCollectionReusableView
            sectionHeader.label.text = titleArray[indexPath.section]
             return sectionHeader
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyPreferenceCollectionReusableView", for: indexPath) as! MyPreferenceCollectionReusableView

            sectionFooter.label1.backgroundColor = .black
                return sectionFooter

            }
          
              return  UICollectionReusableView()
        
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 15)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

                switch indexPath.section {
                case 0:
                    if indexPath.row < showCuisine!.count {
                        return
                    }
                    else{
                        return
                    
                        }
                case 1:
                    if indexPath.row < showFood!.count {
                        return
                    }
                    else{
                    if delegate != nil {
                        delegate?.pluscellTapped1()
                        }
                    }
                case 2:
                    if indexPath.row < showDiet!.count {
                        return
                    }
                    else{
                    if delegate != nil {
                        delegate?.pluscellTapped2()
                        }
                    }
                case 3:
                    if indexPath.row < showIngridient!.count {
                        return
                    }
                    else{
                    if delegate != nil {
                        delegate?.pluscellTapped3()
                        }
                    }
                case 4:
                    if indexPath.row < showCookingSkill!.count {
                        return
                    }
                    else{
                    if delegate != nil {
                        delegate?.pluscellTapped4()
                        }
                    }
                default:
                    break
                }

       }
    
}
