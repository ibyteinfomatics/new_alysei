//
//  ProductDescOptionTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductDescOptionTableVC: UITableViewCell {
    @IBOutlet weak var lblOptionTitle: UILabel!
    @IBOutlet weak var lblOptionValue: UILabel!
    

    var arrTitle = ["Quantity Available:","Brand Label","Min Order Quantity","Sample Available"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ data: ProductDetailModel, _ currentIndex: Int?){
        if currentIndex == 2 {
            self.lblOptionTitle.text = arrTitle[0]
            self.lblOptionValue.text = data.product_detail?.quantity_available
        }else if currentIndex == 3 {
            self.lblOptionTitle.text = arrTitle[1]
            self.lblOptionValue.text = data.product_detail?.labels?.name
        }else if currentIndex == 4 {
            self.lblOptionTitle.text = arrTitle[2]
            self.lblOptionValue.text = data.product_detail?.min_order_quantity
        } else{
            self.lblOptionTitle.text = arrTitle[3]
            self.lblOptionValue.text = data.product_detail?.available_for_sample
        }
        
    }

}
