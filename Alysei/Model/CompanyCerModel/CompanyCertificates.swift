//
//  CompanyCertificates.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/03/21.
//

import Foundation

class CompanyCertificates {
    var userData: UserCerData?
    var dataCertificates: [DataCertificates]?
    init(with data: [String:Any]?) {
        if let userData = data?["user_data"] as? [String:Any]{
            self.userData = UserCerData.init(with: userData)
        }
        
        if let data = data?["data_certificates"] as? [[String:Any]]{
            self.dataCertificates = data.map({DataCertificates.init(with: $0)})
        }
    }
}

class UserCerData{
    var userId: String?
    var fdaNo:String?
    var vatNo:String?
    
    init(with data: [String:Any]?){
        self.userId = String.getString(data?["user_id"])
        self.fdaNo = String.getString(data?["fda_no"])
        self.vatNo = String.getString(data?["vat_no"])
    }
    
    init() {
        
    }
    
}

class DataCertificates{
    var option: String?
    var userFieldOptionId: String?
    var photoOfLabel: String?
    var fceSidCertification: String?
    var phytosanitaryCertificate: String?
    var packaginForUsa: String?
    var foodSafetyPlan: String?
    var animalHelathAslCertificate: String?
    
    init(with data: [String:Any]?) {
        self.option = String.getString(data?["option"])
        self.userFieldOptionId = String.getString(data?["user_field_option_id"])
        self.photoOfLabel = String.getString(data?["photo_of_label"])
        self.fceSidCertification = String.getString(data?["fce_sid_certification"])
        self.phytosanitaryCertificate = String.getString(data?["phytosanitary_certificate"])
        self.packaginForUsa = String.getString(data?["packaging_for_usa"])
        self.foodSafetyPlan = String.getString(data?["food_safety_plan"])
        self.animalHelathAslCertificate = String.getString(data?["animal_helath_asl_certificate"])
    }
}

//class arrTitle {
//    var certificateTitles: [CertificateTitles]?
//    
//    init(_ arr: [CertificateTitles]) {
//            self.certificateTitles = arr.map({CertificateTitles.init(with: $0)})
//
//    }
//}

class CertificateTitles {
    
    var title: String?
    var isSelected: Bool?
    
    init(with data: [String:Any]?){
        self.title = String.getString(data?["title"])
        self.isSelected = false
    }
}
