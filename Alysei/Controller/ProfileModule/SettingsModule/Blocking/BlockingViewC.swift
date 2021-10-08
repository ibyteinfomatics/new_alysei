//
//  BlockingViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 20/01/21.
//

import UIKit

class BlockingViewC: AlysieBaseViewC {

  //MARK: - Properties -
    
  //let data = [(image: "select_role1", name: "Joshua Rawson", status: "Blocked. Tap to Unblock")]
    
  //MARK: - IBOutlet -
    
  @IBOutlet weak var tblViewBlocking: UITableView!
  @IBOutlet weak var viewShadow: UIView!
    
  var blockModel:BlockModel?
  
  //MARK:  - ViewLifeCycle Methods -
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tblViewBlocking.tableFooterView = UIView()
    blockList()
  }
  
  override func viewDidLayoutSubviews(){
    
    super.viewDidLayoutSubviews()
    self.viewShadow.drawBottomShadow()
  }
  
  //MARK:  - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
    
    private func blockList() -> Void{
      
        self.blockModel?.data?.removeAll()
        self.tblViewBlocking.reloadData()
        disableWindowInteraction()
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kBlockList, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
            
            self.blockModel = BlockModel.init(with: dictResponse)
          
            self.tblViewBlocking.reloadData()
        }
      
    }
    
    
    private func unBlock(id: String) -> Void{
        
        let params: [String:Any] = [
            "block_user_id": id]
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kUnBlockUser, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
        self.blockList()
      }
      
    }
    
  
  //MARK:  - Private Methods -
  
  private func getBlockingTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let blockingTableCell = tblViewBlocking.dequeueReusableCell(withIdentifier: BlockingTableCell.identifier()) as! BlockingTableCell
    
    if blockModel?.data?[indexPath.row].blockuser?.companyName == "" {
        blockingTableCell.lblBlockingName.text = blockModel?.data?[indexPath.row].blockuser?.restaurantName
    }  else if blockModel?.data?[indexPath.row].blockuser?.restaurantName == "" {
        blockingTableCell.lblBlockingName.text = blockModel?.data?[indexPath.row].blockuser?.companyName
    }
    
    
    blockingTableCell.lblBlockingStatus.text = "Blocked. Tap to Unblock"
    
    blockingTableCell.imgViewBlocking.layer.masksToBounds = false
    blockingTableCell.imgViewBlocking.clipsToBounds = true
    blockingTableCell.imgViewBlocking.contentMode = .scaleToFill
    blockingTableCell.imgViewBlocking.layer.cornerRadius = blockingTableCell.imgViewBlocking.frame.width/2
    
    if blockModel?.data?[indexPath.row].blockuser?.avatarid?.attachmenturl != nil {
        blockingTableCell.imgViewBlocking.setImage(withString: String.getString(kImageBaseUrl+(blockModel?.data?[indexPath.row].blockuser?.avatarid?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
    }
    
    return blockingTableCell
  }
    
    
    
}

//MARK:  - TableViewMethods -

extension BlockingViewC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return blockModel?.data?.count ?? 0
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return self.getBlockingTableCell(indexPath)
    }
      
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var name = ""
        
        if blockModel?.data?[indexPath.row].blockuser?.companyName == nil {
            name = blockModel?.data?[indexPath.row].blockuser?.restaurantName ?? ""
        } else {
            name = blockModel?.data?[indexPath.row].blockuser?.companyName ?? ""
        }
        
        print(blockModel?.data?[indexPath.row].blockuser?.companyName ?? "")
        
        //MARK:show Alert Message
        let refreshAlert = UIAlertController(title: "Are You Sure?", message: "You want to unblock "+name, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.view.superview?.isUserInteractionEnabled = false
        
        refreshAlert.addAction(UIAlertAction(title: "Unblock", style: .destructive, handler: { (action: UIAlertAction!) in
            self.unBlock(id: String.getString(self.blockModel?.data?[indexPath.row].blockuser?.userid))
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
             
            
        }))
        //let parent = self.parentViewController?.presentedViewController as? HubsListVC
        self.parent?.present(refreshAlert, animated: true, completion: nil)
        
        
    }
    
}

