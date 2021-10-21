//
//  MarketplaceOptionModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 10/5/21.
//

import Foundation

// MARK: - MarketplaceOptionModel
class MarketplaceOptionModel {
    var userFieldOptionid, userFieldid: Int?
    var option: String?
    var hint: String?
    var parent, head: Int?
    var createdAt, updatedAt: String?
    var name: String?
    var marketplace_product_category_id: Int?
    var marketplace_product_id: Int?
    
    init(with dictResponse: [String:Any]?) {
        
        self.option = String.getString(dictResponse?["option"])
        self.hint = String.getString(dictResponse?["hint"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.userFieldOptionid = Int.getInt(dictResponse?["user_field_option_id"])
        self.userFieldid = Int.getInt(dictResponse?["user_field_id"])
        self.parent = Int.getInt(dictResponse?["parent"])
        self.head = Int.getInt(dictResponse?["head"])
        
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.name = String.getString(dictResponse?["name"])
        self.marketplace_product_category_id = Int.getInt(dictResponse?["marketplace_product_category_id"])
        self.marketplace_product_id = Int.getInt(dictResponse?["marketplace_product_id"])
       
    }

    
}

class MaketPlaceHomeScreenModel{
    var top_banners: [TopBottomBanners]?
    var recently_added_product: [MyStoreProductDetail]?
    var newly_added_store : [MyStoreProductDetail]?
    var regions: [MyStoreProductDetail]?
    var top_favourite_products: [MyStoreProductDetail]?
    var top_rated_products: [MyStoreProductDetail]?
    var bottom_banners: [TopBottomBanners]?
    init(with dictResponse: [String:Any]) {
        if let topBanner = dictResponse["top_banners"] as? [[String:Any]]{
            self.top_banners = topBanner.map({TopBottomBanners.init(with: $0)})
        }
        if let recentlyAddedProduct = dictResponse["recently_added_product"] as? [[String:Any]]{
            self.recently_added_product = recentlyAddedProduct.map({MyStoreProductDetail.init(with: $0)})
        }
        if let newlyAddedStore = dictResponse["newly_added_store"] as? [[String:Any]]{
            self.newly_added_store = newlyAddedStore.map({MyStoreProductDetail.init(with: $0)})
        }
        if let top_favourite_products = dictResponse["top_favourite_products"] as? [[String:Any]]{
            self.top_favourite_products = top_favourite_products.map({MyStoreProductDetail.init(with: $0)})
        }
        if let top_rated_products = dictResponse["top_rated_products"] as? [[String:Any]]{
            self.top_rated_products = top_rated_products.map({MyStoreProductDetail.init(with: $0)})
        }
        if let regions = dictResponse["regions"] as? [[String:Any]]{
            self.regions = regions.map({MyStoreProductDetail.init(with: $0)})
        }
        if let banner = dictResponse["bottom_banners"] as? [[String:Any]]{
            self.bottom_banners = banner.map({TopBottomBanners.init(with: $0)})
        }
    }
}

class TopBottomBanners {
    
    var marketplaceBannerId: Int?
    var title: String?
    var type: Int?
    var attachment: Attachment?
    
    init(with dictResponse: [String:Any]){
        self.marketplaceBannerId = Int.getInt(dictResponse["marketplace_banner_id"])
        self.type = Int.getInt(dictResponse["type"])
        self.title = String.getString(dictResponse["title"])
        if let attachment = dictResponse["attachment"] as? [String:Any]{
            self.attachment = Attachment.init(with: attachment)
        }
    }
}
