//
//  SelectCityTableViewCell.swift
//  Alysie
//
//  Created by Gitesh Dang on 03/03/21.
//

import UIKit

class SelectCityTableViewCell: UITableViewCell {
    
    //MARK: IBOUtlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var buttonLeftCheckbox: UIButton!
    @IBOutlet weak var buttonRightCheckBox: UIButton!
    @IBOutlet weak var buttonLeftCheckWidth: NSLayoutConstraint!
    @IBOutlet weak var buttonLeftHeight: NSLayoutConstraint!
   // @IBOutlet weak var imageHub: ImageLoader!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var buttonLeftLeading: NSLayoutConstraint!
    @IBOutlet weak var buttonLeftCentreVertical: NSLayoutConstraint!
    @IBOutlet weak var imgHub: UIImageView!
    
   // @IBOutlet weak var checkMarkView: Checkmark!
    
    var leftBtnCallBack: ((String,String,Bool,Int) -> Void)? = nil
    var rightBtnCallBack: ((UIButton) -> Void)? = nil
    var data : CountryHubs?
    var index: Int?
    var selectState:String?
    var selectStateId: String?
    var hubLongitude: String?
    var hubLatitude: String?
    var hubRadius: Int?
    
    var checkCase: CountryCityHubSelection?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initialSetup()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: Initial Functions
    func initialSetup(){
        viewContainer.layer.shadowColor = UIColor.lightGray.cgColor
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.shadowOffset = .zero
        viewContainer.layer.shadowRadius = 1

    }
   
    func configCell(_ data: CountryHubs?, _ index: Int, _ checkCase:CountryCityHubSelection ){
        self.data = data
        buttonLeftCheckbox.isHidden = false
       // buttonLeftCheckWidth.constant = 20
       labelCityName.text = data?.name
        self.imgHub.layer.cornerRadius = 15
        self.imgHub.setImage(withString: String.getString(data?.image?.baseUrl) + String.getString(data?.image?.attachmentUrl))
        self.buttonLeftCheckbox.setImage((data?.isSelected == true) ? UIImage(named: "icon_blueSelected") : UIImage(named: "icon_uncheckedBox"), for: .normal)
        self.buttonRightCheckBox.isHidden = hideEyeIcon == true ? true : false
        self.buttonLeftCheckWidth.constant = hideEyeIcon == true ? 25 : 12
        self.buttonLeftHeight.constant = hideEyeIcon == true ? 25 : 12
        
        self.buttonLeftLeading.constant = hideEyeIcon == true ? 15 : 28
        self.buttonLeftCentreVertical.constant = hideEyeIcon == true ? 0 : 6
        self.imgHub.isHidden = hideEyeIcon == true ? true : false
    }
    
    @IBAction func btnLeftCheckBoxAction(_ sender: UIButton){
        self.selectState = data?.name
        //self.leftBtnCallBack?(selectState ?? "",data?.id ?? "",sender.isSelected,sender.tag)
    }
    @IBAction func btnRightCheckBoxAction(_ sender: UIButton){
        guard let nextVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "MapViewC") as? MapViewC else{return}

        nextVC.fromVC = .locateHub
        
        
        nextVC.hubLatCordinate = Double.getDouble(self.hubLatitude)
        nextVC.hubLongCordinate = Double.getDouble(self.hubLongitude)
        nextVC.hubRadius = self.hubRadius
        let parentController = self.parentViewController as? HubsListVC
        parentController?.show(nextVC, sender: nil)
        //self.rightBtnCallBack?(sender)
    }
    //MARK: Config Cell
//    func configCell(_ data: SignUpOptionsDataModel){
//        self.labelCityName.text = data.title
//    }
}

