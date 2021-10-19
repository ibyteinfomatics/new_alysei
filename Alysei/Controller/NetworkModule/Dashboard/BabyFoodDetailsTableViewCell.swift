//
//  BabyFoodDetailsTableViewCell.swift
//  Dashboard
//
//  Created by mac on 21/09/21.
//

import UIKit

class BabyFoodDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDocumentUpload: UILabel!
    @IBOutlet weak var btnDocumentUpload: UIButton!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var propertyTableView: UITableView!
    
    @IBOutlet weak var btnDocumentUpload2: UIButton!
    @IBOutlet weak var btnDocumentUpload3: UIButton!
    @IBOutlet weak var btnDocumentUpload4: UIButton!
    @IBOutlet weak var btnDocumentUpload5: UIButton!
    @IBOutlet weak var btnDocumentUpload6: UIButton!
    
    @IBOutlet weak var uiview1: NSLayoutConstraint!
    @IBOutlet weak var uiview2: NSLayoutConstraint!
    @IBOutlet weak var uiview3: NSLayoutConstraint!
    @IBOutlet weak var uiview4: NSLayoutConstraint!
    @IBOutlet weak var uiview5: NSLayoutConstraint!
    @IBOutlet weak var uiview6: NSLayoutConstraint!
    
    @IBOutlet weak var conservationheight: NSLayoutConstraint!
    @IBOutlet weak var propertiesheight: NSLayoutConstraint!
    
    //var lblDropDownArray: [String] = ["Papaya","Lichi","Banana","Orange","Strawberry"]
    var lblDropDownArray: [String] = []
    var openImageCallBack1 :(()->())?
    var openImageCallBack2 :(()->())?
    var openImageCallBack3 :(()->())?
    var openImageCallBack4 :(()->())?
    var openImageCallBack5 :(()->())?
    var openImageCallBack6 :(()->())?
    
    var propertyCallBack :(()->())?
    var conservationCallBack :(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        
        propertyTableView.delegate = self
        propertyTableView.dataSource = self
        
        btnDocumentUpload.layer.cornerRadius = 15
        
        btnDocumentUpload2.layer.cornerRadius = 15
        btnDocumentUpload3.layer.cornerRadius = 15
        btnDocumentUpload4.layer.cornerRadius = 15
        btnDocumentUpload5.layer.cornerRadius = 15
        btnDocumentUpload6.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func tapPropertyDropDown (_ sender: UIButton!){
        self.propertyCallBack?()
//        if btnDropDown.isSelected == true{
//        dropDownTableView.isHidden = true
//        }
//        else{
//            dropDownTableView.isHidden = false
//        }
    }
    
    @IBAction func tapConservationDropDown (_ sender: UIButton!){
        self.conservationCallBack?()
//        if btnDropDown.isSelected == true{
//        dropDownTableView.isHidden = true
//        }
//        else{
//            dropDownTableView.isHidden = false
//        }
    }
    
    @IBAction func viewtap1 (_ sender: UIButton!){
        self.openImageCallBack1?()
    }
    
    @IBAction func viewtap2 (_ sender: UIButton!){
        self.openImageCallBack2?()
    }
    
    @IBAction func viewtap3 (_ sender: UIButton!){
        self.openImageCallBack3?()
    }
    
    @IBAction func viewtap4 (_ sender: UIButton!){
        self.openImageCallBack4?()
    }
    
    @IBAction func viewtap5 (_ sender: UIButton!){
        self.openImageCallBack5?()
    }
    
    @IBAction func viewtap6 (_ sender: UIButton!){
        self.openImageCallBack6?()
    }
    
}
extension BabyFoodDetailsTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*if tableView == dropDownTableView{
            return lblDropDownArray.count
        } else {
            return lblDropDownArray.count
        }*/
        
        return lblDropDownArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //var cell = dropDownTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        //cell.textLabel?.text = lblDropDownArray[indexPath.row]
        if tableView == dropDownTableView{
            let cell = dropDownTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell.textLabel?.text = lblDropDownArray[indexPath.row]
            return cell
        } else {
            let cell = propertyTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell.textLabel?.text = lblDropDownArray[indexPath.row]
            return cell
        }
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30//CGFloat(lblDropDownArray.count * 30)
    }
    
}
