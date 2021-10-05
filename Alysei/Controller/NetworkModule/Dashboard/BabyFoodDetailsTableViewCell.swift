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
    
    
    var lblDropDownArray: [String] = ["Papaya","Lichi","Banana","Orange","Strawberry"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        btnDocumentUpload.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func tapDropDown (_ sender: UIButton!){
        if btnDropDown.isSelected == true{
        dropDownTableView.isHidden = true
        }
        else{
            dropDownTableView.isHidden = false
        }
    }
    
}
extension BabyFoodDetailsTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lblDropDownArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = lblDropDownArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(lblDropDownArray.count * 30)
    }
    
}
