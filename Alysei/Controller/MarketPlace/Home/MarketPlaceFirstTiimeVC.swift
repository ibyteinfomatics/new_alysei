//
//  MarketPlaceFirstTiimeVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 10/30/21.
//

import UIKit

class MarketPlaceFirstTiimeVC: AlysieBaseViewC {
    
    @IBOutlet weak var collectionViewTutorial: UICollectionView!
    
    var imgArray = ["icons8_shop-1","Group 1156", "Group 1157"]
    
    var bgImage = ["Walkthrough Screen – 20","Walkthrough Screen – 21","Walkthrough Screen – 22"]
    var titleProdArray = ["Welcome to Marketplace","Features you can explore","MarketPlace Rules"]
    var subTitleProdArray = ["Here you can create your unique Store, upload your product portfolio, explore, search and reply to inquiries", "The most powerful markeplace engine for the Made in Italy","To ensure a positive experience follow these simple rules"]
    
    var walkSub2ViewImg = ["icons8_user_groups-1","icons8_sell_stock","icons8_handshake_heart"]
    
    var titleWalk2ProdTitle = ["Create your Store","Reply to inquiry"]
    var subTitleWalk2ProdTitle = ["Showcase you Products Store in a simple, clean and professional way","Being responsive will help you to build trust with Buyers"]
    var titleWalk3ProdTitle = ["Information and details","Photo Quality","Report suspicious behaviour"]
    var subTitleWalk3ProdTitle = ["Make sure all the information you provide are accurate and completed","Make sure that all photos that you upload are in high quality","Let us know if something does not feel right"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.hidesBottomBarWhenPushed = true
    }
    private func getTutorialCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
      
      let cell = collectionViewTutorial.dequeueReusableCell(withReuseIdentifier: WalkthroughCVC.identifier(), for: indexPath) as! WalkthroughCVC
        cell.delegate = self
        cell.bgImage.image = UIImage(named: bgImage[indexPath.row])
                cell.img.image =  UIImage(named: imgArray[indexPath.row])
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
                cell.lblTitle.text = titleProdArray[indexPath.row]
                cell.lblSubTitle.text = subTitleProdArray[indexPath.row]
        }
                if indexPath.row == 0 || indexPath.row == 1{
                    cell.btnNext.setTitle("Next", for: .normal)
                }else{
                    cell.btnNext.setTitle("Done", for: .normal)
                }
        
                if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.restaurant.rawValue)"{
                    cell.lblUserName.text = kSharedUserDefaults.loggedInUserModal.restaurantName
                }else if kSharedUserDefaults.loggedInUserModal.memberRoleId  == "\(UserRoles.voyagers.rawValue)" || kSharedUserDefaults.loggedInUserModal.memberRoleId  == "\(UserRoles.voiceExperts.rawValue)"{
                    cell.lblUserName.text = "\(kSharedUserDefaults.loggedInUserModal.firstName ?? "")" + " " + "\(kSharedUserDefaults.loggedInUserModal.lastName ?? "")"
                }else{
                    cell.lblUserName.text = kSharedUserDefaults.loggedInUserModal.companyName
                }
        
        if indexPath.row == 0{
            cell.walkSubView1.isHidden = true
            cell.walkSubView2.isHidden = true
            cell.walkSubView3.isHidden = true
            cell.walkSubView3Height.constant = 0
            cell.walkSubView1Height.constant = 0
            cell.walkSubView2Height.constant = 0
    
        } else if indexPath.row == 1 {
            cell.walkSubView1.isHidden = false
            cell.walkSubView2.isHidden = false
            cell.walkSubView3.isHidden = true
            cell.walkSubView3Height.constant = 55
            cell.walkSubView1Height.constant = 55
            cell.walkSubView2Height.constant = 0
            cell.walkSubView1Img.image = UIImage(named: walkSub2ViewImg[0])
        cell.walkSubView1Title.text = titleWalk2ProdTitle[0]
        cell.walkSubView1SubTitle.text = subTitleWalk2ProdTitle[0]
        cell.walkSubView2Img.image = UIImage(named: walkSub2ViewImg[1])
        cell.walkSubView2Title.text = titleWalk2ProdTitle[1]
        cell.walkSubView2SubTitle.text = subTitleWalk2ProdTitle[1]
            
        }else if indexPath.row == 2{
            cell.walkSubView1.isHidden = false
            cell.walkSubView2.isHidden = false
            cell.walkSubView3.isHidden = false
            cell.walkSubView3Height.constant = 55
            cell.walkSubView1Height.constant = 55
            cell.walkSubView2Height.constant = 55
            cell.walkSubView1Img.image = UIImage(named: "icons8_reply")
            cell.walkSubView1Title.text = titleWalk3ProdTitle[0]
            cell.walkSubView1SubTitle.text = subTitleWalk3ProdTitle[0]
            cell.walkSubView2Img.image = UIImage(named: "icons8_sell")
            cell.walkSubView2Title.text = titleWalk3ProdTitle[1]
            cell.walkSubView2SubTitle.text = subTitleWalk3ProdTitle[1]
            cell.walkSubView3Img.image = UIImage(named: walkSub2ViewImg[2])
            cell.walkSubView3Title.text = titleWalk3ProdTitle[2]
            cell.walkSubView3SubTitle.text =  subTitleWalk3ProdTitle[3]
            cell.walkSubView3Height.constant = 55
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
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - CollectionView Methods -

extension MarketPlaceFirstTiimeVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //return StaticArrayData.kTutorialDict.count
    return 3
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getTutorialCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: kScreenWidth, height:kScreenHeight)
  }
}

