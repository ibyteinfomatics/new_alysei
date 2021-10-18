//
//  ProducerDashboardViewController.swift
//  Dashboard
//
//  Created by mac on 20/09/21.
//

import UIKit
import DropDown

class ProducerDashboardViewController: AlysieBaseViewC {
    @IBOutlet weak var producerTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var connectionId = ""
    
    var arrProperty = [String]()
    var dashboardModel:DashboardModel?
    var dataDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        producerTableView.delegate = self
        producerTableView.dataSource = self
//        headerView.layer.masksToBounds = false
//        headerView.layer.shadowRadius = 2
//        headerView.layer.shadowOpacity = 0.2
//        headerView.layer.shadowColor = UIColor.lightGray.cgColor
//        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
//
        callDashboardApi(id: connectionId)
        
        

    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
        controller?.userLevel = .other
        controller?.userID = dashboardModel?.data?.userData?.userid
        // Your action
    }
    
    func callDashboardApi(id: String){
        self.producerTableView.isHidden = true
        //self.arrProperty.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDashboard+id, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
           
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.dashboardModel = DashboardModel.init(with: dictResponse)
                
            }
            
            
            
            self.producerTableView.isHidden = false
            self.producerTableView.reloadData()
            
            /*self.name.text = self.dashboardModel?.data?.userData?.companyName
            self.fdano.text = self.dashboardModel?.data?.userData?.fdaNo
            self.vatno.text = self.dashboardModel?.data?.userData?.vatNo
            self.reasontoconnect.text = self.dashboardModel?.data?.userData?.reasonToConnect
            
            if self.dashboardModel?.data?.userData?.avatarid?.attachmenturl != nil {
                self.userimg.setImage(withString: String.getString(kImageBaseUrl+(self.dashboardModel?.data?.userData?.avatarid?.attachmenturl)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
            }*/
                       
        }
    }
    
    @IBAction func backAccept(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func inviteApi(id: Int, type: Int){
        
        let params: [String:Any] = [
            "connection_id": id,
            "accept_or_reject": type]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kinvitationAcceptReject, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            self.navigationController?.popViewController(animated: true)

        }
        
    }
    


}
extension ProducerDashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return dashboardModel?.data?.certificates?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell: ProducerDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProducerDetailTableViewCell", for: indexPath) as? ProducerDetailTableViewCell else{return UITableViewCell()}
            cell.name.text = dashboardModel?.data?.userData?.companyName
            cell.reasontoconnect.text = dashboardModel?.data?.userData?.reasonToConnect
            cell.vatno.text = dashboardModel?.data?.userData?.vatNo
            cell.fdano.text = dashboardModel?.data?.userData?.fdaNo
            
            cell.userimg.layer.masksToBounds = false
            cell.userimg.clipsToBounds = true
            cell.userimg.layer.borderWidth = 2
            cell.userimg.layer.borderColor = UIColor.white.cgColor
            cell.userimg.layer.cornerRadius = cell.userimg.frame.width/2
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.userimg.isUserInteractionEnabled = true
            cell.userimg.addGestureRecognizer(tapGestureRecognizer)
            
            if self.dashboardModel?.data?.userData?.avatarid?.attachmenturl != nil {
                cell.userimg.setImage(withString: String.getString(kImageBaseUrl+(self.dashboardModel?.data?.userData?.avatarid?.attachmenturl ?? "")), placeholder: UIImage(named: "image_placeholder"))
            }
            
            
            cell.btnAcceptCallback = { tag in
                self.inviteApi(id: Int.getInt(self.connectionId), type: 1)
            }
            
            cell.btnDeclineCallback = { tag in
                self.inviteApi(id: Int.getInt(self.connectionId), type: 2)
            }
            
            return cell
        }
        else{
            guard let cell: BabyFoodDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BabyFoodDetailsTableViewCell", for: indexPath) as? BabyFoodDetailsTableViewCell else{return UITableViewCell()}
            
            cell.lblDocumentUpload.text = dashboardModel?.data?.certificates?[indexPath.row].option
            
            
            cell.propertyCallBack = {
                
                self.arrProperty.removeAll()
                for j in 0..<(self.dashboardModel?.data?.certificates![indexPath.row].productProperties?.count)!{
                        
                   self.arrProperty.append((self.dashboardModel?.data?.certificates![indexPath.row].productProperties![j].option)!)
                }
                
                self.dataDropDown.dataSource = self.arrProperty
                self.dataDropDown.show()
                //dataDropDown.anchorView = countryEvent
              //  self.dataDropDown.bottomOffset = CGPoint(x: 0, y: (self.dataDropDown.anchorView?.plainView.bounds.height)!)
                self.dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    
                    
                }
                 
            }
            
            cell.conservationCallBack = {
                
                
                
            }
            
            cell.openImageCallBack1 = {
                
                let story = UIStoryboard(name:"Chat", bundle: nil)
                let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                controller.url = String.getString(imageDomain+"/"+(self.dashboardModel?.data?.certificates?[indexPath.row].photoOfLabel)!)
                
                self.present(controller, animated: true)
            }
            
            cell.openImageCallBack2 = {
                
                let story = UIStoryboard(name:"Chat", bundle: nil)
                let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                controller.url = String.getString(imageDomain+"/"+(self.dashboardModel?.data?.certificates?[indexPath.row].fceSidCertification)!)
                
                self.present(controller, animated: true)
            }
            
            cell.openImageCallBack3 = {
                
                let story = UIStoryboard(name:"Chat", bundle: nil)
                let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                controller.url = String.getString(imageDomain+"/"+(self.dashboardModel?.data?.certificates?[indexPath.row].phytosanitaryCertificate)!)
                
                self.present(controller, animated: true)
            }
            
            cell.openImageCallBack4 = {
                
                let story = UIStoryboard(name:"Chat", bundle: nil)
                let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                controller.url = String.getString(imageDomain+"/"+(self.dashboardModel?.data?.certificates?[indexPath.row].packagingForUsa)!)
                
                self.present(controller, animated: true)
            }
            
            cell.openImageCallBack5 = {
                
                let story = UIStoryboard(name:"Chat", bundle: nil)
                let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                controller.url = String.getString(imageDomain+"/"+(self.dashboardModel?.data?.certificates?[indexPath.row].foodSafetyPlan)!)
                
                self.present(controller, animated: true)
            }
            
            cell.openImageCallBack6 = {
                
                let story = UIStoryboard(name:"Chat", bundle: nil)
                let controller = story.instantiateViewController(withIdentifier: "SeemImageVC") as! SeemImageVC
                controller.url = String.getString(imageDomain+"/"+(self.dashboardModel?.data?.certificates?[indexPath.row].animalHelathAslCertificate)!)
                
                self.present(controller, animated: true)
            }
            
            if dashboardModel?.data?.certificates?[indexPath.row].photoOfLabel == "" {
                cell.uiview1.constant =  0
            }
            
            if dashboardModel?.data?.certificates?[indexPath.row].fceSidCertification == "" {
                cell.uiview2.constant =  0
            }
            
            if dashboardModel?.data?.certificates?[indexPath.row].phytosanitaryCertificate == "" {
                cell.uiview3.constant =  0
            }
            
            if dashboardModel?.data?.certificates?[indexPath.row].packagingForUsa == "" {
                cell.uiview4.constant =  0
            }
            
            if dashboardModel?.data?.certificates?[indexPath.row].foodSafetyPlan == "" {
                cell.uiview5.constant =  0
            }
            
            if dashboardModel?.data?.certificates?[indexPath.row].animalHelathAslCertificate == "" {
                cell.uiview6.constant =  0
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
            
        }
            else {
                
                var checkSize = 20
                
                if dashboardModel?.data?.certificates?[indexPath.row].photoOfLabel == "" {
                    checkSize = checkSize + 90
                }
                
                if dashboardModel?.data?.certificates?[indexPath.row].fceSidCertification == "" {
                    checkSize = checkSize + 90
                }
                
                if dashboardModel?.data?.certificates?[indexPath.row].phytosanitaryCertificate == "" {
                    checkSize = checkSize + 90
                }
                
                if dashboardModel?.data?.certificates?[indexPath.row].packagingForUsa == "" {
                    checkSize = checkSize + 90
                }
                
                if dashboardModel?.data?.certificates?[indexPath.row].foodSafetyPlan == "" {
                    checkSize = checkSize + 90
                }
                
                if dashboardModel?.data?.certificates?[indexPath.row].animalHelathAslCertificate == "" {
                    checkSize = checkSize + 90
                }
                
                return CGFloat(660 - checkSize)
        }
    }
    
    
}
