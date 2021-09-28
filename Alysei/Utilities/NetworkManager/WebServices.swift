//
//  WebServices.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/03/21.
//

import UIKit

class WebServices {
    
    //Shared Instance of WebServices
    static let shared = WebServices()
    
    func request(_ urlRequest: URLRequest,completion: @escaping (Data? , URLResponse?, Int?, Error?) -> ()){
        var request = urlRequest

        URLSession.shared.dataTask(with: request){ (data, response, error) in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    completion(data,response, statusCode, error)
                }
            }
        }.resume()
    }

    func buildURLRequest(_ urlString: String, method: kHTTPMethod) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }

        let token = "Bearer " + String.getString(kSharedUserDefaults.loggedInUserModal.accessToken)

        var request = URLRequest(url: url)
        request.setValue(self.userAgent(), forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("\(TimeZone.current.identifier)", forHTTPHeaderField: "timezone")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = method.rawValue
        return request
    }


    private  func userAgent() -> String {
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
        let bundle = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        let systemVersion = UIDevice.current.systemVersion
        return "\(appName)/\(currentVersion) (\(bundleIdentifier); build:\(bundle); iOS:\(systemVersion)) URLSession"
    }
}
