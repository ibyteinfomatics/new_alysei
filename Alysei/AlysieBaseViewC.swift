//
//  AlysieBaseViewC.swift
//  Alysie
//
//  Created by CodeAegis on 12/01/21.
//

import UIKit
import CoreLocation
import Alamofire

class AlysieBaseViewC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func pushViewController(withName name: String, fromStoryboard storyboard: String) -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        //
        //    let transition = CATransition()
        //        transition.duration = 0.5
        //    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //        transition.type = CATransitionType.moveIn
        //        transition.subtype = CATransitionSubtype.fromRight
        //        self.navigationController?.view.layer.add(transition, forKey: nil)
        
        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }
    
    func getAddressFromGeoCodeAPI(latitude: Double, longitude: Double, handler completionBlock: @escaping (_ response: String?) -> ()) {
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=" + kSharedAppDelegate.googleAPIKey
        
        Alamofire.Session.default.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print(response)
                let responseJson = response.value as! NSDictionary
                
                var sublocality1: String = ""
                var sublocality2: String = ""
                var sublocality3: String = ""
                var locality: String = ""
                
                if let results = responseJson.object(forKey: "results")! as? [NSDictionary] {
                    
                    if results.count > 0 {
                        
                        if let addressComponents = results[0]["address_components"]! as? [NSDictionary] {
                            let address = results[0]["formatted_address"] as? String
                            
                            for component in addressComponents {
                                let temp = component.object(forKey: "types") as! [String]
                                
                                if temp.contains("sublocality_level_3"){
                                    sublocality3 = String.getString(component["long_name"]) + ",  "
                                }
                                
                                if temp.contains("sublocality_level_2"){
                                    sublocality2 = String.getString(component["long_name"]) + ",  "
                                }
                                
                                if temp.contains("sublocality_level_1"){
                                    sublocality1 = String.getString(component["long_name"])
                                }
                                
                                if temp.contains("locality"){
                                    locality = String.getString(component["long_name"])
                                }
                            }
                            if ((String.getString(sublocality3).isEmpty == true) && (String.getString(sublocality2).isEmpty == true) && (String.getString(sublocality1).isEmpty == true)){
                                
                                if String.getString(locality).isEmpty == true{
                                    completionBlock(String.getString(address))
                                }
                                else{
                                    completionBlock(String.getString(locality))
                                }
                            }
                            else {
                                completionBlock(sublocality3 + sublocality2 + sublocality1)
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func disableWindowInteraction(){
        if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
            window.isUserInteractionEnabled = false
        }
    }
    func enableWindowInteraction(){
        if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
            window.isUserInteractionEnabled = true
        }
    }
}
