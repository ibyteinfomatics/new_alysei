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
    
    var awardModel:AwardModel?
    var userId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        awardCollectionView.delegate = self
        awardCollectionView.dataSource = self
        createAwardButton.layer.cornerRadius = 18
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        postRequestToGetAward()
    }
    
    @IBAction func create(_ sender: UIButton) {
      
        check = "create"
        _ = pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome)
      
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
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kAwardList, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.awardModel = AwardModel.init(with: dictResponse)
        
        self.countLabel.text = "Awards (\(self.awardModel?.data?.count ?? 0))"
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
        
        
        if let attributedString = self.createAttributedString(stringArray: ["Winning Product: ", "\( awardModel?.data?[indexPath.item].winningProduct ?? "" )"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) {
                   
            cell.winningproduct.attributedText = attributedString//awardModel?.data?[indexPath.item].winningProduct
                
        }
        
      
        
        cell.rewardImage.layer.cornerRadius = 10
        cell.rewardImage.setImage(withString: String.getString(kImageBaseUrl+(awardModel?.data?[indexPath.item].attachment?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: 320)
    }
    
    
}