extension MarketPlaceFirstTiimeVC: GetStartedDelegateWalk{
  
  
  func tapGetStarted(_ btn: UIButton, cell: WalkthroughCVC) {
    
    if btn == cell.btnNext{
      
      //let walkthroughArray = self.getWalkThroughViewModel.arrWalkThroughs.count
      let currentIndexPath = collectionViewTutorial.indexPath(for: cell)!
      if currentIndexPath.item < titleProdArray.count - 1{
        
        let indexPath = IndexPath(item: currentIndexPath.item+1, section: 0)
        self.collectionViewTutorial.scrollToItem(at: indexPath, at: .right, animated: true)
        self.collectionViewTutorial.reloadItems(at: [indexPath])
      }
      else{
          _ = self.pushViewController(withName: MarketplaceHomePageVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
      }
    }
      }

}


protocol GetStartedDelegateWalk {
  func tapGetStarted(_ btn: UIButton,cell: WalkthroughCVC) -> Void
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
    
    @IBOutlet weak var walkSubView1: UIView!
    @IBOutlet weak var walkSubView2: UIView!
    @IBOutlet weak var walkSubView3: UIView!
    
    @IBOutlet weak var walkSubView1Img: UIImageView!
    @IBOutlet weak var walkSubView1Title: UILabel!
    @IBOutlet weak var walkSubView1SubTitle: UILabel!
    @IBOutlet weak var walkSubView1Height: NSLayoutConstraint!
    
    
    @IBOutlet weak var walkSubView2Img: UIImageView!
    @IBOutlet weak var walkSubView2Title: UILabel!
    @IBOutlet weak var walkSubView2SubTitle: UILabel!
    @IBOutlet weak var walkSubView2Height: NSLayoutConstraint!
    
    @IBOutlet weak var walkSubView3Img: UIImageView!
    @IBOutlet weak var walkSubView3Title: UILabel!
    @IBOutlet weak var walkSubView3SubTitle: UILabel!
    @IBOutlet weak var walkSubView3Height: NSLayoutConstraint!
    
    
    
    var delegate: GetStartedDelegateWalk?
    
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
   
    
    override func layoutIfNeeded() {
      
      super.layoutIfNeeded()
     
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
      self.layoutIfNeeded()
    }
    
    //MARK: - IBAction -
    
    @IBAction func tapGetStarted(_ sender: UIButton) {
      self.delegate?.tapGetStarted(self.btnNext, cell: self)
    }
    
    @IBAction func tapSkip(_ sender: UIButton) {
      
      self.delegate?.tapGetStarted(self.btnNext, cell: self)
    }
    
}
