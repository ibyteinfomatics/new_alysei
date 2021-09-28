//
//  TripModel.swift
//  Alysei
//
//  Created by Jai on 02/09/21.
//

import Foundation

// MARK: - TrioModel
class TripModel {
    var success: Int?
    var data: [TripDatum]?

    init(with dictResponse: [String:Any]?) {
        
        self.success = Int.getInt(dictResponse?["success"])
        
        if let data = dictResponse?["data"] as? [[String:Any]]{
            self.data = data.map({TripDatum.init(with: $0)})
        }
        
    }
    
}

// MARK: - Datum
class TripDatum {
    var tripID, userID: Int?
    var tripName, travelAgency: String?
    var adventureType: Int?
    var duration: String?
    var intensity: TripIntensity?
    var website, price, datumDescription, imageID: String?
    var status, createdAt, updatedAt: String?
    var user: TripUser?
    var attachment: TripAttachment?
    var adventure: TripAdventure?
    var region: TripCountry?
    var country: TripCountry?

    init(with dictResponse: [String:Any]?) {
        
        self.tripName = String.getString(dictResponse?["trip_name"])
        self.travelAgency = String.getString(dictResponse?["travel_agency"])
        self.duration = String.getString(dictResponse?["duration"])
        self.website = String.getString(dictResponse?["website"])
        self.price = String.getString(dictResponse?["price"])
        self.imageID = String.getString(dictResponse?["image_id"])
        
        self.datumDescription = String.getString(dictResponse?["description"])
        self.status = String.getString(dictResponse?["status"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.tripID = Int.getInt(dictResponse?["trip_id"])
        self.userID = Int.getInt(dictResponse?["user_id"])
        //self.region = Int.getInt(dictResponse?["region"])
        self.adventureType = Int.getInt(dictResponse?["adventure_type"])
        
        if let intensity = dictResponse?["intensity"] as? [String:Any]{
            self.intensity =  TripIntensity.init(with: intensity)
        }
        
        if let user = dictResponse?["user"] as? [String:Any]{
            self.user =  TripUser.init(with: user)
        }
        
        if let attachment = dictResponse?["attachment"] as? [String:Any]{
            self.attachment =  TripAttachment.init(with: attachment)
        }
        
        if let adventure = dictResponse?["adventure"] as? [String:Any]{
            self.adventure =  TripAdventure.init(with: adventure)
        }
        
        if let region = dictResponse?["region"] as? [String:Any]{
            self.region =  TripCountry.init(with: region)
        }
        
        if let country = dictResponse?["country"] as? [String:Any]{
            self.country =  TripCountry.init(with: country)
        }
        
    }
    
    
}

// MARK: - Adventure
class TripAdventure {
    var adventureTypeID: Int?
    var adventureType, status: String?
    var createdAt, updatedAt: String?
    
   
    init(with dictResponse: [String:Any]?) {
        self.adventureType = String.getString(dictResponse?["adventure_type"])
        self.status = String.getString(dictResponse?["status"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.adventureTypeID = Int.getInt(dictResponse?["adventure_type_id"])
    }
    
}

// MARK: - Attachment
class TripAttachment {
    var id: Int?
    var attachmentURL, attachmentType, createdAt, updatedAt: String?

    init(with dictResponse: [String:Any]?) {
        self.attachmentURL = String.getString(dictResponse?["attachment_url"])
        self.attachmentType = String.getString(dictResponse?["attachment_type"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.id = Int.getInt(dictResponse?["id"])
    }
    
}

// MARK: - Intensity
class TripIntensity {
    var intensityID: Int?
    var intensity, status: String?
    var createdAt, updatedAt: String?

    init(with dictResponse: [String:Any]?) {
        self.intensity = String.getString(dictResponse?["intensity"])
        self.status = String.getString(dictResponse?["status"])
        self.createdAt = String.getString(dictResponse?["created_at"])
        self.updatedAt = String.getString(dictResponse?["updated_at"])
        self.intensityID = Int.getInt(dictResponse?["intensity_id"])
    }
    
}

// MARK: - Intensity
class TripCountry {
    var id: Int?
    var name: String?

    init(with dictResponse: [String:Any]?) {
        self.name = String.getString(dictResponse?["name"])
        self.id = Int.getInt(dictResponse?["id"])
    }
    
}

// MARK: - User
class TripUser {
    var userID: Int?
    var name: String?
    var email, companyName: String?
    var restaurantName: String?
    var roleID: Int?
    var avatarID: TripAttachment?
   
    init(with dictResponse: [String:Any]?) {
        self.name = String.getString(dictResponse?["name"])
        self.email = String.getString(dictResponse?["email"])
        self.companyName = String.getString(dictResponse?["company_name"])
        self.restaurantName = String.getString(dictResponse?["restaurant_name"])
        self.userID = Int.getInt(dictResponse?["user_id"])
        self.roleID = Int.getInt(dictResponse?["role_id"])
        
        if let avatar_id = dictResponse?["avatar_id"] as? [String:Any]{
            self.avatarID =  TripAttachment.init(with: avatar_id)
        }
        
    }
    
    
}

