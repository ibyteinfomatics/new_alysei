//
//  CustomImageView.swift
//  Alysei
//
//  Created by SHALINI YADAV on 2/7/22.
//

import Foundation
import UIKit

class CustomImageView: UIImageView{
    var task: URLSessionDataTask!
    var imageCache = NSCache<AnyObject,AnyObject>()
    func loadImageUrl(_ url: URL){
        image = UIImage(named: "image_placeholder")
        if let task = task{
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let newImage = UIImage(data: data) else{
                print("Error Loading")
                return
                
            }
            self.imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = newImage
            }
            
        }
        task.resume()
    }
}
