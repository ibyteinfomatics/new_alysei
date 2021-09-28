//
//  BlogsViewController.swift
//  Profile Screen
//
//  Created by mac on 28/08/21.
//

import UIKit

class BlogsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var myBlogLabel: UILabel!
    @IBOutlet weak var createBlogButton: UIButton!
    @IBOutlet weak var blogTableView: UITableView!
    @IBOutlet weak var vwBlank: UIView!
    
    var blogModel:BlogModel?
    var userId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blogTableView.delegate = self
        blogTableView.dataSource = self
        createBlogButton.layer.cornerRadius = 18
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userId != ""{
            createBlogButton.isHidden = true
        } else {
            createBlogButton.isHidden = false
        }
        postRequestToGetBlog()
    }
    func setUI(){
        if self.blogModel?.data?.count ?? 0 == 0{
            self.vwBlank.isHidden = false
        }else{
            self.vwBlank.isHidden = true
        }
    }
    @IBAction func create(_ sender: UIButton) {
      
        _ = pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome)
      
    }
    
    func getcurrentdateWithTime(timeStamp :String?) -> String {
        let time = Double.getDouble(timeStamp) / 1000
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd MMM YYYY"
        dateFormatter.locale =  Locale(identifier:  "en")
        let localDate = dateFormatter.string(from: date)
        
        return localDate
        
    }
    
    private func getBlogTableCell(_ indexPath: Int) -> UITableViewCell{
        
        let blogTableCell = blogTableView.dequeueReusableCell(withIdentifier: BlogsTableViewCell.identifier()) as! BlogsTableViewCell
        
        blogTableCell.blogTitle.text = blogModel?.data?[indexPath].title
        blogTableCell.blogDescription.text = blogModel?.data?[indexPath].datumDescription
        
        //let date = getcurrentdateWithTime(timeStamp: blogModel?.data?[indexPath].time)
        blogTableCell.dateTimeLabel.text = String.getString(blogModel?.data?[indexPath].date)
        
        blogTableCell.blogImage.layer.masksToBounds = false
        blogTableCell.blogImage.clipsToBounds = true
        blogTableCell.blogImage.layer.cornerRadius = 5
        
        blogTableCell.editButton.tag = indexPath
        blogTableCell.deleteButton.tag = indexPath
        blogTableCell.readMoreButton.tag = indexPath
        
        blogTableCell.btnDeleteCallback = { tag in
          
            
            //MARK:show Alert Message
            let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to delete this blog?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
               
                self.disableWindowInteraction()
              
                TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDeleteBlog+"\(self.blogModel?.data?[indexPath].blogID ?? 0)", requestMethod: .POST, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
                    
                    self.postRequestToGetBlog()
                }
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  
                self.parent?.dismiss(animated: true, completion: nil)
            }))
            //let parent = self.parentViewController?.presentedViewController as? HubsListVC
            self.parent?.present(refreshAlert, animated: true, completion: nil)
            
        }
        
        blogTableCell.btnEditCallback = { tag in
                    
            let vc = self.pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateBlogViewController
            vc.blogtitle = self.blogModel?.data?[indexPath].title
            vc.fulldescription = self.blogModel?.data?[indexPath].datumDescription
            vc.draft = self.blogModel?.data?[indexPath].status
            vc.imgurl = self.blogModel?.data?[indexPath].attachment?.attachmentURL
            vc.blo_id = self.blogModel?.data?[indexPath].blogID
            vc.typeofpage = "edit"
                    
        }
        
        blogTableCell.btnMoreCallback = { tag in
                    
            let vc = self.pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateBlogViewController
            vc.blogtitle = self.blogModel?.data?[indexPath].title
            vc.fulldescription = self.blogModel?.data?[indexPath].datumDescription
            vc.draft = self.blogModel?.data?[indexPath].status
            vc.imgurl = self.blogModel?.data?[indexPath].attachment?.attachmentURL
            vc.typeofpage = "read"
                    
        }
        
        if userId != ""{
            blogTableCell.deleteButton.isHidden = true
            blogTableCell.editButton.isHidden = true
        } else {
            blogTableCell.deleteButton.isHidden = false
            blogTableCell.editButton.isHidden = false
        }
        
        blogTableCell.blogImage.setImage(withString: String.getString(kImageBaseUrl+(blogModel?.data?[indexPath].attachment?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        
        return blogTableCell
        
    }
    
    private func postRequestToGetBlog() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetBlogListing+"\(userId!)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          self.blogModel = BlogModel.init(with: dictResponse)
        
        self.myBlogLabel.text = "My Blogs (\(self.blogModel?.data?.count ?? 0))"
        self.setUI()
        self.blogTableView.reloadData()
      }
      
    }
    
    
}
extension BlogsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getBlogTableCell(indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
