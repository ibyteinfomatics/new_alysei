//
//  FilterSubOptionsTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/5/21.
//

import UIKit

class FilterSubOptionsTableVCell: UITableViewCell {
    @IBOutlet weak var labelSubOptions: UILabel!
    @IBOutlet weak var btnOptionSelect: UIButton!
    var selectedCategory: [Int]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ filterSelectedIndex: Int, _ data: FilterModel, _ category: MyStoreProductDetail, _ indexPath: Int?){
        
        switch filterSelectedIndex{
        case 0,2:
            if data.isSelected == false{
            btnOptionSelect.setImage(UIImage(named: "UnselectSort"), for: .normal)
            }else{
                btnOptionSelect.setImage(UIImage(named: "SelectSort"), for: .normal)
            }
            labelSubOptions.text =  data.name
        case 1:
            
            if (selectedCategory?.contains(indexPath ?? -1) ?? false){
                category.isSelected = true
            }
            if category.isSelected == false{
            btnOptionSelect.setImage(UIImage(named: "icons_grey_checkbox"), for: .normal)
            }else{
                btnOptionSelect.setImage(UIImage(named: "FilterMultiSelect"), for: .normal)
            }
            labelSubOptions.text =  category.name
        default:
           // icons_grey_checkbox/
            print("Invalid")
        }
        
        
    }

}
