//
//  ShowHubSelectionTableViewCell.swift
//  Alysie
//
//  Created by Gitesh Dang on 04/03/21.
//

import UIKit



class ShowHubSelectionTableViewCell: UITableViewCell {
    
    //MARK:- @IBOutlets
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labeCountryName: UILabel!
    @IBOutlet weak var btnRemoveHub: UIButton!
    @IBOutlet weak var btnRemoveHubIcon: UIButton!
    @IBOutlet weak var btnEditSelection: UIButton!
    @IBOutlet weak var btnEditHubIcon: UIButton!
    //@IBOutlet weak var vwCollectionHght: NSLayoutConstraint!
    
    var selectedHub:SelectdHubs?{didSet{self.awakeFromNib()}}
    var reviewSelectedHub: ReviewSelectedHub?
    //var reviewSendSelectedHub = [ReviewHubModel.reviewHubCityArray]()
    var reviewSelectedHubCityArray =  [String]()
    var addRemoveCallback : (((Int)->Void)?) = nil
    let columnLayout = CustomViewFlowLayout()
    var roleId: String?
    var isEditHub:Bool?
    var hubContainIndex: Bool?
    var cityIndex = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        //MARK:- Call func
        btnEditSelection.setTitle(LogInSignUp.kEditSelection, for: .normal)
        btnRemoveHub.setTitle(LogInSignUp.kRemove, for: .normal)
        self.initialSetup()
        //MARK:- Register XIB
        collectionView.register(UINib(nibName: HubNameCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: "HubNameCollectionViewCell")
        //        if #available(iOS 10.0, *) {
        //            columnLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //        } else {
        //            columnLayout.estimatedItemSize = CGSize(width: 41, height: 51)
        //        }
        
        //collectionView.collectionViewLayout = columnLayout
    }
    //MARK:- INTIIAL SETUP
    
