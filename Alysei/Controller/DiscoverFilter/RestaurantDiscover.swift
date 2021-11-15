//
//  RestaurantDiscover.swift
//  Alysei
//
//  Created by Gitesh Dang on 09/11/21.
//

import UIKit

class RestaurantDiscover: AlysieBaseViewC {
    
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var vwHeader: UIView!
    var restModel:RestaurantModel?
    var restId: String?

    var passHubs: String?
    var passRestType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        restId = "restaurants"
        postRequestToGetRestaurant()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
        let controller = pushViewController(withName: RestaurantFilterVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? RestaurantFilterVC
        controller?.passHubs = self.passHubs
        controller?.passRestType = self.passRestType
        controller?.passSelectedDataCallback = {  passHubs, passRestType in
            self.passHubs = String.getString(passHubs)
            self.passRestType = String.getString(passRestType)
            self.callFilterApi ()
        }
        
        controller?.clearFiltercCallBack = {
            self.passHubs = ""
            self.passRestType = ""
            self.callFilterApi()
        }
        
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getBlogTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let restTableCell = tripsTableView.dequeueReusableCell(withIdentifier: BlogsTableViewCell.identifier()) as! BlogsTableViewCell
        
        restTableCell.blogTitle.text = restModel?.data?[indexPath].restaurantName
        restTableCell.blogDescription.text = restModel?.data?[indexPath].address
        
       
        restTableCell.blogImage.layer.masksToBounds = false
        restTableCell.blogImage.clipsToBounds = true
        restTableCell.blogImage.layer.cornerRadius = 5
        
        
        if restModel?.data?[indexPath].avatarid?.attachmenturl != nil {
            restTableCell.blogImage.setImage(withString: String.getString(kImageBaseUrl+(restModel?.data?[indexPath].avatarid?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        } else {
            restTableCell.blogImage.image = UIImage(named: "image_placeholder")
        }
        
        
        
        return restTableCell
        
    }
    
    private func postRequestToGetRestaurant() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(restId!)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
        let dictResponse = dictResponse as? [String:Any]
      if let data = dictResponse?["data"] as? [String:Any]{
        self.restModel = RestaurantModel.init(with: data)
      }
      
        self.tripsTableView.reloadData()
      }
      
    }
    
}

extension RestaurantDiscover: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getBlogTableCell(indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        controller?.userID = self.restModel?.data?[indexPath.row].userid
    }
    
}
extension RestaurantDiscover {
    
    func callFilterApi () {
        self.restModel = RestaurantModel(with: [:])
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kDiscoverRestaurantSearch + "&hubs=" + String.getString(self.passHubs)+"&restaurant_type="+String.getString(self.passRestType), requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let dictResponse = dictResponse as? [String:Any]
          if let data = dictResponse?["data"] as? [String:Any]{
            self.restModel = RestaurantModel.init(with: data)
          }
          
            self.tripsTableView.reloadData()
              
        }
        
    }
}
