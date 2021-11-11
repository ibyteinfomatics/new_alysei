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
    
    var blogModel:BlogModel?
    var blogId: String?
    
    var passSpecialization: String?
    var passBlogTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        blogTableView.delegate = self
        blogTableView.dataSource = self
        postRequestToGetBlog()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
        let controller = pushViewController(withName: BlogFilterVC.id(), fromStoryboard: StoryBoardConstants.kHome) as? BlogFilterVC
        controller?.passSpecialization = self.passSpecialization
        controller?.passBlogTitle = self.passBlogTitle
        controller?.passSelectedDataCallback = {  passSpecialization, passBlogTitle in
            self.passSpecialization = passSpecialization
            self.passBlogTitle = passBlogTitle
            
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func postRequestToGetBlog() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDiscoverListing+"\(blogId!)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
        let dictResponse = dictResponse as? [String:Any]
      if let data = dictResponse?["data"] as? [String:Any]{
        self.blogModel = BlogModel.init(with: data)
      }
        
        self.blogTableView.reloadData()
      }
      
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
        
        blogTableCell.readMoreButton.tag = indexPath
        
        
        blogTableCell.btnMoreCallback = { tag in
                
            check = "show"
            let vc = self.pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateBlogViewController
            vc.blogtitle = self.blogModel?.data?[indexPath].title
            vc.fulldescription = self.blogModel?.data?[indexPath].datumDescription
            vc.draft = self.blogModel?.data?[indexPath].status
            vc.imgurl = self.blogModel?.data?[indexPath].attachment?.attachmentURL
            vc.typeofpage = "read"
                    
        }
        
        
        blogTableCell.blogImage.setImage(withString: String.getString(kImageBaseUrl+(blogModel?.data?[indexPath].attachment?.attachmentURL)! ?? ""), placeholder: UIImage(named: "image_placeholder"))
        
        return blogTableCell
        
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
        return blogModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return self.getBlogTableCell(indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
