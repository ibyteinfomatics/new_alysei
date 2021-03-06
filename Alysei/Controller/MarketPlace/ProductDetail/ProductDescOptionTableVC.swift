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
    

    var arrTitle = [MarketPlaceConstant.kDotQuantityAvailable,MarketPlaceConstant.kBrandLabel,MarketPlaceConstant.kMinOrderQuantity,MarketPlaceConstant.kSampleAvailable]
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ data: ProductDetailModel, _ currentIndex: Int?, _ cell: ProductDescOptionTableVC?){
//        if data.product_detail?.brand_label_id == "0" || data.product_detail?.brand_label_id == "" {
//            if currentIndex == 2 {
//                self.lblOptionTitle.text = NoBrandArrTitle[0]
//                self.lblOptionValue.text = data.product_detail?.quantity_available
//            }else if currentIndex == 3 {
//                self.lblOptionTitle.text = NoBrandArrTitle[1]
//                self.lblOptionValue.text = data.product_detail?.min_order_quantity
//            }else if currentIndex == 4 {
//                self.lblOptionTitle.text = NoBrandArrTitle[2]
//                self.lblOptionValue.text = data.product_detail?.available_for_sample
//            } else{
//                print("None")
//            }
//
//        }else{
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
        //}
        
    }

}
