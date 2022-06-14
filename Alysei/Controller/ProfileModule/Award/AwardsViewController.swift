//
//  AwardsViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 9/24/21.
//

import UIKit

class AwardsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var createAwardButton: UIButton!
    @IBOutlet weak var awardCollectionView: UICollectionView!
    @IBOutlet weak var vwBlank: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBlank: UILabel!
    var awardModel:AwardModel?
    var userId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = AppConstants.kAwards
        createAwardButton.setTitle(AppConstants.kAddAwards, for: .normal)
        lblBlank.text = AppConstants.kThereAreNoAwardAtThisMoment
        awardCollectionView.delegate = self
        awardCollectionView.dataSource = self
        createAwardButton.layer.cornerRadius = 18
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userId != ""{
            createAwardButton.isHidden = true
        } else {
            createAwardButton.isHidden = false
        }
        postRequestToGetAward()
    }
    
    @IBAction func create(_ sender: UIButton) {
      
        check = "create"
        _ = pushViewController(withName: AddAward.id(), fromStoryboard: StoryBoardConstants.kHome)
      
    }
    
    func setUI(){
        if self.awardModel?.data?.count ?? 0 == 0{
            self.vwBlank.isHidden = false
        }else{
            self.vwBlank.isHidden = true
        }
    }
    
    private func postRequestToGetAward() -> Void{
      
      disableWindowInteraction()
    
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kAwardList + userId , requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.awardModel = AwardModel.init(with: dictResponse)
        
            self.countLabel.text = AppConstants.kAwards + " " + "(\(self.awardModel?.data?.count ?? 0))"
        self.setUI()
        self.awardCollectionView.reloadData()
      }
      
    }
   
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AwardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return awardModel?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.awardCollectionView.dequeueReusableCell(withReuseIdentifier: "AwardCell", for: indexPath) as? AwardCell else {
            return UICollectionViewCell()
        }
        cell.competitionName.text = awardModel?.data?[indexPath.item].awardName
        
        if userId != ""{
            cell.deleteButton.isHidden = true
            cell.editButton.isHidden = true
        }
        
        cell.winningproduct.text = "Winning Product: \(awardModel?.data?[indexPath.item].winningProduct ?? "" )"
        
        /*if let attributedString = self.createAttributedString(stringArray: ["Winning Product: ", "\( awardModel?.data?[indexPath.item].winningProduct ?? "" )"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) {
                   
            cell.winningproduct.attributedText = attributedString//awardModel?.data?[indexPath.item].winningProduct
                
        }*/
        
        if awardModel?.data?[indexPath.item].medal?.name == "Silver"{
            cell.awardimg.image = UIImage(named: "silver")
        } else if awardModel?.data?[indexPath.item].medal?.name == "Gold"{
            cell.awardimg.image = UIImage(named: "gold")
        } else if awardModel?.data?[indexPath.item].medal?.name == "Bronze"{
            cell.awardimg.image = UIImage(named: "bronze")
        }else if  awardModel?.data?[indexPath.item].medal?.name == "Winner"{
            cell.awardimg.image = UIImage(named: "Winner")
        }
        
        
        cell.rewardImage.layer.cornerRadius = 10
        let baseUrl = awardModel?.data?[indexPath.item].attachment?.baseUrl ?? ""
        cell.rewardImage.setImage(withString: String.getString(baseUrl+(awardModel?.data?[indexPath.item].attachment?.attachmenturl)! ), placeholder: UIImage(named: "image_placeholder"))
        
        
        cell.btnEditCallback = { tag in
            
            let vc = self.pushViewController(withName: AddAward.id(), fromStoryboard: StoryBoardConstants.kHome) as! AddAward
            vc.typeofpage = "edit"
            vc.award_id = self.awardModel?.data?[indexPath.item].awardid
            vc.eventName = self.awardModel?.data?[indexPath.item].awardName
            vc.productName = self.awardModel?.data?[indexPath.item].winningProduct
            vc.placeName = self.awardModel?.data?[indexPath.item].medal?.name
            vc.medal_id = String.getString(self.awardModel?.data?[indexPath.item].medal?.medal_id)
            vc.url = self.awardModel?.data?[indexPath.item].competitionurl
            vc.imgurl = String.getString(baseUrl+(self.awardModel?.data?[indexPath.item].attachment?.attachmenturl)! )
            
        }
        
        cell.btnDeleteCallback = { tag in
            
            
            //MARK:show Alert Message
            let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to delete this Award?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
               
                self.disableWindowInteraction()
                
                let params: [String:Any] = [
                    "award_id": String.getString(self.awardModel?.data?[indexPath.item].awardid)]
               
                //CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kAwardCreate, image: [:], controller: self, type: 0)
              
                TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kAwardDelete, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                    
                    self.postRequestToGetAward()
                }
                
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                  
                self.parent?.dismiss(animated: true, completion: nil)
            }))
            //let parent = self.parentViewController?.presentedViewController as? HubsListVC
            self.parent?.present(refreshAlert, animated: true, completion: nil)
            
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: 280)
    }
    
    
}
