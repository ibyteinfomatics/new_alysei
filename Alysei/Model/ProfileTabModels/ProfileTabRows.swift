//
//  ProfileTabRows.swift
//  Alysei
//
//  Created by Janu Gandhi on 23/05/21.
//

import Foundation

struct ProfileTabRows {

    func noOfRows(_ userRole: UserRoles) -> Int {
//        switch userRole {
//        case .producer:
//            return 5
//        case .distributer1:
//            return 5
//        case .distributer2:
//            return 5
//        case .distributer3:
//            return 5
//        case .voiceExperts:
//            return 5
//        case .travelAgencies:
//            return 5
//        case .restaurant:
//            return 5
//        case .voyagers:
//            return 5
//        }

        return self.rowsTitle(userRole).count
    }

    func rowsTitle(_ userRole: UserRoles) -> [String] {
        switch userRole {
        case .producer:
            return ["Post" , "Photos", "About", "Contact", "Awards"]
        case .distributer1:
            return ["Post" , "Photos", "About", "Contact", "Awards"]
        case .distributer2:
            return ["Post" , "Photos", "About", "Contact", "Awards"]
        case .distributer3:
            return ["Post" , "Photos", "About", "Contact", "Awards"]
        case .voiceExperts:
            return ["Post" , "Photos", "About", "Contact", "Awards", "Blogs"]
        case .travelAgencies:
            return ["Post" , "Photos", "About", "Contact", "Awards", "Trips"]
        case .restaurant:
            return ["Post" , "Photos", "About", "Contact", "Awards", "Events"]
        case .voyagers:
            return ["Post" , "Photos", "About", "Contact"]
        }
    }


    func imageName(_ userRole: UserRoles) -> [String] {
        switch userRole {
        case .producer:
            return ["all", "photos", "about", "contact", "awards" ]
        case .distributer1:
            return ["all", "photos", "about", "contact", "awards" ]
        case .distributer2:
            return ["all", "photos", "about", "contact", "awards" ]
        case .distributer3:
            return ["all", "photos", "about", "contact", "awards" ]
        case .voiceExperts:
            return ["all", "photos", "about", "contact", "awards" ,"blogs"]
        case .travelAgencies:
            return ["all", "photos", "about", "contact", "awards" ,"trips"]
        case .restaurant:
            return ["all", "photos", "about", "contact", "awards"  ,"events"]
        case .voyagers:
            return ["all", "photos", "about", "contact"]
        }
    }

}
