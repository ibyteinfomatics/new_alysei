//
//  DashboardModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 04/10/21.
//

import Foundation

// MARK: - DashboardModel
class DashboardModel {
    var success: Int?
    var data: DashboardDataClass?

    
    init(with dictResponse: [String:Any]?) {
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [String:Any]{
            self.data =  DashboardDataClass.init(with: data)
        }
    }
    
}

// MARK: - DataClass
class DashboardDataClass {
    var userData: UserData?
    var aboutMember: [AboutMember]?
    var certificates: [Certificate]?
    
    init(with dictResponse: [String:Any]?) {
        
        if let data = dictResponse?["user_data"] as? [String:Any]{
            self.userData =  UserData.init(with: data)
        }
        
        if let data = dictResponse?["about_member"] as? [[String:Any]]{
            self.aboutMember = data.map({AboutMember.init(with: $0)})
        }
        
        if let data = dictResponse?["certificates"] as? [[String:Any]]{
            self.certificates = data.map({Certificate.init(with: $0)})
        }
        
    }
    
    
}

// MARK: - AboutMember
class AboutMember {
    var title: String?
    var userFieldid: Int?
    var type, value: String?
    
    init(with dictResponse: [String:Any]?) {
        self.title = String.getString(dictResponse?["title"])
        self.type = String.getString(dictResponse?["type"])
        self.value = String.getString(dictResponse?["value"])
        self.userFieldid = Int.getInt(dictResponse?["user_field_id"])
    }

}

// MARK: - Certificate
class Certificate {
    var userFieldOptionid, userFieldid: Int?
    var option: String?
    var hint: String?
    var parent, head: Int?
    var createdAt, updatedAt: String?
    var photoOfLabel, fceSidCertification, phytosanitaryCertificate, packagingForUsa: String?
    var foodSafetyPlan, animalHelathAslCertificate: String?
    var conservationMethods, productProperties: [ConservationMethod]?
    
    init(with dictResponse: [String:Any]?) {
        
        self.option = String.getString(dictResponse?["option"])
        self.hint = String.getString(dictResponse?["hint"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.userFieldOptionid = Int.getInt(dictResponse?["user_field_option_id"])
        self.userFieldid = Int.getInt(dictResponse?["user_field_id"])
        self.parent = Int.getInt(dictResponse?["parent"])
        self.head = Int.getInt(dictResponse?["head"])
        
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.photoOfLabel = String.getString(dictResponse?["photo_of_label"])
        self.fceSidCertification = String.getString(dictResponse?["fce_sid_certification"])
        self.phytosanitaryCertificate = String.getString(dictResponse?["phytosanitary_certificate"])
        self.packagingForUsa = String.getString(dictResponse?["packaging_for_usa"])
        self.foodSafetyPlan = String.getString(dictResponse?["food_safety_plan"])
        self.animalHelathAslCertificate = String.getString(dictResponse?["animal_helath_asl_certificate"])
        
        if let data = dictResponse?["conservation_methods"] as? [[String:Any]]{
            self.conservationMethods = data.map({ConservationMethod.init(with: $0)})
        }
        
        if let data = dictResponse?["product_properties"] as? [[String:Any]]{
            self.productProperties = data.map({ConservationMethod.init(with: $0)})
        }
       
    }

    
}

// MARK: - ConservationMethod
class ConservationMethod {
    var userFieldOptionid, userFieldid: Int?
    var option: String?
    var hint: String?
    var parent, head: Int?
    var createdAt, updatedAt: String?
    
    
    init(with dictResponse: [String:Any]?) {
        
        self.option = String.getString(dictResponse?["option"])
        self.hint = String.getString(dictResponse?["hint"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.userFieldOptionid = Int.getInt(dictResponse?["user_field_option_id"])
        self.userFieldid = Int.getInt(dictResponse?["user_field_id"])
        self.parent = Int.getInt(dictResponse?["parent"])
        self.head = Int.getInt(dictResponse?["head"])
        
    }
    
}

// MARK: - UserData
class UserData {
    var userid, roleid: Int?
    var companyName: String?
    var firstName, lastName: String?
    var about: String?
    var restaurantName: String?
    var vatNo, fdaNo: String?
    var avatarid: Avatarid?
    var reasonToConnect: String?
    var coverid: Avatarid?
    
    init(with dictResponse: [String:Any]?) {
        
        if let data = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarid =  Avatarid.init(with: data)
        }
        
        if let coverid = dictResponse?["cover_id"] as? [String:Any]{
            self.coverid =  Avatarid.init(with: coverid)
        }
        
        self.companyName = String.getString(dictResponse?["company_name"])
        self.firstName = String.getString(dictResponse?["first_name"])
        self.lastName = String.getString(dictResponse?["last_name"])
        self.userid = Int.getInt(dictResponse?["user_id"])
        self.roleid = Int.getInt(dictResponse?["role_id"])
        self.about = String.getString(dictResponse?["about"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.vatNo = String.getString(dictResponse?["vat_no"])
        self.fdaNo = String.getString(dictResponse?["fda_no"])
        self.reasonToConnect = String.getString(dictResponse?["reason_to_connect"])
        
    }

    
}

// MARK: - Avatarid
class Avatarid {
    var id: Int?
    var attachmenturl, attachmentType: String?
    var height, width: Int?
    var createdAt, updatedAt: String?
    
    init(with dictResponse: [String:Any]?) {
        
        self.attachmenturl = String.getString(dictResponse?["attachment_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.id = Int.getInt(dictResponse?["id"])
        self.height = Int.getInt(dictResponse?["height"])
        self.width = Int.getInt(dictResponse?["width"])
        
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        
        
    }

    
}

