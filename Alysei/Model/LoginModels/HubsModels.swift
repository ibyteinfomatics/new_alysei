//
//  HubsModels.swift
//  Alysie
//
//

import Foundation
import UIKit

class ActiveUpcomingCountry {
    var arrActiveCountries = [CountryModel]()
    var arrUpcomingCountries = [CountryModel]()
    
    init(data:[String:Any]?) {
        let arrActiveCountries = kSharedInstance.getArray(withDictionary: data?["active_countries"])
        self.arrActiveCountries = arrActiveCountries.map{CountryModel(data: $0)}
        let arrUpcomingCountries = kSharedInstance.getArray(withDictionary: data?["upcoming_countries"])
        self.arrUpcomingCountries = arrUpcomingCountries.map{CountryModel(data: $0)}
    }
    
}

class CountryModel {
    var name:String?
    var id:String?
    var capital:String?
    var currency:String?
    var subregion:String?
    var isSelected = false
   // var isSelected:Bool?
    var emoji: String?
    var countryPhonecode: String?
    var phonecode: String?
    var flagId: FlagId?
    
    init(data:[String:Any]?) {
        self.id = String.getString(data?["id"])
        self.countryPhonecode = String.getString(data?["phonecode"])
        self.name = String.getString(data?["name"])
        self.capital = String.getString(data?["capital"])
        self.currency = String.getString(data?["currency"])
        self.subregion = String.getString(data?["subregion"])
        self.emoji = String.getString(data?["emoji"])
        self.isSelected = Int.getInt(data?["is_selected"]) == 0 ? false: true
        self.phonecode = String.getString(data?["is_selectedhonecode"])
        if let flagId = data?["flag_id"] as? [String:Any] {
            self.flagId = FlagId.init(data: flagId)
        }
    }
    init() { }
    init(name:String, id:String) {
        self.name = name
        self.id = id
    }
    
}

class FlagId{
    var attachmentUrl: String?
    var baseUrl: String?
    
    var fimageUrl: String?
    init(data: [String:Any]?) {
        self.attachmentUrl = String.getString(data?["attachment_url"])
        self.baseUrl = String.getString(data?["base_url"])
        
        self.fimageUrl = (self.baseUrl ?? "") + (self.attachmentUrl ?? "")
    }
    init() { }
}

class SelectdHubs {
    var country:CountryModel = CountryModel()
    var hubs:[CountryHubs] = [CountryHubs]()
    var state:[CountryHubs] = [CountryHubs]()

    
    static func createHub(country:CountryModel?)->SelectdHubs{
        let hub = SelectdHubs()
        hub.country = country ?? CountryModel()
        return hub
    }
}



class CountryHubs {
    var country_code:String?
    var country_id:String?
    var state_id:String?
    var id:String?
    var name:String?
    var iso2:String?
    var attachment_url:String?
    var type:HasCome? = .hubs
    var isSelected = false
    var imageHub: String?
    var image: FlagId?
    var state: CountryHubs?
    var radius:Int?
    var is_checked: Bool?
    var latitude: String?
    var longitude:String?
   // var radius: String?
    init(data:[String:Any]?) {
        self.id = String.getString(data?["id"])
        //self.state_name = String.getString(data?["state_name"])
        self.name = String.getString(data?["name"])
        self.is_checked = Bool.getBool(data?["is_checked"])
        self.country_code = String.getString(data?["country_code"])
        self.country_id = String.getString(data?["country_id"])
        self.iso2 = String.getString(data?["subregion"])
        self.isSelected = Int.getInt(data?["is_selected"]) == 0 ? false : true
        self.state_id = String.getString(data?["state_id"])
        self.radius = Int.getInt(data?["radius"])
        self.type = .city
        if let image = data?["image"] as? [String:Any]{
            self.image = FlagId.init(data: image)
        }
        if let state = data?["state"] as? [String:Any]{
            self.state = CountryHubs.init(data: state)
        }
        self.latitude = data?["latitude"] as? String
        self.longitude = data?["longitude"] as? String
        
    
    }
    
