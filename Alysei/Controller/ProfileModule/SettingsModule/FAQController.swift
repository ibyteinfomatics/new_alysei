//
//  FAQController.swift
//  Alysei
//
//  Created by Gitesh Dang on 08/03/22.
//

import UIKit

class FAQController: AlysieBaseViewC {

    @IBOutlet weak var headerlabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    var hiddenSections = Set<Int>()
       let tableViewData = [[""]]

    var faqModel:FaqModel?
    var faqData=[FaqData]()
    var indexOfPageToRequest = 1
    var lastPage: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerlabel.text = AppConstants.FAQ
       
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view.
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        getFaq()
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
      
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
                self.indexOfPageToRequest += 1

            // call your API for more data
                self.getFaq()

            // tell the table view to reload with the new data
            self.tableview.reloadData()
            }
        }
    }
    
    private func getFaq() -> Void{
      
      disableWindowInteraction()
        //self.faqData.removeAll()
        let params: [String:Any] = [
            "role_id": String.getString(kSharedUserDefaults.loggedInUserModal.memberRoleId),
            "page": indexOfPageToRequest]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kFaq, requestMethod: .GET, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
            let dictResponse = dictResponse as? [String:Any]
            // let outerData = dictResponse?["data"] as? [String:Any]
            
            
            if let data = dictResponse?["data"] as? [String:Any]{
                
                self.lastPage = data["last_page"] as? Int
                self.faqModel = FaqModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.faqData.removeAll()}
                self.faqData.append(contentsOf: self.faqModel?.data ?? [FaqData(with: [:])])
                
            }
            
            
            self.tableview.reloadData()
            
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

extension FAQController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//            return self.faqModel?.count ?? 0
//        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
            return self.faqData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FaqTableViewCell", for: indexPath) as? FaqTableViewCell else {return UITableViewCell()}
            let data = self.faqData[indexPath.row]
            cell.selectionStyle = .none
            cell.lblHeading?.text = self.faqData[indexPath.row].question
            cell.lblAnswer?.text = self.faqData[indexPath.row].answer
          //  self.faqModel?[indexPath.row].isExpand = false
            
           
            cell.btnExpand.tag = indexPath.row
            cell.expandCallback = { isExpand, index in
                for i in 0..<(self.faqData.count){
                    //self.faqData[i].isExpand = false
                }
                if self.faqData[index].isExpand == false {
                    data.isExpand = true
                }else{
                    data.isExpand = false
                }
                let rIndexPath = IndexPath(row: index, section: 0)
                tableView.reloadRows(at: [rIndexPath], with: .none)
            }
            
            cell.configCell(self.faqData[indexPath.row] ?? FaqData(with: [:]))
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
//
//        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let sectionButton = UIButton()
//            sectionButton.contentHorizontalAlignment = .left
//            sectionButton.titleEdgeInsets.left = 20
//            sectionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//            sectionButton.setTitleColor(UIColor.black, for: .normal)
//            sectionButton.setTitle(String(self.faqModel?[section].question ?? ""),
//                                   for: .normal)
//            //sectionButton.backgroundColor = .systemBlue
//            sectionButton.tag = section
//
//            return sectionButton
//        }
        
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
}

class FaqTableViewCell: UITableViewCell{
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var view: UIView!
    
    var expandCallback:((Int,Int) -> Void)? = nil
    var isExpand = 0
    
    //0 - lines 0
    //1 - expand lines
    
    @IBAction func btnExpand(_ sender: UIButton){
        if isExpand == 0 {
            isExpand = 1
        }else{
            isExpand = 0
        }
        expandCallback?(isExpand, sender.tag)
    }
    
    func configCell(_ data: FaqData){
        view.layer.cornerRadius = 5
        if data.isExpand == true {
            lblAnswer.numberOfLines = 1
            lblAnswer.isHidden = true
            //
            
            btnExpand.setImage(UIImage(systemName: "chevron.right"), for: .normal)

        }else{
            lblAnswer.numberOfLines = 0
            lblAnswer.isHidden = false
            btnExpand.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        
    }
}
