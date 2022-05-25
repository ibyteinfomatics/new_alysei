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
    func loadCacheImage(urlString: String) {
        self.image = UIImage(named: "image_placeholder")
            if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                self.image = cacheImage
                return
            }
            
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Couldn't download image: ", error)
                    return
                }
                
                guard let data = data else { return }
                let image = UIImage(data: data)
              //  imageCache.setObject(image, forKey: urlString as AnyObject)
                _ = self.imageCache.object(forKey: url.absoluteString as AnyObject)
                
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()

        }
}

