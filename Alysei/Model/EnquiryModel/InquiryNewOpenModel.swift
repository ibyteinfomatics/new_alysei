//
//  InquiryNewOpenModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/05/22.
//

import Foundation


class InquiryNewOpenModel {
    
    var currentPage : Int?
    var dataOpen : [OpenModel]?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?
    
    init(with dictResponse: [String:Any]){
        self.currentPage = Int.getInt(dictResponse["current_page"])
        if let data = dictResponse["data"] as? [[String:Any]]{
            self.dataOpen = data.map({OpenModel.init(with: $0)})
        }
        self.firstPageUrl = String.getString(dictResponse["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse["last_page_url"])
        self.lastPage = Int.getInt(dictResponse["last_page"])

   }
    
}

class OpenModel{
    
    var marketplace_product_enquery_id: Int?
    var user_id: String?
    var producer_id: String?
    var product_id: String?
    var name: String?
    var email: String?
    var phone: String?
    var message: String?
    var sender: SubjectData?
    var receiver: SubjectData?
    var product: MyStoreProductDetail?
    var created_at: String?
    var unread_count: Int?
    
    init(with dictResponse: [String:Any]){
        
        self.marketplace_product_enquery_id = Int.getInt(dictResponse["marketplace_product_enquery_id"])
        self.user_id = String.getString(dictResponse["user_id"])
        self.producer_id = String.getString(dictResponse["producer_id"])
        self.product_id = String.getString(dictResponse["product_id"])
        self.name = String.getString(dictResponse["name"])
        self.email = String.getString(dictResponse["email"])
        self.phone = String.getString(dictResponse["phone"])
        self.message = String.getString(dictResponse["message"])
        if let data = dictResponse["sender"] as? [String:Any]{
            self.sender = SubjectData.init(with: data)
        
        }
        if let product = dictResponse["product"] as? [String:Any]{
            self.product = MyStoreProductDetail.init(with: product)
        
        }

       
        self.created_at = dictResponse["created_at"] as? String
        if let data1 = dictResponse["receiver"] as? [String:Any]{
            self.receiver = SubjectData.init(with: data1)
        
        }
        self.unread_count = dictResponse["unread_count"] as? Int
//        if let data = dictResponse["sender"] as? [String:Any]{
//            self.product = MyStoreProductDetail.init(with: data)
//
//        }
        
    }
}
