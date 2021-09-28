//
//  HubListViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/15/21.
//

import UIKit



class HubListViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var stateWiseHubs: SelectdHubs?
    var selectCountryId: String?
    var arrStateWiseHub: StateHubModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.drawShadow()
        self.callStateWiseHubListApi()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDidntRecognizeHub(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HubStateListViewController") as? HubStateListViewController else {return}
        nextVC.selectCountryId = self.selectCountryId
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension HubListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrStateWiseHub?.hubs?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStateWiseHub?.hubs?[section].hubs_array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HubListTableViewCell", for: indexPath) as? HubListTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.configCell(arrStateWiseHub?.hubs?[indexPath.section].hubs_array?[indexPath.row] ?? SignUpOptionsDataModel(withDictionary: [:]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "\(arrStateWiseHub?.hubs?[section].state_name ?? "")"
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.textColor = .black
        headerView.layer.backgroundColor = UIColor.init(hexString: "#C8E9E9").cgColor
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}


extension HubListViewController{
    func callStateWiseHubListApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetStateWiseHub + "\(selectCountryId ?? "0")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.arrStateWiseHub = StateHubModel(with: data)
            }
            self.tableView.reloadData()
        }
    }
}
