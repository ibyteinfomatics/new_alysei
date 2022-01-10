//
//  SelectMultiMemberShipVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 1/10/22.
//

import UIKit

class SelectMultiMemberShipVC: AlysieBaseViewC {
    
    @IBOutlet weak var memberShipCollectionview: UICollectionView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var headerView: UIView!
    var memberShipData : [Membership]?
    var selectedPassId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // headerView.addShadow()
        
        headerView.drawBottomShadow()
        callMemberShipApi()
        btnNext.setTitleColor(UIColor.white, for: .normal)
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNextAction(_ sender: UIButton){
        guard let controller = pushViewController(withName: MarketPlaceCreateStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MarketPlaceCreateStoreVC else{return}
        controller.passpackageId = selectedPassId
    }

}

extension SelectMultiMemberShipVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((memberShipData?.count ?? 0) + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = memberShipCollectionview.dequeueReusableCell(withReuseIdentifier: "SelectMembershipCollectionViewCell", for: indexPath) as? SelectMembershipCollectionViewCell else{return UICollectionViewCell()}
        cell.configCell(memberShipData ?? [Membership]())
        if indexPath.row < (memberShipData?.count ?? 0) {
            cell.tableView.isHidden = false
            cell.lblMemberShip.text = memberShipData?[indexPath.row].name
        }else{
            cell.tableView.isHidden = true
            cell.lblMemberShip.text = "Coming Soon....."
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.memberShipCollectionview.frame.width - 20, height:  self.memberShipCollectionview.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedPassId = memberShipData?[0].marketplacePackageId
    }
}
extension SelectMultiMemberShipVC {
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
            self.memberShipCollectionview.reloadData()
        }
    }
}
class SelectMembershipCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwTriangle: UIView!
    @IBOutlet weak var lblMemberShip: UILabel!
    var memberShipData: [Membership]?

    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addBorder()
        vwContainer.addShadow()
        setDownTriangle()
    }
    
    func configCell(_ data: [Membership]){
       self.memberShipData = data
        self.tableView.reloadData()
        
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
}

extension SelectMembershipCollectionViewCell : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return memberShipData?.count ?? 0
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectMemberShipTableCell", for: indexPath) as? SelectMemberShipTableCell else {return UITableViewCell()}
        cell.selectionStyle = .none
      //self.selectedPassId = memberShipData?[0].marketplacePackageId
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
