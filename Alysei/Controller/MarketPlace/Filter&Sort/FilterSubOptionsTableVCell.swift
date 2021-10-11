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
    var id: Int?

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
    func configProductSearch(_ data: MyStoreProductDetail, _ checkHitApi: checkHitApi?, indexPath: Int?){
        if checkHitApi == .fdaCertified || checkHitApi == .method || checkHitApi == .properties{
        labelSubOptions.text = data.option
        }else{
            labelSubOptions.text = data.name
        }
        if checkHitApi == .categories{
            self.id = data.marketplace_product_category_id
        }else if checkHitApi == .properties || checkHitApi == .method{
                self.id = data.userFieldOptionid
            }else if checkHitApi == .region{
                self.id = data.id
            }
        if (selectedCategory?.contains(id ?? -1) ?? false){
            data.isSelected = true
        }else{
            data.isSelected = false
        }
       
        if data.isSelected == false{
        btnOptionSelect.setImage(UIImage(named: "icons_grey_checkbox"), for: .normal)
        }else{
            btnOptionSelect.setImage(UIImage(named: "FilterMultiSelect"), for: .normal)
        }
    }
    
    func configStringNameCell(_ data: FilterModel, _ index: Int, _ checkHitApi: checkHitApi?){
        if (selectedCategory?.contains(index ) ?? false){
            data.isSelected = true
        }else{
            data.isSelected = false
        }
        if checkHitApi == .fdaCertified || checkHitApi == .producers{
        if data.isSelected == false{
            btnOptionSelect.setImage(UIImage(named: "UnselectSort"), for: .normal)
        }else{
            btnOptionSelect.setImage(UIImage(named: "SelectSort"), for: .normal)
        }
        }else{
            if data.isSelected == false{
                btnOptionSelect.setImage(UIImage(named: "icons_grey_checkbox"), for: .normal)
            }else{
                btnOptionSelect.setImage(UIImage(named: "FilterMultiSelect"), for: .normal)
            }
        }
    }
}
