//
//  ReviewHubModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 13/04/21.
//

import Foundation

enum ReviewHubModel {
    struct reviewHubModel: Codable{
        var data: [reviewHubsDataModel]?
        var success: Int?
        
        private enum CodingKeys: String, CodingKey {
            case data = "data"
            case success = "success"
        }
        
    }
//    struct data: Codable {
//        var hubs: [reviewHubsDataModel]?
//
//        private enum CodingKeys: String, CodingKey {
//            case hubs = "hubs"
//        }
//    }
    
    struct reviewHubsDataModel: Codable {
        var countryId: Int?
        var countryName: String?
        
        var selectedHubs: [hubArray]?
        var selectedCity: [cityArray]?
        
        private enum CodingKeys: String, CodingKey{
            
            case countryId = "country_id"
            case countryName = "country_name"
            
            case selectedHubs = "hubs"
            case selectedCity = "cities"
        }
        
    }
    
    typealias hubArray = reviewHubCityArray
    typealias cityArray = reviewHubCityArray
    
    struct  reviewHubCityArray: Codable {
        var id: Int?
        var countryId: Int?
        var stateId: Int?
        var title: String?
        var city: reviewCityData?
        
        private enum CodingKeys: String, CodingKey{
            
            case id = "id"
            case countryId = "country_id"
            case stateId = "state_id"
            case city = "city"
            case title = "title"
        }
    }
    
    struct reviewCityData : Codable {
        var id: Int?
        var name: String?
        
        private enum CodingKeys: String, CodingKey{
            case id = "id"
            case name = "name"
        }
    }
}


class ReviewSelectedHub {
    var country_id: Int?
    var country_name: String?
    var hubs: [HubCityArray]?
    var cities: [HubCityArray]?
    
    init(with data: [String:Any]?) {
        self.country_id = Int.getInt(data?["country_id"])
        self.country_name = String.getString(data?["country_name"])
        let hubsArray = kSharedInstance.getArray(withDictionary: data?["hubs"])
        self.hubs = hubsArray.map{HubCityArray(with: $0)}
        let citiesArray = kSharedInstance.getArray(withDictionary: data?["cities"])
        self.cities = citiesArray.map{HubCityArray(with: $0)}
    }
}

class HubCityArray {
    var id: Int?
    var countryId: Int?
    var stateId: Int?
    var title: String?
    var isSelected = false
    
    var city: ReviewCityData?
   
    init(with data: [String:Any]?) {
        self.id = Int.getInt(data?["id"])
        self.countryId = Int.getInt(data?["country_id"])
        self.stateId = Int.getInt(data?["state_id"])
        self.title = String.getString(data?["title"])
        if let city = data?["city"] as? [String:Any] {
            self.city = ReviewCityData.init(with: city)
        }
        //self.isSelected = Bool.getBool(data?["isSelected"])
    }

}

class ReviewCityData{
    var id: Int?
    var name: String?
    init(with data: [String:Any]?) {
        self.id = Int.getInt(data?["id"])
        self.name = String.getString(data?["name"])
    }
    
}
