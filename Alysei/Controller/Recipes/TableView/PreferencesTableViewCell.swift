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
class PreferencesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var PrefrenceImageCollectionView: UICollectionView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    weak var delegate: PreferencesDelegate?
    var getSavedPreferencesModel : [GetSavedPreferencesDataModel]? = []
    var data : GetSavedPreferencesDataModel?
    var showCuisine: [MapDataModel]? = []
    var showFood: [MapDataModel]? = []
    var showDiet: [MapDataModel]? = []
    var showIngridient: [MapDataModel]? = []
    var showCookingSkill: [MapDataModel]? = []
    var cusinHeight = CGFloat()
    var foodHeight = CGFloat()
    var dietHeight = CGFloat()
    var ingridientHeight = CGFloat()
    var cookingHeight = CGFloat()
    
    var imageArray :[Int]? = []
    let imageNameLabelArray = ["A","B","C","D"]
    let titleArray = ["Favourite Cuisine","Food Alergies","Diets","Ingridients","Cooking Skill"]
   
    var first = Int()
    var second = Int()
    var third = Int()
    var fourth = Int()
    var fifth = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PrefrenceImageCollectionView.delegate = self
        PrefrenceImageCollectionView.dataSource = self
        let cellNib = UINib(nibName: "PreferencesImageCollectionViewCell", bundle: nil)
        self.PrefrenceImageCollectionView.register(cellNib, forCellWithReuseIdentifier: "PreferencesImageCollectionViewCell")
        PrefrenceImageCollectionView.collectionViewLayout.invalidateLayout()
        self.PrefrenceImageCollectionView.register(PreferencesSectionCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PreferencesSectionCollectionReusableView")

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


    
    func getSavedMyPreferences() -> Void{
        self.contentView.isUserInteractionEnabled = false
//        self.getSavedPreferencesModel = [GetSavedPreferencesDataModel]()
        self.showCuisine?.removeAll()
        self.showFood?.removeAll()
        self.showDiet?.removeAll()
        self.showIngridient?.removeAll()
        self.showCookingSkill?.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getsavedPreferences, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { [self] (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            
            if let data = res?["data"] as? [[String:Any]]{
                self.getSavedPreferencesModel = data.map({GetSavedPreferencesDataModel.init(with: $0)})
                
            for i in (0..<(self.getSavedPreferencesModel?.count ?? 0)){
                switch i{
                case 0:
                    for j in (0..<(self.getSavedPreferencesModel?[i].maps?.count ?? 0))
                    {
                        if self.getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                            self.showCuisine?.append(self.getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                            self.first = 1
                            arraySelectedCuisine?.removeAll()
                            for k in (0..<(self.showCuisine?.count ?? 0)){
                                arraySelectedCuisine?.append(self.showCuisine?[k].cousinId ?? 0 )
                            }
                        }
                    }
                case 1:
                    for j in (0..<(self.getSavedPreferencesModel?[i].maps?.count ?? 0))
                    {
                        if self.getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                            self.showFood?.append(self.getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                            self.second = ((((self.showFood?.count ?? 0) + 1) % 3) == 0) ? ((self.showFood?.count ?? 0) + 1) / 3 : (((self.showFood?.count ?? 0) + 1) / 3) + 1
                            arraySelectedFood?.removeAll()
                            for k in (0..<(self.showFood?.count ?? 0)){
                                arraySelectedFood?.append(self.showFood?[k].foodId ?? 0 )
                            }
                            
                        }
                   
                    }
                case 2:
                    for j in (0..<(self.getSavedPreferencesModel?[i].maps?.count ?? 0))
                    {
                        if self.getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                            self.showDiet?.append(self.getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                            self.third = ((((self.showDiet?.count ?? 0) + 1) % 3) == 0) ? ((self.showDiet?.count ?? 0) + 1) / 3 : (((self.showDiet?.count ?? 0) + 1) / 3) + 1
                            arraySelectedDiet?.removeAll()
                            for k in (0..<(self.showDiet?.count ?? 0)){
                               
                                arraySelectedDiet?.append(self.showDiet?[k].dietId ?? 0 )
                            }
                            
                        }
                    }
                case 3:
                    for j in (0..<(self.getSavedPreferencesModel?[i].maps?.count ?? 0))
                    {
                        if self.getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                            self.showIngridient?.append(self.getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]) )
                            self.fourth = ((((self.showIngridient?.count ?? 0) + 1) % 3) == 0) ? ((self.showIngridient?.count ?? 0) + 1) / 3 : (((self.showIngridient?.count ?? 0) + 1) / 3) + 1
                            arraySelectedIngridient?.removeAll()
                       for k in (0..<(self.showIngridient?.count ?? 0)){
                        
                        arraySelectedIngridient?.append(self.showIngridient?[k].ingridientId ?? 0 )
                        }
                     }

                    }
                case 4:
                    for j in (0..<(self.getSavedPreferencesModel?[i].maps?.count ?? 0))
                    {
                        if self.getSavedPreferencesModel?[i].maps?[j].isSelected == 1{
                            self.showCookingSkill?.append(self.getSavedPreferencesModel?[i].maps?[j] ?? MapDataModel(with: [:]))
                            self.fifth = 1
                            arraySelectedCookingSkill?.removeAll()
                            for k in (0..<(self.showCookingSkill?.count ?? 0)){
                             
                                arraySelectedCookingSkill?.append(self.showCookingSkill?[k].cookingSkillId ?? 0 )
                             }
                        }
                    }
                default:
                    break
                    
                }
     
            }
            
        }
    
        self.tableViewHeight.constant = CGFloat((140 * (self.first+self.second+self.third+self.fourth+self.fifth))+200)
            finalHeight = self.tableViewHeight.constant
        self.PrefrenceImageCollectionView.reloadData()
        self.contentView.isUserInteractionEnabled = true
        }
    }
    
