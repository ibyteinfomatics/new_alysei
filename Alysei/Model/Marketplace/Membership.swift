//
//  Membership.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/8/21.
//

import Foundation

class Membership{
    var marketplacePackageId: Int?
    var name: String?
    var amount: String?
    var isSelected = false
    
    
    init(with data: [String:Any]?) {
        self.marketplacePackageId = Int.getInt(data?["marketplace_package_id"])
        self.name = String.getString(data?["name"])
        self.amount = String.getString(data?["amount"])

    }
}

class MyStoreProductDetail{
    
    var marketplace_product_id: Int?
    var user_id: Int?
    var marketplace_store_id: Int?
    var title: String?
    var description: String?
    var keywords: String?
    var product_category_id: Int?
    var product_subcategory_id: Int?
    var quantity_available: Int?
    var brand_label_id: Int?
    var min_order_quantity: String?
    var handling_instruction: String?
    var dispatch_instruction: String?
    var available_for_sample: String?
    var product_price: String?
    var product_Name: String?
    var name : String?
    var website: String?
    var phone: String?
    var logo_id: String?
    var banner_id: String?
    var product_gallery: [ProductGallery]?
    var store_gallery: [ProductGallery]?
    var prefilled: SubjectData?
    var totalCategory: Int?
    var avg_rating:String?
    var total_reviews: String?
    var marketplace_product_category_id : Int?
    var isSelected: Bool?
    var is_favourite: Int?
    var labels: Labels?
    var rating: String?
    var total_five_star: Int?
    var total_four_star: Int?
    var total_one_star: Int?
    var total_three_star: Int?
    var total_two_star: Int?
    
    init(with data: [String:Any]?) {
        self.marketplace_product_id = Int.getInt(data?["marketplace_product_id"])
        self.user_id = Int.getInt(data?["user_id"])
        self.marketplace_store_id = Int.getInt(data?["marketplace_store_id"])
        self.title = String.getString(data?["title"])
        self.description = String.getString(data?["description"])
        self.keywords = String.getString(data?["keywords"])
        self.product_category_id = Int.getInt(data?["product_category_id"])
        self.product_subcategory_id = Int.getInt(data?["product_subcategory_id"])
        self.quantity_available = Int.getInt(data?["quantity_available"])
        self.brand_label_id = Int.getInt(data?["brand_label_id"])
        self.min_order_quantity = String.getString(data?["min_order_quantity"])
        self.handling_instruction = String.getString(data?["handling_instruction"])
        self.dispatch_instruction = String.getString(data?["dispatch_instruction"])
        self.available_for_sample = String.getString(data?["available_for_sample"])
        self.product_price = String.getString(data?["product_price"])
        self.name = String.getString(data?["name"])
        self.website = String.getString(data?["website"])
        self.phone = String.getString(data?["phone"])
        self.logo_id = String.getString(data?["logo_id"])
        self.banner_id = String.getString(data?["banner_id"])
        self.totalCategory = Int.getInt(data?["total_category"])
        self.total_reviews = String.getString(data?["total_reviews"])
        self.avg_rating = String.getString(data?["avg_rating"])
        self.marketplace_product_category_id = Int.getInt(data?["marketplace_product_category_id"])
        self.isSelected = Bool.getBool(data?["is_selected"])
        self.is_favourite = Int.getInt(data?["is_favourite"])
        self.rating = String.getString(data?["rating"])
        self.total_one_star = Int.getInt(data?["total_one_star"])
        self.total_two_star = Int.getInt(data?["total_two_star"])
        self.total_three_star = Int.getInt(data?["total_three_star"])
        self.total_four_star = Int.getInt(data?["total_four_star"])
        self.total_five_star = Int.getInt(data?["total_five_star"])
        if let product_gallery = data?["product_gallery"] as? [[String:Any]]{
            self.product_gallery = product_gallery.map({ProductGallery.init(with: $0)})
        }
        if let store_gallery = data?["store_gallery"] as? [[String:Any]]{
            self.store_gallery = store_gallery.map({ProductGallery.init(with: $0)})
        }
        if let labels = data?["labels"] as? [String:Any]{
            self.labels = Labels.init(with: labels)
        }
        if let storePreValue = data?["prefilled"] as? [String:Any]{
            self.prefilled = SubjectData.init(with: storePreValue)
        }
        self.product_Name = String.getString(data?["product_category_name"])
    }
}


class ProductGallery{
    var marketplace_product_gallery_id: Int?
    var marketplace_product_id: Int?
    var attachment_url: String?
    var marketplace_store_gallery_id: String?
    var marketplace_store_id: String?
    
    init(with data: [String:Any]?) {
        self.marketplace_product_gallery_id = Int.getInt(data?["marketplace_product_gallery_id"])
        self.marketplace_product_id = Int.getInt(data?["marketplace_product_id"])
        self.attachment_url = String.getString(data?["attachment_url"])
        self.marketplace_store_gallery_id = String.getString(data?["marketplace_store_gallery_id"])
        self.marketplace_store_id = String.getString(data?["marketplace_store_id"])
    }
    
}
    class Labels{
        var marketplace_brand_label_id: Int?
        var name: String?
        
        init(with data: [String:Any]){
            self.marketplace_brand_label_id = Int.getInt(data["marketplace_brand_label_id"])
            self.name = String.getString(data["name"])
        }
    }

