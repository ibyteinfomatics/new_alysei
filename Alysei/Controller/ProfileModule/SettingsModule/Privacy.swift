//
//  Privacy.swift
//  Alysei
//
//  Created by Gitesh Dang on 12/10/21.
//

import UIKit
import DropDown

class Privacy: AlysieBaseViewC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnAge: UIButton!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var profile: UILabel!
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var privateMessage: UIButton!
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var weekly: UIButton!
    
    @IBOutlet weak var messagelabel: UILabel!
    @IBOutlet weak var followlabel: UILabel!
    @IBOutlet weak var weeklylabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var vwHeader: UIView!
    
    var msgpre,followpre,weeklypre: String!
    var connect : String!
    var connected = [String]()
    var privacyModel:PrivacyModel?
    
    var dataDropDown = DropDown()
    var arrData1 = ["Anyone","Followers","Connections","Nobody"]
    var arrData = ["Anyone","Followers","Connections","Just Me"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let openTap = UITapGestureRecognizer.init(target: self, action: #selector(openMessageLabel))
        self.messagelabel.addGestureRecognizer(openTap)
        
        let follow = UITapGestureRecognizer.init(target: self, action: #selector(openEmailLabel))
        self.followlabel.addGestureRecognizer(follow)
        
        let weekTap = UITapGestureRecognizer.init(target: self, action: #selector(openWeeklylabel))
        self.weeklylabel.addGestureRecognizer(weekTap)
        
        view1.layer.cornerRadius = 5
        view1.layer.borderWidth = 1
        view1.layer.borderColor = UIColor.darkGray.cgColor
        
        view3.layer.cornerRadius = 5
        view3.layer.borderWidth = 1
        view3.layer.borderColor = UIColor.darkGray.cgColor
        
        vwHeader.drawBottomShadow()
        tableView.dataSource = self
        tableView.delegate = self
        postRequestToPrivacy()
        // Do any additional setup after loading the view.
    }
    
    @objc func openMessageLabel(){
        self.privateMessage.setImage((msgpre == "1") ? UIImage(named: "icon_uncheckedBox") : UIImage(named: "icon_blueSelected"), for: .normal)
        
        self.messagelabel.textColor = msgpre == "1" ? UIColor.black : UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1)
        
        msgpre = msgpre == "1" ? "0" : "1"
    }
    
    @objc func openEmailLabel(){
        self.follow.setImage((followpre == "1") ? UIImage(named: "icon_uncheckedBox") : UIImage(named: "icon_blueSelected"), for: .normal)
        
        self.followlabel.textColor = followpre == "1" ? UIColor.black : UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1)
        
        followpre = followpre == "1" ? "0" : "1"
    }
    
    @objc func openWeeklylabel(){
        self.weekly.setImage((weeklypre == "1") ? UIImage(named: "icon_uncheckedBox") : UIImage(named: "icon_blueSelected"), for: .normal)
        
        self.weeklylabel.textColor = weeklypre == "1" ? UIColor.black : UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1)
        
        weeklypre = weeklypre == "1" ? "0" : "1"
    }
    
    @IBAction func btnmessage(_ sender: UIButton){
        
        self.privateMessage.setImage((msgpre == "1") ? UIImage(named: "icon_uncheckedBox") : UIImage(named: "icon_blueSelected"), for: .normal)
        
        self.messagelabel.textColor = msgpre == "1" ? UIColor.black : UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1)
        
        msgpre = msgpre == "1" ? "0" : "1"
        
    }
    
    @IBAction func btnfollow(_ sender: UIButton){
        
        self.follow.setImage((followpre == "1") ? UIImage(named: "icon_uncheckedBox") : UIImage(named: "icon_blueSelected"), for: .normal)
        
        self.followlabel.textColor = followpre == "1" ? UIColor.black : UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1)
        
        followpre = followpre == "1" ? "0" : "1"
        
    }
    
    
    @IBAction func btnweekly(_ sender: UIButton){
        
        self.weekly.setImage((weeklypre == "1") ? UIImage(named: "icon_uncheckedBox") : UIImage(named: "icon_blueSelected"), for: .normal)
        
        self.weeklylabel.textColor = weeklypre == "1" ? UIColor.black : UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1)
        
        weeklypre = weeklypre == "1" ? "0" : "1"
        
    }
    
    @IBAction func btnSave(_ sender: UIButton){
        savePrivacy()
    }
    
    @IBAction func btnmessageDropDown(_ sender: UIButton){
        openDropDown(button: btnMessage, text: message)
    }
    
    @IBAction func btnageDropDown(_ sender: UIButton){
        openDropDown(button: btnAge, text: age)
    }
    
    @IBAction func btnprofileDropDown(_ sender: UIButton){
        openDropDownProfile(button: btnProfile, text: profile)
    }
    
    @objc func openDropDown(button: UIButton, text : UILabel){
        dataDropDown.dataSource = self.arrData1
        dataDropDown.show()
        dataDropDown.anchorView = button
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            text.text = item
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    @objc func openDropDownProfile(button: UIButton, text : UILabel){
        dataDropDown.dataSource = self.arrData
        dataDropDown.show()
        dataDropDown.anchorView = button
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            //self.btnReport.setTitle(item, for: .normal)
            text.text = item
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    private func postRequestToPrivacy() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPrivacy, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.privacyModel = PrivacyModel.init(with: dictResponse!)
        
        //self.connect = self.privacyModel?.privacyData?.who_can_connect ?? ""
        self.connect = ""
        
        if self.privacyModel?.privacyData?.who_can_connect ?? "" != ""{
            
            if self.privacyModel?.privacyData?.who_can_connect?.count != 1 {
                let a = (self.privacyModel?.privacyData?.who_can_connect ?? "").split(separator: ",")
                
              
                for (index,value) in a.enumerated() {
                    self.connected.append(String(value))
                }
                
                //let b = (self.privacyModel?.privacyData?.who_can_connect ?? "").components(separatedBy: [","])
                
            } else {
                self.connected.append(String.getString(self.privacyModel?.privacyData?.who_can_connect))
            }
            
            let characterArray = self.connected.flatMap { $0 }
            let stringArray2 = characterArray.map { String($0) }
            self.connect = stringArray2.joined(separator: ",")
            
            
          //  print("chek---- ",self.connected)
            
            
        }
       
//        self.tableViewHeight.constant = CGFloat(43 * (self.privacyModel?.roles?.count ?? 0))
       
          self.message.text = self.privacyModel?.privacyData?.allow_message_from?.capitalized
          self.profile.text = self.privacyModel?.privacyData?.who_can_view_profile?.capitalized
        self.age.text = self.privacyModel?.privacyData?.who_can_view_age
        
        self.msgpre = self.privacyModel?.emailPreference?.private_messages
        self.followpre = self.privacyModel?.emailPreference?.when_someone_request_to_follow
        self.weeklypre = self.privacyModel?.emailPreference?.weekly_updates
        
        self.privateMessage.setImage((self.privacyModel?.emailPreference?.private_messages == "1") ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        
       
        self.follow.setImage((self.privacyModel?.emailPreference?.when_someone_request_to_follow == "1") ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        
        self.weekly.setImage((self.privacyModel?.emailPreference?.weekly_updates == "1") ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        
        self.messagelabel.textColor = self.privacyModel?.emailPreference?.private_messages == "1" ? UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1) : UIColor.black
        
        self.followlabel.textColor = self.privacyModel?.emailPreference?.when_someone_request_to_follow == "1" ? UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1) : UIColor.black
        
        self.weeklylabel.textColor = self.privacyModel?.emailPreference?.weekly_updates == "1" ? UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1) : UIColor.black
        
      
          self.tableView.reloadData()
      }
      
    }
    
    func savePrivacy(){
        
        let params: [String:Any] = [
            "allow_message_from": self.message.text!,
            "who_can_view_age": self.age.text!,
            "who_can_view_profile":self.profile.text!,
            "who_can_connect":connect!,
            "private_messages":msgpre!,
            "when_someone_request_to_follow":followpre!,
            "weekly_updates":weeklypre!]
            
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSavePrivacy, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                
                self.navigationController?.popViewController(animated: true)
                
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


extension Privacy: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableViewHeight.constant = CGFloat(35 * (self.privacyModel?.roles?.count ?? 0))
        return privacyModel?.roles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let productListCell = tableView.dequeueReusableCell(withIdentifier: "ProductListTViewCell", for: indexPath) as? ProductListTViewCell else{return UITableViewCell()}
        let data = privacyModel?.roles?[indexPath.row]
        
        productListCell.lblProductName.text = data?.name
        
        if connected.contains(String.getString(data?.roleId)) {
            productListCell.lblProductName.textColor = UIColor(red: 75/256, green: 179/256, blue: 253/256, alpha: 1)
            productListCell.btnCheckBox.setImage(UIImage(named: "icon_blueSelected"), for: .normal)
        } else {
            productListCell.lblProductName.textColor = UIColor.black
            productListCell.btnCheckBox.setImage(UIImage(named: "icon_uncheckedBox"), for: .normal)
        }
        
       // productListCell.btnCheckBox.setImage((data?.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        return productListCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let id = String.getString(privacyModel?.roles?[indexPath.row].roleId)
            if connected.contains(String.getString(privacyModel?.roles?[indexPath.row].roleId)) {
                
                connected.removeAll { $0 == id }
            } else {
                
                self.connected.append(id)
            }
        
            let characterArray = connected.flatMap { $0 }
            let stringArray2 = characterArray.map { String($0) }
            connect = connected.joined(separator: ",")
        
        print("connect ",connect!)
                        
            tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    
    
}
