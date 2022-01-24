//
//  UserPhotosGridViewController.swift
//  Alysei
//
//  Created by Janu Gandhi on 04/06/21.
//

import UIKit
import Foundation

class UserPhotosGridViewController: AlysieBaseViewC {

    @IBOutlet weak var userPhotosCollectionView: UICollectionView!
    @IBOutlet weak var vwBlank: UIView!

    var photos = [String]()
    var pageNumber = 1

    //TODO: pagination is pending
    var count = 100
    var visitorId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.userPhotosCollectionView.delegate = self
        self.userPhotosCollectionView.dataSource = self

        
        
    }

    func updatePhotosList() {
        self.userPhotosCollectionView.reloadData()
    }
    func setUI(){
        if photos.count == 0{
            self.vwBlank.isHidden = false
        }else{
            self.vwBlank.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPostWithPhotsFromServer(pageNumber, visitorId: visitorId)
    }


}

extension UserPhotosGridViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserPhotosGridCollectionViewCell else {
            return UICollectionViewCell()
        }

        ///////cell.imageView.setImage(withString: "\(kImageBaseUrl)\(self.photos[indexPath.row])")
        cell.imageView.setImage(withString: "\(self.photos[indexPath.row])")

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = pushViewController(withName: PhotosPost.id(), fromStoryboard: StoryBoardConstants.kHome) as? PhotosPost
        vc?.position = indexPath.row
        vc?.visitorId = visitorId
        
    }

}


extension UserPhotosGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewWitdh = collectionView.frame.width - 6
        let cellWidth = collectionViewWitdh / 3

        return CGSize(width: cellWidth, height: cellWidth)
    }
}


extension UserPhotosGridViewController {
    func fetchPostWithPhotsFromServer(_ page: Int, count: Int = 30,visitorId: String) {
        let urlString = APIUrl.Profile.photoList + "?page=\(page)&per_page=\(count)&visitor_profile_id=\(visitorId)"

        guard let request = WebServices.shared.buildURLRequest(urlString, method: .GET) else {
            return
        }
        WebServices.shared.request(request) { data, URLResponse, statusCode, error in
            print("some")

            guard statusCode == 200 else { return }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(PhotosList.request.self, from: data)
                print(response)

                let photosURLList = response.data.data.reduce( [String]() ) { res, innerData in
                    
//                    let result =  innerData.attachments.reduce([String]()) { resultInner, attachments in
//                          var innerResult = resultInner
//                        innerResult.append((innerData.attachments.first?.attachment_link.attachment_url)!)
//                          return innerResult
//                      }
                    var innerResult = res
                    if innerData.attachments.first?.attachment_link.attachment_url != nil {
                        let baseurl = innerData.attachments.first?.attachment_link.base_url ?? ""
                        innerResult.append(baseurl + (innerData.attachments.first?.attachment_link.attachment_url ?? ""))
                    }
                    
                  
                    return innerResult
                   
//                  let result =  innerData.attachments.reduce([String]()) { resultInner, attachments in
//                        var innerResult = resultInner
//                        innerResult.append(attachments.attachment_link.attachment_url)
//                        return innerResult
//                    }
                    //return result
                }
                self.photos.removeAll()
                if photosURLList.count > 0 {
                    //self.pageNumber += 1
                    
                    self.photos.append(contentsOf: photosURLList)
                    
                    if photosURLList.count > 20 {
                        self.pageNumber += 1
                        
                    }
                    
                    self.updatePhotosList()
                }
                self.setUI()
            } catch {
                print(error.localizedDescription)
            }

        }
    }
}


extension UserPhotosGridViewController {
//    struct viewModel {
//        var response: Photos.request
//        var attachments: [Photos.attachments] { response.data.data. }
//    }



    enum PhotosList {
        struct request: Codable {
            var data: outerData
            var success: Int
        }

        struct outerData: Codable {
            var data: [innerData]
        }

        struct innerData: Codable {
            var attachments: [attachments]
        }

        struct attachments: Codable {
            var attachment_link: attachment_link
        }

        struct attachment_link: Codable {
            var attachment_url: String
            var base_url: String
        }
    }
}

