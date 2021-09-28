//
//  AmountViewModel.swift
//  Alysei
//
//  Created by Janu Gandhi on 09/04/21.
//

import Foundation

enum AboutView {
    
    struct Response<T: Codable>: Codable {
        var data:  T?

        private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
    }

    struct viewModel: Codable {
        var userRole: UserRoles
        var detail: String? // about
        var staticDetail: String?
        var subDetail: String?
        var staticSubdetail: String?
        var rows: [String]?
        var listTitle: String?

        var secondList: [String]?
        var secondListTitle: String?
    }

    struct intermediatorModel<T: Codable>: Codable {
        private var response: Response<T>
        var userRole: UserRoles
        var detail: String? // about
        var staticDetail: String?
        var subDetail: String?
        var staticSubdetail: String?
        var listTitle: String?

        var rows: [String]?

        var secondList: [String]?
        var secondListTitle: String?



        init(_ response: Response<T>, userRole: UserRoles) {
            self.response = response
            self.userRole = userRole

            self.setup()
        }

        mutating func setup() {
            switch userRole {
            case .producer, .distributer1, .distributer2, .distributer3:
                let data = response.data as? producerDataModel
                self.rows = data?.productType
                self.detail = data?.about
                self.subDetail = data?.products
                self.listTitle = "Product Type"
                self.staticDetail = "About"
                self.staticSubdetail = "Our Products"
            case .restaurant:
                let data = response.data as? restaurantDataModel
                self.rows = data?.restaurantType
                self.detail = data?.about
                self.subDetail = data?.menu
                self.listTitle = "Restaurant Type"
                self.staticDetail = "About"
                self.staticSubdetail = "Menu"
            case .voiceExperts:
                let data = response.data as? voiceExpertDataModel
                self.rows = data?.title
                self.detail = data?.about
                self.subDetail = data?.country
                self.secondList = data?.expertise
                self.listTitle = "Title"
                self.staticDetail = "About"
                self.staticSubdetail = "Country"
                self.secondListTitle = "Expertise"
            case .travelAgencies:
                let data = response.data as? travelAgencyDataModel
                self.rows = data?.speciality
                self.detail = data?.about
                self.subDetail = data?.ourTours
                self.secondListTitle = data?.country
                self.listTitle = "Speciality"
                self.staticDetail = "About"
                self.staticSubdetail = "Our tours"
            default: break
            }
        }
    }


    struct producerDataModel: Codable {
        var productType: [String]?
        var about: String?
        var products: String?
        private enum CodingKeys: String, CodingKey {
            case productType = "Product Type"
            case about = "About"
            case products = "Our Products"
        }
    }

    struct restaurantDataModel: Codable {
        var restaurantType: [String]?
        var about: String?
        var menu: String?
        private enum CodingKeys: String, CodingKey {
            case restaurantType = "Restaurant Type"
            case about = "About"
            case menu = "Menu"
        }
    }

//    struct importorDataModel: Codable {
//        var restaurantType: [String]?
//        var about: String?
//        var Menu: String?
//        private enum CodingKeys: String, CodingKey {
//            case restaurantType = "Restaurant Type"
//            case about = "About"
//            case Menu = "Menu"
//        }
//    }


    struct voiceExpertDataModel: Codable {
        var expertise: [String]?
        var title: [String]?
        var about: String?
        var country: String?
        private enum CodingKeys: String, CodingKey {
            case expertise = "Expertise"
            case title = "Title"
            case about = "About"
            case country = "Country"
        }
    }


    struct travelAgencyDataModel: Codable {
        var speciality: [String]?
        var about: String?
        var ourTours: String?
        var country: String?
        private enum CodingKeys: String, CodingKey {
            case speciality = "Speciality"
            case about = "About"
            case country = "Country"
            case ourTours = "Our tours"
        }
    }


//    struct voyagersDataModel: Codable {
//        var restaurantType: [String]?
//        var about: String?
//        var Menu: String?
//        private enum CodingKeys: String, CodingKey {
//            case restaurantType = "Restaurant Type"
//            case about = "About"
//            case Menu = "Menu"
//        }
//    }
}


////
//enum UserRoles: Int {
//    case producer = 3
//    case distributer1 = 4
//    case distributer2 = 5
//    case distributer3 = 6
//    case voiceExperts = 7
//    case travelAgencies = 8
//    case restaurant =  9
//    case voyagers = 10
//}

// Product Type", "About", "Our Products"

//for user type 8
//"Country", "Speciality", "About", "Our tours"
//
//for user type 9
//"Restaurant Type", "About", "Menu"
