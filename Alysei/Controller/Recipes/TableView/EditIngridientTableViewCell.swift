//
//  EditIngridientTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit
protocol EditIngridientsTableViewCellProtocol {
    func tapForIngridient(indexPath: IndexPath, data: IngridentArray, checkStatus: Bool?)
}
class EditIngridientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientsNameLabel: UILabel!
    @IBOutlet weak var ingridientsImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var selectImgView: UIImageView!
    
    var checkDataStatus: Bool?
    var indexPath: IndexPath?
    var addIngridientDelegate : EditIngridientsTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data: IngridentArray? {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
//        if (selectedEditIngridentsArray.contains(where: { $0.recipeIngredientIds == data?.recipeIngredientIds })) == true {
//            self.selectImgView.isHidden = false
//
//        }
         if (editusedIngridientModel.contains(where: { $0.ingridient?.recipeIngredientIds == data?.recipeIngredientIds })) == true {
            self.selectImgView.isHidden = false
                
        }
        else {
            self.selectImgView.isHidden = true
        }
        let imgUrl = ((data?.imageId?.baseUrl ?? "") + (data?.imageId?.imgUrl ?? ""))
        ingridientsImageView.setImage(withString: imgUrl)
        ingredientsNameLabel.text = data?.ingridientTitle
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        addButton.layer.cornerRadius = 5
        selectImgView.layer.cornerRadius = 5
        // Configure the view for the selected state
    }

    @IBAction func TapForAddIngridient(_ sender: UIButton) {
        if self.selectImgView.isHidden == true {
            addIngridientDelegate?.tapForIngridient(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0),data: data ?? IngridentArray(with: [:]), checkStatus: false)
        } else {
            addIngridientDelegate?.tapForIngridient(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0),data: data ?? IngridentArray(with: [:]), checkStatus: true)

        }
    }
}