//    func config(){
//
//        let first = 1
////            (((showCuisine?.count ?? 0) % 3) == 0) ? (showCuisine?.count ?? 0) / 3 : ((showCuisine?.count ?? 0) / 3) + 1
//
//        let second = ((((showFood?.count ?? 0) + 1) % 3) == 0) ? ((showFood?.count ?? 0) + 1) / 3 : (((showFood?.count ?? 0) + 1) / 3) + 1
//
//        let third = ((((showDiet?.count ?? 0) + 1) % 3) == 0) ? ((showDiet?.count ?? 0) + 1) / 3 : (((showDiet?.count ?? 0) + 1) / 3) + 1
//
//        let foutrh = ((((showIngridient?.count ?? 0) + 1) % 3) == 0) ? ((showIngridient?.count ?? 0) + 1) / 3 : (((showIngridient?.count ?? 0) + 1) / 3) + 1
//
//        let fifth = 1
////            ((((showCookingSkill?.count ?? 0) + 1) % 3) == 0) ? ((showCookingSkill?.count ?? 0) + 1) / 3 : (((showCookingSkill?.count ?? 0) + 1) / 3) + 1
//
//
//        tableViewHeight.constant = CGFloat((140 * (first+second+third+foutrh+fifth))+200)
//
//
//    }
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
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PreferencesImageCollectionViewCell", for: indexPath) as! PreferencesImageCollectionViewCell
       
        switch indexPath.section {
        case 0:
            if indexPath.row < showCuisine!.count {
                let imgUrl = (kImageBaseUrl + (showCuisine?[indexPath.item].imageId?.imgUrl ?? ""))
                
                cell.imageView.setImage(withString: imgUrl)
                
                cell.imageView.contentMode = .scaleAspectFill
//                cell.imageIcon.isHidden = true
                cell.imageNameLabel.text = showCuisine?[indexPath.item].name
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                cell.imageView1.image = UIImage(named: "")
                cell.imageView1.clipsToBounds = true
            }else {
                cell.imageView.image = UIImage(named: "")
               
                cell.imageView.contentMode = .scaleAspectFit

                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.clear.cgColor
                cell.imageView1.image = UIImage(named: "")
                cell.imageView1.clipsToBounds = true
            }
            
//                    if showCuisine!.count % 3 == 0 {
//                        tableViewHeight.constant = CGFloat(128*(showCuisine!.count/3))
//                        cusinHeight = tableViewHeight.constant
//
//                    }
//                    else{
//                        tableViewHeight.constant = CGFloat(128*((showCuisine!.count/3) + 1 ))
//                        cusinHeight = tableViewHeight.constant
//                    }
//

            
        case 1:
            if indexPath.row < showFood!.count {

                let imgUrl = (kImageBaseUrl + (showFood?[indexPath.row].imageId?.imgUrl ?? ""))
                let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
                cell.imageView.contentMode = .center
                cell.imageView.image = mySVGImage.uiImage
                cell.imageNameLabel.text = showFood?[indexPath.row].name
              
            cell.imageView1.layer.cornerRadius = cell.imageView1.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                cell.imageView1.image = UIImage(named: "")
            cell.imageView1.clipsToBounds = true
            }else {
                cell.imageView.image = UIImage(named: "Group 1166")
                cell.imageView.contentMode = .center
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.lightGray.cgColor
                cell.imageView1.image = UIImage(named: "")
                cell.imageView1.clipsToBounds = true
            }
            
//            if showFood!.count % 3 == 0 {
//                tableViewHeight.constant = CGFloat(128*(showFood!.count/3))
//                foodHeight = tableViewHeight.constant
//            }
//            else{
//                tableViewHeight.constant = CGFloat(128*((showFood!.count/3) + 1 ))
//                foodHeight = tableViewHeight.constant
//            }
           
        case 2:
            if indexPath.row < showDiet!.count {
                let imgUrl = (kImageBaseUrl + (showDiet?[indexPath.row].imageId?.imgUrl ?? ""))
                let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
                cell.imageView.contentMode = .center
                cell.imageView.image = mySVGImage.uiImage
                cell.imageNameLabel.text = showDiet?[indexPath.row].name
               
            cell.imageView1.layer.cornerRadius = cell.imageView1.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                cell.imageView1.image = UIImage(named: "")
            cell.imageView1.clipsToBounds = true
            }else {
                cell.imageView.image = UIImage(named: "Group 1166")
                cell.imageView.contentMode = .center
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.lightGray.cgColor
                cell.imageView1.image = UIImage(named: "")
                cell.imageView1.clipsToBounds = true
            }
            
//            if showDiet!.count % 3 == 0 {
//                tableViewHeight.constant = CGFloat(128*(showDiet!.count/3))
//                dietHeight = tableViewHeight.constant
//            }
//            else{
//                tableViewHeight.constant = CGFloat(128*((showDiet!.count/3) + 1 ))
//                dietHeight = tableViewHeight.constant
//            }
//
        case 3:
            if indexPath.row < showIngridient!.count {
                let imgUrl = (kImageBaseUrl + (showIngridient?[indexPath.item].imageId?.imgUrl ?? ""))
                
                cell.imageView.setImage(withString: imgUrl)
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = showIngridient?[indexPath.row].name
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
//                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
//            cell.imageView1.layer.borderWidth = 3
            cell.imageView1.image = UIImage(named: "Group 1165")
            cell.imageView1.clipsToBounds = true
            }else {
                cell.imageView.image = UIImage(named: "Group 1166")
                cell.imageView.contentMode = .center
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.lightGray.cgColor
                cell.imageView1.image = UIImage(named: "")
                cell.imageView1.clipsToBounds = true
            }
            
//            if showIngridient!.count % 3 == 0 {
//                tableViewHeight.constant = CGFloat(128*(showIngridient!.count/3))
//                ingridientHeight = tableViewHeight.constant
//            }
//            else{
//                tableViewHeight.constant = CGFloat(128*((showIngridient!.count/3) + 1 ))
//                ingridientHeight = tableViewHeight.constant
//            }
          
        case 4:
            if indexPath.row < showCookingSkill!.count {
                let imgUrl = (kImageBaseUrl + (showCookingSkill?[indexPath.row].imageId?.imgUrl ?? ""))
                let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imgUrl))
                cell.imageView.contentMode = .center
                cell.imageView.image = mySVGImage.uiImage
                cell.imageNameLabel.text = showCookingSkill?[indexPath.row].name
             
            cell.imageView1.layer.cornerRadius = cell.imageView1.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
                cell.imageView1.image = UIImage(named: "")
            cell.imageView1.clipsToBounds = true
            }else {
              
                cell.imageView.image = UIImage(named: "Group 1166")
                cell.imageView.contentMode = .center
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = ""
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.lightGray.cgColor
                cell.imageView1.image = UIImage(named: "")
                cell.imageView1.clipsToBounds = true
            }
            
//            if showCookingSkill!.count % 3 == 0 {
//                tableViewHeight.constant = CGFloat(128*(showCookingSkill!.count/3))
//                cookingHeight = tableViewHeight.constant
//            }
//            else{
//                tableViewHeight.constant = CGFloat(128*((showCookingSkill!.count/3) + 1 ))
//                cookingHeight = tableViewHeight.constant
//            }
           
        default:
            break
        }
        
   
       return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        return CGSize(width: (self.frame.size.width)/3 - 10, height: 130)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PreferencesSectionCollectionReusableView", for: indexPath) as! PreferencesSectionCollectionReusableView
            sectionHeader.label.text = titleArray[indexPath.section]
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
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
