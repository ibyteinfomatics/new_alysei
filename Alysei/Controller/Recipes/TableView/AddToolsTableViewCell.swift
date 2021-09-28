//
//  AddToolsTableViewCell.swift
//  Alysei Recipe Module
//
//  Created by mac on 03/08/21.
//

import UIKit

protocol AddToolTableViewCellProtocol {
    func tapForTool(indexPath: IndexPath, data: ToolsArray, checkStatus: Bool?)
}

class AddToolsTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var selectToolImgView: UIImageView!
    
    var data: ToolsArray?
    var checkDataStatus: Bool?
    var indexPath: IndexPath?
    var addToolDelegate : AddToolTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(data: ToolsArray){
        self.data = data
        if data.isSelected == true{
            self.selectToolImgView.isHidden = false
        }
        else{
            self.selectToolImgView.isHidden = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        addButton.layer.cornerRadius = 5
        selectToolImgView.layer.cornerRadius = 5
        // Configure the view for the selected state
    }
    
    @IBAction func TapForAddTool(_ sender: UIButton) {
        
        checkDataStatus = data?.isSelected
        addToolDelegate?.tapForTool(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0),data: data ?? ToolsArray(with: [:]), checkStatus: checkDataStatus)
       
    }

}
