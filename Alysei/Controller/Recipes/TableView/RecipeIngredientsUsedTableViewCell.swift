//
//  RecipeIngredientsUsedTableViewCell.swift
//  Alysei Recipe Module
//
//  Created by mac on 06/08/21.
//

import UIKit

protocol RecipeIngredientsUsedTableViewCellProtocol {
    func tapForEditIngridient(indexPath: IndexPath)
    func tapForDeleteIngridient(indexPath: IndexPath)
}
class RecipeIngredientsUsedTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var IngredientsNameLbl: UILabel!
    @IBOutlet weak var IngredientsValueLbl: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    var indexPath: IndexPath?
    var editIngridientDelegate : RecipeIngredientsUsedTableViewCellProtocol?
    var deleteIngridientDelegate : RecipeIngredientsUsedTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteItem(_ sender: UIButton) {
        deleteIngridientDelegate?.tapForDeleteIngridient(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0))
    }
    @IBAction func editItem(_ sender: UIButton) {
        editIngridientDelegate?.tapForEditIngridient(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0))
    }
}
