//
//  PreferencesTableViewCell.swift
//  Filter App
//
//  Created by mac on 15/09/21.
//

import UIKit

protocol PreferencesDelegate: AnyObject {
    func pluscellTapped()
    func pluscellTapped1()
    func pluscellTapped2()
    func pluscellTapped3()
    func pluscellTapped4()
   }

class PreferencesTableViewCell: UITableViewCell {

    @IBOutlet weak var PrefrenceImageCollectionView: UICollectionView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    weak var delegate: PreferencesDelegate?
    let imageArray = [#imageLiteral(resourceName: "Ellipse3"),#imageLiteral(resourceName: "tiramisu-dessert-easy-vegan"),#imageLiteral(resourceName: "brussels_sprouts_sliders"),#imageLiteral(resourceName: "watermelon-margarita-slush-cocktail")]
    let imageNameLabelArray = ["A","B","C","D"]
    let titleArray = ["Favourite Cuisins","Food Alergies","Diets","Ingridients","Cooking Skill"]
    override func awakeFromNib() {
        super.awakeFromNib()
        PrefrenceImageCollectionView.delegate = self
        PrefrenceImageCollectionView.dataSource = self
        let cellNib = UINib(nibName: "PreferencesImageCollectionViewCell", bundle: nil)
        self.PrefrenceImageCollectionView.register(cellNib, forCellWithReuseIdentifier: "PreferencesImageCollectionViewCell")
        
        self.PrefrenceImageCollectionView.register(PreferencesSectionCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PreferencesSectionCollectionReusableView")
        if imageArray.count % 3 == 0 {
       tableViewHeight.constant = CGFloat(128*(imageArray.count/3))

        }
        else{
            tableViewHeight.constant = CGFloat(128*((imageArray.count/3) + 1 ))
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension PreferencesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return titleArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
        if imageNameLabelArray.count == 0{
            return 1
        }
        else{
        return imageNameLabelArray.count + 1
        }
        case 1:
            if imageNameLabelArray.count == 0{
                return 1
            }
            else{
            return imageNameLabelArray.count + 1
            }
        case 2:
            if imageNameLabelArray.count == 0{
                return 1
            }
            else{
            return imageNameLabelArray.count + 1
            }
        case 3:
            if imageNameLabelArray.count == 0{
                return 1
            }
            else{
            return imageNameLabelArray.count + 1
            }
        case 4:
            if imageNameLabelArray.count == 0{
                return 1
            }
            else{
            return imageNameLabelArray.count + 1
            }
        default:
            break
            
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PreferencesImageCollectionViewCell", for: indexPath) as? PreferencesImageCollectionViewCell else{return UICollectionViewCell()}
        switch indexPath.section {
        case 0:
            if indexPath.row < imageArray.count {
            cell.imageView.image = imageArray[indexPath.row]
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = imageNameLabelArray[indexPath.row]
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
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
                cell.imageView1.clipsToBounds = true
            }
            return cell
        case 1:
            if indexPath.row < imageArray.count {
            cell.imageView.image = imageArray[indexPath.row]
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = imageNameLabelArray[indexPath.row]
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
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
                cell.imageView1.clipsToBounds = true
            }
            return cell
        case 2:
            if indexPath.row < imageArray.count {
            cell.imageView.image = imageArray[indexPath.row]
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = imageNameLabelArray[indexPath.row]
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
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
                cell.imageView1.clipsToBounds = true
            }
            return cell
        case 3:
            if indexPath.row < imageArray.count {
            cell.imageView.image = imageArray[indexPath.row]
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = imageNameLabelArray[indexPath.row]
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
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
                cell.imageView1.clipsToBounds = true
            }
            return cell
        case 4:
            if indexPath.row < imageArray.count {
            cell.imageView.image = imageArray[indexPath.row]
                cell.imageView.contentMode = .scaleAspectFit
                cell.imageNameLabel.text = imageNameLabelArray[indexPath.row]
                cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.cornerRadius = cell.imageView.frame.height/2
            cell.imageView1.layer.borderWidth = 3
                cell.imageView1.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
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
                cell.imageView1.clipsToBounds = true
            }
            return cell
        default:
            break
        }
       return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.size.width/4) + 1 , height: 128)
        
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
        return CGSize(width: collectionView.frame.width, height: 60)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row < imageArray.count {
//            return
//        }
//        else{
//
//                switch indexPath.section {
//                case 0:
//                    if delegate != nil {
//                        delegate?.pluscellTapped()
//                        }
//                case 1:
//                    if delegate != nil {
//                        delegate?.pluscellTapped1()
//                        }
//                case 2:
//                    if delegate != nil {
//                        delegate?.pluscellTapped2()
//                        }
//                case 3:
//                    if delegate != nil {
//                        delegate?.pluscellTapped3()
//                        }
//                case 4:
//                    if delegate != nil {
//                        delegate?.pluscellTapped4()
//                        }
//                default:
//                    break
//                }
//
//       }
//    }
}