    init(cityFromServer data: [String:Any]?) {
        self.id = String.getString(data?["city_id"])
        self.country_id = String.getString(data?["country_id"])
      //  self.state_name = String.getString(data?["state_name"])
        self.state_id = String.getString(data?["state_id"])
        if let city = data?["city"] as? [String:Any] {
            self.name = String.getString(city["name"])
        }
        self.type = .city
        self.isSelected = true
        if let image = data?["image"] as? [String:Any]{
            self.image = FlagId.init(data: image)
        }
        if let state = data?["state"] as? [String:Any]{
            self.state = CountryHubs.init(data: state)
        }
        self.latitude = data?["latitude"] as? String
        self.longitude = data?["longitude"] as? String
    }
    
    init(HubsFromServer data: [String:Any]?) {
        self.id = String.getString(data?["id"])
        self.name = String.getString(data?["title"])
        self.country_code = String.getString(data?["country_code"])
        self.country_id = String.getString(data?["country_id"])
       // self.state_name = String.getString(data?["state_name"])
        self.iso2 = String.getString(data?["subregion"])
        self.is_checked = Bool.getBool(data?["is_checked"])
        self.type = .hubs
        self.attachment_url = String.getString(data?["attachment_url"])
        self.isSelected =  true
        if let image = data?["image"] as? [String:Any]{
            self.image = FlagId.init(data: image)
        }
        if let state = data?["state"] as? [String:Any]{
            self.state = CountryHubs.init(data: state)
        }
        self.latitude = data?["latitude"] as? String
        self.longitude = data?["longitude"] as? String
    }

    // MARK:_ init for hUB Via city
    init(hub data:[String:Any]?) {
        self.id = String.getString(data?["id"])
        self.name = String.getString(data?["title"])
        self.country_code = String.getString(data?["country_code"])
        self.country_id = String.getString(data?["country_id"])
        self.iso2 = String.getString(data?["subregion"])
        self.is_checked = Bool.getBool(data?["is_checked"])
        self.type = .hubs
        self.attachment_url = String.getString(data?["attachment_url"])
        self.isSelected = Int.getInt(data?["is_selected"]) == 0 ? false: true
        if let image = data?["image"] as? [String:Any] {
            self.imageHub = String.getString(image["attachment_url"])
          //  print("HubImage-----------------------------------------\(self.imageHub ?? "")")
        }
        self.radius = Int.getInt(data?["radius"])
        if let image = data?["image"] as? [String:Any]{
            self.image = FlagId.init(data: image)
        }
        if let state = data?["state"] as? [String:Any]{
            self.state = CountryHubs.init(data: state)
        }
        self.latitude = data?["latitude"] as? String
        self.longitude = data?["longitude"] as? String
    }
    init() { }
    
    init(stateID:String) {
        self.id = stateID
        self.isSelected = true
    }
}

class HubsViaCity {
    var hubs_array:[CountryHubs]?
    var state_id:String?
    var state_name:String?
    var longitude: String?
    var latitude: String?
    var radius: Int?
    var image: String?
    var baseUrl: String?
    var state:CountryHubs?
    init(data:[String:Any]?) {
        self.state_id = String.getString(data?["state_id"])
        self.state_name = String.getString(data?["state_name"])
        let hubsArray = kSharedInstance.getArray(withDictionary: data?["hubs_array"])
        self.hubs_array = hubsArray.map{CountryHubs(hub: $0)}
        self.longitude = String.getString(data?["longitude"])
        self.latitude = String.getString(data?["lattitude"])
        self.radius = Int.getInt(data?["radius"])
        
        if let image = data?["image"] as? [String:Any]{
            self.image = image["attachment_url"] as? String
            self.baseUrl = image["base_url"] as? String
        }
        if let state = data?["state"] as? [String:Any]{
            self.state = CountryHubs.init(data: state)
        }
        
    }
    
    init(city data:[String:Any]?) {
        self.state_id = String.getString(data?["state_id"])
        self.state_name = String.getString(data?["state_name"])
        let hubsArray = kSharedInstance.getArray(withDictionary: data?["city_array"])
        self.hubs_array = hubsArray.map{CountryHubs(data: $0)}
        self.radius = Int.getInt(data?["radius"])
        if let image = data?["image"] as? [String:Any]{
            self.image = image["attachment_url"] as? String
            self.baseUrl = image["base_url"] as? String
        }
        if let state = data?["state"] as? [String:Any]{
            self.state = CountryHubs.init(data: state)
        }
    }
    init() {}
}
