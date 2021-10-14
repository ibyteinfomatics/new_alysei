//
//  EditRecipeIngridientTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

protocol EditRecipeIngredientTableViewCellProtocol {
    func tapForDeleteIngridient1(indexPath: IndexPath)
}
class EditRecipeIngridientTableViewCell: UITableViewCell {

    var indexPath: IndexPath?
   
    var deleteIngridientDelegate : EditRecipeIngredientTableViewCellProtocol?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var IngredientsNameLbl: UILabel!
    @IBOutlet weak var IngredientsValueLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteItem(_ sender: UIButton) {
        deleteIngridientDelegate?.tapForDeleteIngridient1(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0))
    }
}
