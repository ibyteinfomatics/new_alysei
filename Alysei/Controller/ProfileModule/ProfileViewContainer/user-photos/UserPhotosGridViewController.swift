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
    @IBOutlet weak var lblBlank: UILabel!

    var photos = [String]()
    var postData = [NewFeedSearchDataModel]()
    var pageNumber = 1
    var lastpage: Int?
    //TODO: pagination is pending
    var count = 100
    var visitorId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblBlank.text = AppConstants.ThereAreNoPhotosAtThisMoment
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
        super.viewWillAppear(false)
        pageNumber = 1
        self.fetchPostWithPhotsFromServer(pageNumber, visitorId: visitorId)
        self.fetchGetPostWithPhotsFromServer(pageNumber,visitorId: visitorId)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if pageNumber > self.lastpage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
                pageNumber += 1

            // call your API for more data
                self.fetchPostWithPhotsFromServer(pageNumber, visitorId: visitorId)
                self.fetchGetPostWithPhotsFromServer(pageNumber,visitorId: visitorId)

            // tell the table view to reload with the new data
            self.userPhotosCollectionView.reloadData()
            }
        }
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
       // cell.imageView.setImage(withString: "\(self.photos[indexPath.row])")
        let imgUrl = self.photos[indexPath.row]
        let imgUrl1 = URL(string: imgUrl)
    // cell.imageView.loadCacheImage(urlString: imgUrl)
        if imgUrl1 != URL(string: ""){
        cell.imageView.loadImageWithUrl(imgUrl1!)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = pushViewController(withName: PhotosPost.id(), fromStoryboard: StoryBoardConstants.kHome) as? PhotosPost
        vc?.position = indexPath.row
        vc?.visitorId = visitorId
        vc?.postData = self.postData
        vc?.tapIndex = indexPath.row
        vc?.pageNumber = self.pageNumber
        vc?.lastPage = self.lastpage
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
            
            switch statusCode {
            case 200:
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
                if page == 1{
                self.photos.removeAll()
                }
                if photosURLList.count > 0 {
                    //self.pageNumber += 1
                    
                    self.photos.append(contentsOf: photosURLList)
                    
//                    if photosURLList.count > 20 {
//                        self.pageNumber += 1
//
//                    }
                    
                    self.updatePhotosList()
                    self.setUI()
                }else{
                    self.setUI()
                }
                } catch {
                        print(error.localizedDescription)
                    }
                    
                case 409:
                if self.photos.count > 0 {
                        print("No remove")
                    }
                    
                default:
                    print("eror")
                    
               
            }
            }

        }
    func fetchGetPostWithPhotsFromServer(_ page: Int, count: Int = 30,visitorId: String) {
        let urlString = APIUrl.Profile.postList + "?page=\(page)&per_page=\(count)&visitor_profile_id=\(visitorId)"

        guard WebServices.shared.buildURLRequest(urlString, method: .GET) != nil else {
            return
        }
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, erroType, statusCode in
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"]  as? [String:Any]{
                self.lastpage = data["last_page"] as? Int
                if let subData = data["data"] as? [[String:Any]]{
                    let respostData = subData.map({NewFeedSearchDataModel.init(with: $0)})
                    if page == 1{
                        self.postData.removeAll()
                    }
                    self.postData.append(contentsOf: respostData)
                }
               
            
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

