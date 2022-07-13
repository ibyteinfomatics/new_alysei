//
//  BlogDiscover.swift
//  Alysei
//
//  Created by Gitesh Dang on 09/11/21.
//

import UIKit

class BlogDiscover: AlysieBaseViewC {
    
    
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var blogTableView: UITableView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var blogModel:BlogModel?
    var blogData = [BlogDatum]()
    var blogId: String?
    
    var passSpecialization: String?
    var passBlogTitle: String?
    
    var indexOfPageToRequest = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.drawBottomShadow()
        lblTitle.text = AppConstants.kBlogs
        blogTableView.delegate = self
        blogTableView.dataSource = self
        blogId = "blogs"
        
        postRequestToGetBlog(indexOfPageToRequest)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
        let controller = pushViewController(withName: BlogFilterVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? BlogFilterVC
        controller?.passSpecialization = self.passSpecialization
        controller?.passBlogTitle = self.passBlogTitle
        controller?.passSelectedDataCallback = {  passSpecializationID, passBlogTitleID in
            self.passSpecialization = passSpecializationID
            self.passBlogTitle = passBlogTitleID
            self.callFilterApi (1)
        }
        
        controller?.clearFiltercCallBack = {
            self.passBlogTitle = ""
            self.passSpecialization = ""
            self.callFilterApi(1)
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
   
    
    private func getBlogTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let blogTableCell = blogTableView.dequeueReusableCell(withIdentifier: BlogsTableViewCell.identifier()) as! BlogsTableViewCell
        blogTableCell.readMoreButton.setTitle(AppConstants.kReadMore, for: .normal)
        blogTableCell.blogTitle.text = blogData[indexPath].title
        blogTableCell.blogDescription.text = blogData[indexPath].datumDescription
        blogTableCell.imgUser.layer.cornerRadius = blogTableCell.imgUser.frame.height / 2
        blogTableCell.imgUser.layer.masksToBounds = true
        blogTableCell.editButton.makeCornerRadius(radius: blogTableCell.editButton.frame.height / 2)
        blogTableCell.editButton.isHidden = true
        blogTableCell.deleteButton.makeCornerRadius(radius: blogTableCell.deleteButton.frame.height / 2)
        blogTableCell.deleteButton.isHidden = true
        blogTableCell.vwContainerlbl.layer.cornerRadius = 15
        //let date = getcurrentdateWithTime(timeStamp: blogModel?.data?[indexPath].time)
       // blogTableCell.dateTimeLabel.text = String.getString(blogData[indexPath].createdAt)
        
         let dateFormatterGet = DateFormatter()
         dateFormatterGet.dateFormat = "yyyy-MM-dd"

         let dateFormatterPrint = DateFormatter()
         dateFormatterPrint.dateFormat = "MMM dd, yyyy"

         let date: Date? = dateFormatterGet.date(from: blogData[indexPath].date ?? "")
         let datep = dateFormatterPrint.string(from: date ?? Date())
        blogTableCell.dateTimeLabel.text = datep
        if String.getString(blogData[indexPath].status) == "0"{
            blogTableCell.lblDraftPublsh.text = RecipeConstants.kDraft
        }else{
            blogTableCell.lblDraftPublsh.text = RecipeConstants.kPublish
        }
//        let imageurl = blogModel?.data?[indexPath].user?.avatarID?.attachmentURL
//        blogTableCell.imgUser.setImage(withString: (kImageBaseUrl + "\(imageurl ?? "")"))
//        blogTableCell.lblAuthorName.text = "\(blogModel?.data?[indexPath].user?.firstName ?? "")" + "\(blogModel?.data?[indexPath].user?.lastName ?? "")"
        
        
        let imageurl = "\(blogData[indexPath].user?.avatarID?.baseUrl ?? "")"
 + "\(blogData[indexPath].user?.avatarID?.attachmentURL ?? "")"
        blogTableCell.imgUser.setImage(withString: imageurl, placeholder: UIImage(named: "profile_icon"))
        blogTableCell.lblAuthorName.text = "\(blogData[indexPath].user?.firstName ?? "")" + "\(blogData[indexPath].user?.lastName ?? "")"
//        blogTableCell.blogImage.layer.masksToBounds = false
//        blogTableCell.blogImage.clipsToBounds = true
//        blogTableCell.blogImage.layer.cornerRadius = 5
        
        blogTableCell.readMoreButton.tag = indexPath
        
        
        blogTableCell.btnMoreCallback = { tag in
                
            check = "show"
            let vc = self.pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateBlogViewController
            vc.blogtitle = self.blogData[indexPath].title
            vc.fulldescription = self.blogData[indexPath].datumDescription
            vc.draft = self.blogData[indexPath].status
            vc.imgurl = String.getString((self.blogData[indexPath].attachment?.baseUrl ?? "") + (self.blogData[indexPath].attachment?.attachmentURL ?? ""))
            vc.typeofpage = "read"
                    
        }
        
        let imageString = String.getString((blogData[indexPath].attachment?.baseUrl ?? "") + (blogData[indexPath].attachment?.attachmentURL ?? "").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)! )
           if imageString != "" {
            let imageBlogUrl = URL(string: imageString)!
            blogTableCell.blogImage.loadImageWithUrl(imageBlogUrl)
            
        }
        
       // blogTableCell.blogImage.setImage(withString: String.getString((blogData[indexPath].attachment?.baseUrl ?? "") + (blogData[indexPath].attachment?.attachmentURL ?? "")), placeholder: UIImage(named: "image_placeholder"))
        
        return blogTableCell
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if indexOfPageToRequest > blogModel?.lastPage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
            indexOfPageToRequest += 1

            // call your API for more data
                postRequestToGetBlog(indexOfPageToRequest)

            // tell the table view to reload with the new data
            self.blogTableView.reloadData()
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
extension BlogDiscover: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getBlogTableCell(indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension BlogDiscover {
    
    func callFilterApi (_ pageNo: Int?) {
       // self.blogModel = BlogModel(with: [:])
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Discover.kDiscoverBlogSearch + "&title=" + "\(self.passBlogTitle ?? "")" + "&specialization=" + "\(self.passSpecialization ?? "")"+"&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
            let dictResponse = dictResponse as? [String:Any]
              if let data = dictResponse?["data"] as? [String:Any]{
                self.blogModel = BlogModel.init(with: data)
              }
            if self.indexOfPageToRequest == 1 { self.blogData.removeAll() }
                self.blogData.append(contentsOf: self.blogModel?.data ?? [BlogDatum(with: [:])])
        case 409:
            if pageNo == 1{
                self.blogData.removeAll()
            }
        default:
            print("Error")
      }
            self.blogTableView.reloadData()
              
        }
        
    }
    
    private func postRequestToGetBlog(_ pageNo: Int?) -> Void{
      
      disableWindowInteraction()
     
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(self.blogId ?? "")"+"&page=\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
        let dictResponse = dictResponse as? [String:Any]
      if let data = dictResponse?["data"] as? [String:Any]{
        self.blogModel = BlogModel.init(with: data)
        
        if self.indexOfPageToRequest == 1 { self.blogData.removeAll() }
        
        self.blogData.append(contentsOf: self.blogModel?.data ?? [BlogDatum(with: [:])])
               
      }
        
        self.blogTableView.reloadData()
      }
      
    }
    
}
