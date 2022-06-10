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

class ProductsStore{
    var currentPage: Int?
    //var data: [MyStoreProductDetail]?
    var myStoreProduct : [MyStoreProductDetail]?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?
    
    init(with dictResponse: [String:Any]){
        self.currentPage = Int.getInt(dictResponse["current_page"])
//        if let data = dictResponse["data"] as? [[String:Any]]{
//            self.data = data.map({SubjectData.init(with: $0)})
//        }
        if let data = dictResponse["data"] as? [[String:Any]]{
            self.myStoreProduct = data.map({MyStoreProductDetail.init(with: $0)})
        }
        self.firstPageUrl = String.getString(dictResponse["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse["last_page_url"])
        self.lastPage = Int.getInt(dictResponse["last_page"])
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
    var banner_base_url:String?
    
    var product_gallery: [ProductGallery]?
    var store_gallery: [ProductGallery]?
    var galleries: ProductGallery?
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
    var location: String?
    var userFieldOptionid, userFieldid: Int?
    var option: String?
    var hint: String?
    var parent, head: Int?
    var createdAt, updatedAt: String?
    var id: Int?
    var storeName: String?
    var logoId: Attachment?
    var latitude:String?
    var longitude: String?
    var latest_review: RatingReviewModel?
    var isOptionSelected = false
    var flagId : FlagId?
    var region: Regions?
    var product_category_name: String?
    var logo_base_url: String?
    var base_url: String?
    //var isSelected = false
    //var phone: String?
    

    init(with data: [String:Any]?) {
        self.marketplace_product_id = Int.getInt(data?["marketplace_product_id"])
        self.user_id = Int.getInt(data?["user_id"])
        self.id = Int.getInt(data?["id"])
        self.marketplace_store_id = Int.getInt(data?["marketplace_store_id"])
        self.title = String.getString(data?["title"])
        self.description = String.getString(data?["description"])
        self.keywords = String.getString(data?["keywords"])
        self.product_category_id = Int.getInt(data?["product_category_id"])
        self.product_subcategory_id = Int.getInt(data?["product_subcategory_id"])
        self.quantity_available = Int.getInt(data?["quantity_available"])
        self.brand_label_id = Int.getInt(data?["brand_label_id"])
        self.storeName = String.getString(data?["store_name"])
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
        self.location = String.getString(data?["location"])
        self.product_category_name = String.getString(data?["product_category_name"])
        //self.phone = String.getString(data?["phone"])
        self.logo_base_url = String.getString(data?["logo_base_url"])
        if let product_gallery = data?["product_gallery"] as? [[String:Any]]{
            self.product_gallery = product_gallery.map({ProductGallery.init(with: $0)})
        }
        if let store_gallery = data?["store_gallery"] as? [[String:Any]]{
            self.store_gallery = store_gallery.map({ProductGallery.init(with: $0)})
        }
        if let galleries = data?["galleries"] as? [String:Any]{
            self.galleries = ProductGallery.init(with: galleries)
        }
        if let labels = data?["labels"] as? [String:Any]{
            self.labels = Labels.init(with: labels)
        }
        if let storePreValue = data?["prefilled"] as? [String:Any]{
            self.prefilled = SubjectData.init(with: storePreValue)
        }
        if let flagId = data?["flag_id"] as? [String:Any]{
            self.flagId = FlagId.init(data: flagId)
        }
        if let latest_review = data?["latest_review"] as? [String:Any]{
            self.latest_review = RatingReviewModel.init(with: latest_review)
        }
        self.product_Name = String.getString(data?["product_category_name"])
        self.option = String.getString(data?["option"])
        self.hint = String.getString(data?["hint"])
        self.createdAt = String.getString(data?["created_at"])
        self.userFieldOptionid = Int.getInt(data?["user_field_option_id"])
        self.userFieldid = Int.getInt(data?["user_field_id"])
        self.parent = Int.getInt(data?["parent"])
        self.head = Int.getInt(data?["head"])
        self.longitude = String.getString(data?["longitude"])
        self.latitude = String.getString(data?["lattitude"])
        self.updatedAt = String.getString(data?["updated_at"])
        if let logoId = data?["logo_id"] as? [String:Any]{
            self.logoId = Attachment.init(with: logoId)
        }
        if let region = data?["region"] as? [String:Any]{
            self.region = Regions.init(with: region)
        }
        self.base_url = String.getString(data?["base_url"])
        self.banner_base_url = String.getString(data?["banner_base_url"])
        
    }
}
class Regions {
    var id: String?
    var name: String?
    
    init(with data: [String:Any]) {
        self.id = String.getString(data["id"])
        self.name = String.getString(data["name"])
    }
}

class ProductGallery{
    var marketplace_product_gallery_id: Int?
    var marketplace_product_id: Int?
    var attachment_url: String?
    var marketplace_store_gallery_id: Int?
    var marketplace_store_id: String?
    var baseUrl: String?
    var basePUrl : String?
    init(with data: [String:Any]?) {
        self.marketplace_product_gallery_id = Int.getInt(data?["marketplace_product_gallery_id"])
        self.marketplace_product_id = Int.getInt(data?["marketplace_product_id"])
        self.attachment_url = String.getString(data?["attachment_url"])
        self.marketplace_store_gallery_id = Int.getInt(data?["marketplace_store_gallery_id"])
        self.marketplace_store_id = String.getString(data?["marketplace_store_id"])
        self.baseUrl = String.getString(data?["base_url"])
        self.basePUrl = String.getString(data?["baseUrl"])
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

