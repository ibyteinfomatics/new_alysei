//
//  MarketPlaceFirstTiimeVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 10/30/21.
//

import UIKit

class MarketPlaceFirstTiimeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgArray = ["icons8_shop-1","Group 1156", "Group 1157"]
    
    var bgImage = ["Walkthrough Screen – 20","Walkthrough Screen – 21","Walkthrough Screen – 22"]
    var titleArray = ["Welcome to Marketplace", "MarketPlace Rules", "Features you can explore"]
    var subTitleArray = ["Here you can search,explore products from Italian Producers and can send Inquiry as well.", "hen an unknown printer took a gallery of type and scrambled it to make a type","hen an unknown printer took a gallery of type and scrambled it to make a type"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
extension MarketPlaceFirstTiimeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkthroughCVC", for: indexPath) as? WalkthroughCVC else {return UICollectionViewCell()}
        cell.bgImage.image = UIImage(named: bgImage[indexPath.row])
        cell.img.image =  UIImage(named: imgArray[indexPath.row])
        cell.lblTitle.text = titleArray[indexPath.row]
        cell.lblSubTitle.text = subTitleArray[indexPath.row]
        if indexPath.row == 0 || indexPath.row == 1{
            cell.btnNext.setTitle("Next", for: .normal)
        }else{
            cell.btnNext.setTitle("Done", for: .normal)
        }
          
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)"{
            cell.lblUserName.text = kSharedUserDefaults.loggedInUserModal.restaurantName
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId  == "\(UserRoles.voyagers.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId  == "\(UserRoles.voiceExperts.rawValue)"{
            cell.lblUserName.text = "\(kSharedUserDefaults.loggedInUserModal.firstName ?? "")" + "\(kSharedUserDefaults.loggedInUserModal.lastName ?? "")"
        }else{
            cell.lblUserName.text = kSharedUserDefaults.loggedInUserModal.companyName
        }
        cell.callBackNext = {
           
            if indexPath.row == 0 || indexPath.row == 1{
              
              let currentIndexPath = collectionView.indexPath(for: cell)!
              if currentIndexPath.item < StaticArrayData.kTutorialDict.count - 1{
                
                let indexPath = IndexPath(item: currentIndexPath.item+1, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
                self.collectionView.reloadItems(at: [indexPath])
              }
            }else{
                self.navigationController?.popViewController(animated: false)
            }
             
            

        }
        if indexPath.row == 0 {
            cell.view1W.constant = 25
            cell.view2W.constant = 10
            cell.view3W.constant = 10
            
        }else if indexPath.row == 1 {
            cell.view1W.constant = 10
            cell.view2W.constant = 25
            cell.view3W.constant = 10
        }else{
            cell.view1W.constant = 10
            cell.view2W.constant = 10
            cell.view3W.constant = 25
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
}
    


class WalkthroughCVC: UICollectionViewCell{
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view1W: NSLayoutConstraint!
    @IBOutlet weak var view2W: NSLayoutConstraint!
    @IBOutlet weak var view3W: NSLayoutConstraint!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    var callBackNext:(() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view1.layer.cornerRadius = 5
        view2.layer.cornerRadius = 5
        view3.layer.cornerRadius = 5
    }

    @IBAction func btnNextAction(_ sender: UIButton){
        callBackNext?()
    }
}
