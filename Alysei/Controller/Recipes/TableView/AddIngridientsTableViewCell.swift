//
//  AddIngridientsTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 17/08/21.
//

import UIKit


protocol AddIngridientsTableViewCellProtocol {
    func tapForIngridient(indexPath: IndexPath, data: IngridentArray, checkStatus: Bool?)
}
class AddIngridientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientsNameLabel: UILabel!
    
    @IBOutlet weak var ingridientsImageView: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var selectImgView: UIImageView!
    var data: IngridentArray?
    var checkDataStatus: Bool?
    
    var btnAddCallback:((Int) -> Void)? = nil

    var indexPath: IndexPath?
    var addIngridientDelegate : AddIngridientsTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configCell(data: IngridentArray){
        self.data = data

        if data.isSelected == true{
            self.selectImgView.isHidden = false
        }
        else{
            self.selectImgView.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        addButton.layer.cornerRadius = 5
        selectImgView.layer.cornerRadius = 5
        
       
//        ingridientsImageView.layer.cornerRadius = self.ingridientsImageView.frame.width/2
        
    }

    @IBAction func TapForAddIngridient(_ sender: UIButton) {
        
       // btnAddCallback?(sender.tag)
//        if data?.isSelected == true {
//            data?.isSelected = false
//        } else {
//            data?.isSelected = true
//        }
        
        checkDataStatus = data?.isSelected
        addIngridientDelegate?.tapForIngridient(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0),data: data ?? IngridentArray(with: [:]), checkStatus: checkDataStatus)
    }
    
    
}


