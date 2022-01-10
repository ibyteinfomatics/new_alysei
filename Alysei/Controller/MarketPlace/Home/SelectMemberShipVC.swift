//
//  SelectMemberShipVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/3/21.
//

import UIKit

class SelectMemberShipVC: AlysieBaseViewC {
   
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwTriangle: UIView!
    @IBOutlet weak var membershipCollectionView: UICollectionView!
    
    var selectedPassId: Int?

    var memberShipData : [Membership]?
    override func viewDidLoad() {
        super.viewDidLoad()
       // headerView.addShadow()
        vwContainer.addBorder()
        vwContainer.addShadow()
        headerView.drawBottomShadow()
        callMemberShipApi()
        setDownTriangle()
        //btnNext.isUserInteractionEnabled = false
        //btnFreeMemberShip.setImage(UIImage(named: "Ellipse 22"), for: .normal)
        //btnNext.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        btnNext.setTitleColor(UIColor.white, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func setDownTriangle(){
            let heightWidth = vwTriangle.frame.size.width
            let path = CGMutablePath()

            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
            path.addLine(to: CGPoint(x:heightWidth, y:0))
            path.addLine(to: CGPoint(x:0, y:0))

            let shape = CAShapeLayer()
            shape.path = path
        shape.fillColor = UIColor.init(hexString: "4BB3FD").cgColor

        vwTriangle.layer.insertSublayer(shape, at: 0)
        }
//    @IBAction func btnFreeMemberShipAction(_ sender: UIButton){
//        sender.isSelected = !sender.isSelected
//        self.btnFreeMemberShip.setImage((sender.isSelected == true) ? UIImage(named: "icons8_checkmark_2") : UIImage(named: "Ellipse 22"), for: .normal)
//        if sender.isSelected == true{
//            btnNext.layer.backgroundColor = UIColor.init(hexString: "#004577").cgColor
//            btnNext.isUserInteractionEnabled = true
//        }else{
//            btnNext.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
//            btnNext.isUserInteractionEnabled = false
//        }
//    }
    @IBAction func btnNextAction(_ sender: UIButton){
        guard let controller = pushViewController(withName: MarketPlaceCreateStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MarketPlaceCreateStoreVC else{return}
        controller.passpackageId = selectedPassId
    }
}
extension SelectMemberShipVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return memberShipData?.count ?? 0
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectMemberShipTableCell", for: indexPath) as? SelectMemberShipTableCell else {return UITableViewCell()}
      //  cell.selectionStyle = .none
       // let data = memberShipData?[indexPath.row]
       // cell.lblMemberShip.text = memberShipData?[indexPath.row].name
        //cell.btnCheck.setImage( data?.isSelected == true ? UIImage(named: "icons8_checkmark_2") : UIImage(named: "Ellipse 22"), for: .normal)
        self.selectedPassId = memberShipData?[0].marketplacePackageId
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for i in 0..<(memberShipData?.count ?? 0){
            memberShipData?[i].isSelected = false
        }
        memberShipData?[indexPath.row].isSelected = true
       // self.selectedPassId = memberShipData?[indexPath.row].marketplacePackageId
        self.tableView.reloadData()
        print("Select")
    }
}
extension SelectMemberShipVC {
    func callMemberShipApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetMemberShip, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"] as? [[String:Any]]{
                self.memberShipData = data.map({Membership.init(with: $0)})
                self.memberShipData?.first?.isSelected = true
                self.btnNext.isUserInteractionEnabled = true
                self.btnNext.layer.backgroundColor = UIColor.init(hexString: "#004577").cgColor
                self.btnNext.setTitleColor(UIColor.white, for: .normal)
            }
            self.tableView.reloadData()
        }
    }
}
class SelectMemberShipTableCell: UITableViewCell {
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblMemberShip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  btnCheck.setImage(UIImage(named: "Ellipse 22"), for: .normal)
    }
}



