//
//  StateHubModel.swift
//  Alysie
//
//  Created by Gitesh Dang on 04/03/21.
//

import Foundation

class StateHubModel:NSObject {
    var hubs: [Hubs]?
    var cities: [Hubs]?
    
    init(with data: [String:Any]) {
        super.init()
        if let data = data["hubs"] as? [[String:Any]]{
            self.hubs = data.map({Hubs.init(with: $0)})
        }
        if let data = data["cities"] as? [[String:Any]]{
            self.cities = data.map({Hubs.init(with: $0)})
        }
    }
    
}
 
class Hubs:NSObject{
    var state_id: String?
    var state_name: String?
    var hubs_array: [SignUpOptionsDataModel]?
    var city_array: [SignUpOptionsDataModel]?
    
    init(with data: [String:Any]) {
        super.init()
        self.state_id = data["state_id"] as? String
        self.state_name = data["state_name"] as? String
        if let data = data["hubs_array"] as? [[String:Any]]{
            self.hubs_array = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
        }
        if let data = data["city_array"] as? [[String:Any]]{
            self.city_array = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
        }
    }
}

class SelectCitiesModel:NSObject{
    var country_id: String?
    var state_id:String?
    var city_id:String?
    
    init(with data: [String:Any]){
        super.init()
        self.country_id = data["country_id"] as? String
        self.state_id = data["state_id"] as? String
        self.city_id = data["city_id"] as? String
    }
}


//MARK: SHOWHUBLISTMODEL

class ShowConfirmHubList:NSObject{
    var country: [SelectedCountryData]?
    
    init(with data: [String:Any]) {
        super.init()
        if let data = data["country"] as? [[String:Any]]{
            self.country = data.map({SelectedCountryData.init(with: $0)})
        }
    }
}
class SelectedCountryData:NSObject {
    var country_id : String?
    var country_name: String?
    var selectedStates: [SelectedStates]?
    
    init(with data: [String:Any]) {
        super.init()
        if let data = data["selectedStates"] as? [[String:Any]]{
            self.selectedStates = data.map({SelectedStates.init(with: $0)})
        }
        self.country_id = data["country_id"] as? String
        self.country_name = data["country_name"] as? String
    }
}

class SelectedStates : NSObject{
    var state_name: String?
    var state_id:String?
    var selectedHubList: [HubCityModel]?
    var selectedCitiesList: [HubCityModel]?
   
    init(with data: [String:Any]) {
        super.init()
        if let data = data["selectedHubList"] as? [[String:Any]]{
            self.selectedHubList = data.map({HubCityModel.init(with: $0)})
        }
        self.state_name = data["state_name"] as? String
        self.state_id = data["state_id"] as? String
    }
}

class HubCityModel: NSObject {
    var hub_name: String?
    var city_name: String?
    var hub_id:String?
    var city_id: String?
   
    init(with data: [String:Any]) {
        super.init()
        
        self.hub_name = data["hub_name"] as? String
        self.city_name = data["city_name"] as? String
        self.hub_id = data["hub_id"] as? String
        self.city_id = data["city_id"] as? String
    }
}




//class HubArray {
//    var id: String?
//    var country_id:String??
//    var state_id:String?
//    var title: String?
//    
//    init(with data: [String:Any]?) {
//  
//        self.id = data?["id"] as? String
//        self.country_id = data?["country_id"] as? String
//        self.state_id = data?["state_id"] as? String
//        self.title = data?["title"] as? String
//    }
//}