    func initialSetup(){
        //        self.containerView.layer.borderColor = UIColor.lightGray.cgColor
        //        self.containerView.layer.borderWidth = 1
        //        self.containerView.layer.cornerRadius = 10
        if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "4" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "5" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "6" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "9") {
            self.btnRemoveHub.isHidden = true
            self.btnRemoveHubIcon.isHidden = true
            //MARK: Hide Edit button
            self.btnEditHubIcon.isHidden = true
            self.btnEditSelection.isHidden = true
        }else{
            //MARK: Change
            
            // self.btnRemoveHub.isHidden = false
            // self.btnRemoveHubIcon.isHidden = false
            
            self.btnRemoveHub.isHidden = true
            self.btnRemoveHubIcon.isHidden = true
            self.btnEditHubIcon.isHidden = true
            self.btnEditSelection.isHidden = true
        }
        
    }
    
    //MARK: private func
    
    private func getHubNameCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        let hubNameTableCell = collectionView.dequeueReusableCell(withReuseIdentifier: HubNameCollectionViewCell.identifier(), for: indexPath) as! HubNameCollectionViewCell
        hubNameTableCell.lblHubImage.layer.cornerRadius = 12
        hubNameTableCell.vwContainer.layer.cornerRadius = 12
        hubNameTableCell.vwOverlayContainer.layer.cornerRadius = 12
        hubNameTableCell.btnDelete.tag = indexPath.row
        
        hubNameTableCell.callback = { index in
            if self.isEditHub == true{
                //let hub = self.reviewSelectedHub.
                let hub = self.reviewSelectedHubCityArray[index]
                
                let parentVC = self.parentViewController as? ConfirmSelectionVC
                parentVC?.removeHubInCaseOfEdit(hub)
                self.reviewSelectedHubCityArray.remove(at: index)
            }else{
                self.selectedHub?.hubs.remove(at: index)
            }
            self.collectionView.reloadData()
            
        }
        if isEditHub == true{
            self.labeCountryName.text = self.reviewSelectedHub?.country_name
            
            hubNameTableCell.lblNAme.text = reviewSelectedHubCityArray[indexPath.row]
            let totalcount = ((reviewSelectedHub?.hubs?.count ?? 0) + (reviewSelectedHub?.cities?.count ?? 0))
            
            //                for j in (0..<(reviewSelectedHub?.hubs?.count ?? 0)){
            //                    if reviewSelectedHubCityArray[indexPath.row] == reviewSelectedHub?.hubs?[j].title{
            //                        hubContainIndex = true
            //                    }else{
            //                        hubContainIndex = false
            //                    }
            //                }
            
            for j in (0..<(reviewSelectedHub?.hubs?.count ?? 0)){
                if reviewSelectedHubCityArray[indexPath.row] == reviewSelectedHub?.hubs?[j].title{
                    //hubNameTableCell.lblHubImage.isHidden = false
                    //                    hubNameTableCell.imgLeading.constant = 10
                    //                    hubNameTableCell.imgTrailing.constant = 10
                    //                    hubNameTableCell.imageWidth.constant = 25
                    hubNameTableCell.lblHubImage.setImage(withString: self.reviewSelectedHub?.hubs?[j].image?.fimageUrl ?? "")
                   // hubNameTableCell.lblCountryState.text = (self.reviewSelectedHub?.country_name ?? "") + "/" + (self.reviewSelectedHub?.hubs?[j].state?.name ?? "")
                    hubNameTableCell.lblCountryState.text = (self.reviewSelectedHub?.hubs?[j].state?.name ?? "")
                    hubNameTableCell.vwContainer.backgroundColor = UIColor.clear
                }
            }
            for k in (0..<(reviewSelectedHub?.cities?.count ?? 0)){
                if reviewSelectedHubCityArray[indexPath.row] == reviewSelectedHub?.cities?[k].city?.name{
                    hubNameTableCell.lblHubImage.isHidden = true
                    hubNameTableCell.vwContainer.backgroundColor = UIColor.init(hexString: "#004577")
                   // hubNameTableCell.lblCountryState.text = (self.reviewSelectedHub?.country_name ?? "") + "/" + (self.reviewSelectedHub?.cities?[k].state?.name ?? "")
                    hubNameTableCell.lblCountryState.text = (self.reviewSelectedHub?.cities?[k].state?.name ?? "")
                    //  hubNameTableCell.lblHubImage.image = UIImage(named: "city")
                    //                            hubNameTableCell.imgLeading.constant = 7
                    //                            hubNameTableCell.imgTrailing.constant = 0
                    //                            hubNameTableCell.imageWidth.constant = 0
                }
            }
            
            //            if self.selectedHub?.hubs[indexPath.row].image?.fimageUrl == "" {
            //                hubNameTableCell.imgLeading.constant = 7
            //                hubNameTableCell.imgTrailing.constant = 0
            //                hubNameTableCell.imageWidth.constant = 0
            //
            //            }else{
            //                hubNameTableCell.imgLeading.constant = 10
            //                hubNameTableCell.imgTrailing.constant = 10
            //                hubNameTableCell.imageWidth.constant = 25
            //            hubNameTableCell.lblHubImage.setImage(withString: self.selectedHub?.hubs[indexPath.row].image?.fimageUrl ?? "")
            //            }
            // hubNameTableCell.lblNAme.sizeToFit()
        }else{
          
            let hub = self.selectedHub?.hubs[indexPath.row]
            self.labeCountryName.text = self.selectedHub?.country.name
           // hubNameTableCell.lblCountryState.text = (self.selectedHub?.country.name ?? "") + "/" + (hub?.state?.name ?? "")
            hubNameTableCell.lblCountryState.text = (hub?.state?.name ?? "")
            if (hub?.image?.fimageUrl == "" || hub?.image?.fimageUrl == nil){
                hubNameTableCell.lblHubImage.isHidden = true
                hubNameTableCell.vwContainer.backgroundColor = UIColor.init(hexString: "#004577")
                //  hubNameTableCell.lblHubImage.image = UIImage(named: "city")
                // hubNameTableCell.imgLeading.constant = 7
                //                hubNameTableCell.imgTrailing.constant = 0
                //                hubNameTableCell.imageWidth.constant = 0
                
            }else{
                hubNameTableCell.lblHubImage.isHidden = false
                hubNameTableCell.vwContainer.backgroundColor = UIColor.clear
                //                hubNameTableCell.imgLeading.constant = 10
                //                hubNameTableCell.imgTrailing.constant = 10
                //                hubNameTableCell.imageWidth.constant = 25
                hubNameTableCell.lblHubImage.setImage(withString: hub?.image?.fimageUrl ?? "")
            }
            
            hubNameTableCell.lblNAme.text = hub?.name
            //  hubNameTableCell.lblNAme.sizeToFit()
        }
        return hubNameTableCell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //MARK: IBACTIONS
    
    @IBAction func removeAllHub(_ sender: UIButton){
        
        self.addRemoveCallback?(sender.tag)
    }
    
    @IBAction func addHub(_ sender: UIButton){
        self.addRemoveCallback?(sender.tag)
    }
}

extension ShowHubSelectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditHub == true {
            
            return self.reviewSelectedHubCityArray.count
        }else{
            return selectedHub?.hubs.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getHubNameCollectionCell(indexPath)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if isEditHub == true{
//            //let hub = self.reviewSelectedHub.
//            let hub = self.reviewSelectedHubCityArray[indexPath.row]
//
//            let parentVC = self.parentViewController as? ConfirmSelectionVC
//            parentVC?.removeHubInCaseOfEdit(hub)
//            self.reviewSelectedHubCityArray.remove(at: indexPath.row)
//        }else{
//            self.selectedHub?.hubs.remove(at: indexPath.row)
//        }
//        self.collectionView.reloadData()
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // dataArary is the managing array for your UICollectionView.
        //        let item = self.selectedHub?.hubs[indexPath.row].name
        //
        //        guard let itemSize = item?.size(withAttributes: [
        //            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
        //        ]) else { return CGSize(width: 0, height: 0) }
        //
        //         return itemSize
        
        //return CGSize(width: (collectionView.frame.width / 2 - 25), height: 170)
        //        if isEditHub == true {
        //
        //            self.vwCollectionHght.constant = CGFloat(90 * (self.reviewSelectedHubCityArray.count))
        //        }else{
        //            self.vwCollectionHght.constant = CGFloat(90 * (selectedHub?.hubs.count ?? 0))
        //        }
        return CGSize(width: (self.collectionView.frame.width), height: 90)
    }
    
}


class CustomViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 0.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
