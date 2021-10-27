//
//  PhotosPost.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/10/21.
//

import UIKit

class PhotosPost: AlysieBaseViewC {
    
    @IBOutlet weak var userPost: UITableView!
    
    var pageNumber = 1
    var visitorId = ""
    var position = 0
    //TODO: pagination is pending
    var count = 100

   // var postData = [PostList.innerData]()
    var postData = [NewFeedSearchDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.userPost.rowHeight = UITableView.automaticDimension
        self.userPost.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPostWithPhotsFromServer(pageNumber, visitorId: visitorId)
        
        
    }
    

    func updatePostList() {
        self.userPost.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePostsToComment" {
            if let model = sender as? PostCommentsUserData {
                if let viewCon = segue.destination as? PostCommentsViewController {
                    viewCon.postCommentsUserDataModel = model
                }
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension PhotosPost {
    func fetchPostWithPhotsFromServer(_ page: Int, count: Int = 30,visitorId: String) {
        let urlString = APIUrl.Profile.postList + "?page=\(page)&per_page=\(count)&visitor_profile_id=\(visitorId)"

        guard let request = WebServices.shared.buildURLRequest(urlString, method: .GET) else {
            return
        }
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { dictResponse, error, erroType, statusCode in
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"]  as? [String:Any]{
                if let subData = data["data"] as? [[String:Any]]{
                    self.postData = subData.map({NewFeedSearchDataModel.init(with: $0)})
                }
                self.updatePostList()
                let indexPaths = IndexPath(row: self.position, section: 0)
                //userPost.selectRow(at: indexPaths, animated: false, scrollPosition: .bottom)
                self.userPost.scrollToRow(at: indexPaths, at: .top, animated: false)
            }
        }

    }
}

extension PhotosPost : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userPost.dequeueReusableCell(withIdentifier: "PostDescTableViewCell", for: indexPath) as? PostDescTableViewCell else { return UITableViewCell() }

        let data = self.postData[indexPath.row]
        cell.configCell(data, indexPath.row)
        cell.sizeToFit()
        
        
        cell.configCell(self.postData[indexPath.row] , indexPath.row)
       // cell.btnMoreLess.tag = indexPath.row
        cell.relaodSection = indexPath.section
        
//        if data.isExpand == true{
//            cell.lblPostDesc.numberOfLines = 0
//            cell.btnMoreLess.setTitle("....less", for: .normal)
//        }else{
//            cell.lblPostDesc.numberOfLines = 2
//            cell.btnMoreLess.setTitle("....more", for: .normal)
//        }
        cell.likeCallback = { index in
            //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
            cell.lblPostLikeCount.text = "\(data.likeCount ?? 0)"
            cell.likeImage.image = data.likeFlag == 0 ? UIImage(named: "like_icon") : UIImage(named: "liked_icon")
            
            
            
        }
        cell.reloadCallBack = { tag, section in
            let data = self.postData[tag ?? -1]
            
            if data.isExpand == false{
                data.isExpand = true
            }else{
                data.isExpand = false
            }
            //self.postTableView.reloadData()
            let indexPath = IndexPath(row: tag ?? -1, section: indexPath.section)
            self.userPost.reloadRows(at: [indexPath], with: .automatic)
            self.userPost.scrollToRow(at: indexPath, at: .top, animated: false)

        }
        
       // cell.menuDelegate = self

        cell.commentCallback = { postCommentsUserData in
            self.showCommentScreen(postCommentsUserData)
        }
        
        
        return cell
    }
    
    func showCommentScreen(_ model: PostCommentsUserData) {
        self.performSegue(withIdentifier: "seguePostsToComment", sender: model)
    }


//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
