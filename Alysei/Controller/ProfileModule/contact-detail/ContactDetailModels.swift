//
//  ContactDetailModels.swift
//  Alysei
//
//  Created by Janu Gandhi on 07/04/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ContactDetail {
    // MARK: Use cases
    
    enum Contact {
        struct Request {
            var phone: String?
            var address: String?
            var website: String?
            var facebookURL: String?
            var countryCode: String?
            var lattitude: Double?
            var longitude: Double?

            func data() -> Data? {

                let postData = NSMutableData()

                if let phone = self.phone {
                    postData.append("phone=\(phone)&".data(using: .utf8)!)
                    if let countryCode = self.countryCode {
                        postData.append("country_code=\(countryCode)&".data(using: .utf8)!)
                    }
                }
                if let address = self.address {
                    postData.append("address=\(address)&".data(using: .utf8)!)
                }
                if let website = self.website {
                    postData.append("website=\(website)&".data(using: .utf8)!)
                }
                if let facebookURL = self.facebookURL {
                    postData.append("fb_link=\(facebookURL)&".data(using: .utf8)!)
                }
                if let lattitude = self.lattitude {
                    postData.append("lattitude=\(lattitude)&".data(using: .utf8)!)
                }
                if let longitude = self.longitude {
                    postData.append("longitude=\(longitude)&".data(using: .utf8)!)
                }
                return postData as Data

            }
        }

        struct Response: Codable {
            var data: detailModel
        }
        struct ViewModel: Codable {
            var response: Response
            var email: String { response.data.email }
            var phone: String? { response.data.phone }
            var address: String? { response.data.address }
            var websiteURL: String? { response.data.website }
            var facebookURL: String? { response.data.fb_link }
            var countryCode: String? { response.data.country_code }
            var lattitude: Double{ response.data.lattitude ?? 0.0 }
            var longitude: Double{ response.data.longitude ?? 0.0 }
        }




        struct detailModel: Codable {
            var email: String
            var phone: String?
            var address: String?
            var website: String?
            var fb_link: String?
            var country_code: String?
            var lattitude: Double?
            var longitude: Double?
        }
    }

    enum view {
        struct tableCellModel {
            var imageName: String
            var title: String
            var value: String
        }
    }
}
