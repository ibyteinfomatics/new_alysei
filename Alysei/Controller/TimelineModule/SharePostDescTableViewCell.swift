//
//  SharePostDescTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 9/22/21.
//

import UIKit
import ScrollingPageControl

struct SharedPostLikeUnlikeRequestModel: Codable {
    let postOwnerID: Int
    let userID: Int
    let postID: Int
    let likeStatus: Int

    private enum CodingKeys: String, CodingKey {
        case postOwnerID = "post_owner_id"
        case userID = "user_id"
        case postID = "post_id"
        case likeStatus = "like_status"
    }
}
//protocol SharedPostEditMenuProtocol {
//    func menuBttonTapped(_ postID: Int?, userID: Int)
//}

class SharePostDescTableViewCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    //@IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var lblPostDesc: UILabel!
    @IBOutlet weak var lblPostLikeCount: UILabel!
    @IBOutlet weak var lblPostCommentCount: UILabel!
    @IBOutlet weak var imageHeightCVConstant: NSLayoutConstraint!
    @IBOutlet weak var imagePostCollectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentImage: UIView!
    @IBOutlet weak var lblPostTime: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var lblSharePostDesc: UILabel!
    @IBOutlet weak var lblSharedUserName: UILabel!
    @IBOutlet weak var lblSharedUserEmail: UILabel!
    @IBOutlet weak var imgSharedUserImage: UIImageView!
    @IBOutlet weak var lblSharedPostDesc: UILabel!
    @IBOutlet weak var lblSharedUserTitle: UILabel!
    @IBOutlet weak var follower: UILabel!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet var vwpageControl: ScrollingPageControl!
    
    var data: NewFeedSearchDataModel?
    var index: Int?
    var imageArray = [String]()
    var menuDelegate: ShareEditMenuProtocol!
    
    var likeCallback:((Int) -> Void)? = nil
    var commentCallback:((PostCommentsUserData) -> Void)? = nil
    var islike: Int?
    var shareCallback:(()->())?
    var profileCallback:(() -> ())?
    var sharedProfileCallback:(() -> ())?
    var pages = 0
    let stackView = UIStackView()
    override func awakeFromNib() {
        super.awakeFromNib()
        pageControlUI()
        setUI()
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        tap.numberOfTouchesRequired = 1
        self.viewLike.addGestureRecognizer(tap)


        let tap2 = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        tap2.numberOfTapsRequired = 2


        self.imagePostCollectionView.addGestureRecognizer(tap2)


        let showCommentsGesture = UITapGestureRecognizer(target: self, action: #selector(self.showCommentsScreen))
        showCommentsGesture.numberOfTouchesRequired = 1
        self.commentImage.addGestureRecognizer(showCommentsGesture)
        
        let showSharesGesture = UITapGestureRecognizer(target: self, action: #selector(self.showShareScreen))
        showSharesGesture.numberOfTouchesRequired = 1
        self.viewShare.addGestureRecognizer(showSharesGesture)
        
        let userimg = UITapGestureRecognizer(target: self, action: #selector(self.profileScreen(_:)))
        userimg.numberOfTouchesRequired = 1
        self.imgSharedUserImage.isUserInteractionEnabled = true
        self.imgSharedUserImage.addGestureRecognizer(userimg)
        
        let shareduserimg = UITapGestureRecognizer(target: self, action: #selector(self.profileShareScreen(_:)))
        shareduserimg.numberOfTouchesRequired = 1
        self.userImage.isUserInteractionEnabled = true
        self.userImage.addGestureRecognizer(shareduserimg)
        
        
        // Initialization code
    }
    func setUI(){
        vwHeader.addShadow()
        self.userImage.layer.cornerRadius = self.userImage.frame.height / 2
        self.userImage.layer.masksToBounds = true
        self.imgSharedUserImage.layer.cornerRadius = self.userImage.frame.height / 2
        self.imgSharedUserImage.layer.masksToBounds = true
        self.menuButton?.imageView?.contentMode = .scaleAspectFit
    }
    func pageControlUI(){
        let startIndex = IndexPath(item: 0, section: 0)
        //imagePostCollectionView.scrollToItem(at: startIndex, at: .centeredHorizontally, animated: false)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        self.vwpageControl.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.vwpageControl.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.vwpageControl.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.vwpageControl.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.vwpageControl.heightAnchor).isActive = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


func configCell(_ modelData: NewFeedSearchDataModel, _ index: Int) {

    let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0

   

    self.data = modelData
//        self.index = index
    self.index = self.data?.postID ?? 0
    
   
    if modelData.subjectId?.roleId == UserRoles.producer.rawValue{
        lblSharedUserTitle.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserName.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserEmail.text = "Producer,"//modelData.subjectId?.email?.lowercased()
    }else if modelData.subjectId?.roleId == UserRoles.restaurant.rawValue{
        lblSharedUserTitle.text = modelData.subjectId?.restaurantName?.capitalized
        lblSharedUserName.text = modelData.subjectId?.restaurantName?.capitalized
        lblSharedUserEmail.text = "Restaurant,"//modelData.subjectId?.email?.lowercased()
    }else if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
        lblSharedUserTitle.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
        lblSharedUserName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
        lblSharedUserEmail.text = "Voyager"//modelData.subjectId?.email?.lowercased()
    }else if modelData.subjectId?.roleId == UserRoles.voiceExperts.rawValue{
        lblSharedUserTitle.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
        lblSharedUserName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
        lblSharedUserEmail.text = "Voice Of Experts,"//modelData.subjectId?.email?.lowercased()
    }else if modelData.subjectId?.roleId == UserRoles.distributer1.rawValue {
        lblSharedUserTitle.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserName.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserEmail.text = "Importer,"//modelData.subjectId?.email?.lowercased()
    }else if modelData.subjectId?.roleId == UserRoles.distributer2.rawValue{
        lblSharedUserTitle.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserName.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserEmail.text = "Distributer,"//modelData.subjectId?.email?.lowercased()
    }else if modelData.subjectId?.roleId == UserRoles.distributer3.rawValue{
        lblSharedUserTitle.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserName.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserEmail.text = "Importer & Distributer,"//modelData.subjectId?.email?.lowercased()
    }else if modelData.subjectId?.roleId == UserRoles.travelAgencies.rawValue{
        lblSharedUserTitle.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserName.text = modelData.subjectId?.companyName?.capitalized
        lblSharedUserEmail.text = "Travel Agencies,"//modelData.subjectId?.email?.lowercased()
    }
    
    if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
        
        follower.isHidden = true
    } else {
        follower.isHidden = false
        follower.text = "\(modelData.follower_count ?? 0) Followers"
    }
    
    
    
    if modelData.sharedPostData?.subjectId?.roleId == UserRoles.producer.rawValue{
        userName.text = modelData.sharedPostData?.subjectId?.companyName?.capitalized
    }else if modelData.sharedPostData?.subjectId?.roleId == UserRoles.restaurant.rawValue{
        userName.text = modelData.sharedPostData?.subjectId?.restaurantName?.capitalized
    }else if(modelData.sharedPostData?.subjectId?.roleId == UserRoles.voyagers.rawValue){
        userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
    }else if modelData.sharedPostData?.subjectId?.roleId == UserRoles.voiceExperts.rawValue{
        userName.text = "\(modelData.sharedPostData?.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
    }else if modelData.sharedPostData?.subjectId?.roleId == UserRoles.distributer1.rawValue {
        userName.text = modelData.sharedPostData?.subjectId?.companyName?.capitalized
    }else if modelData.sharedPostData?.subjectId?.roleId == UserRoles.distributer2.rawValue{
        userName.text = modelData.sharedPostData?.subjectId?.companyName?.capitalized
    }else if modelData.sharedPostData?.subjectId?.roleId == UserRoles.distributer3.rawValue{
        userName.text = modelData.sharedPostData?.subjectId?.companyName?.capitalized
    }else if modelData.sharedPostData?.subjectId?.roleId == UserRoles.travelAgencies.rawValue{
        userName.text = modelData.sharedPostData?.subjectId?.companyName?.capitalized
    }
    
    
    lblPostDesc.text = modelData.sharedPostData?.body
    lblSharePostDesc.text = modelData.body
    lblPostLikeCount.text = "\(modelData.likeCount ?? 0)"
    lblPostCommentCount.text = "\(modelData.commentCount ?? 0)"
    lblPostTime.text = modelData.posted_at
 
    self.userImage.layer.borderWidth = 0.5
    self.userImage.layer.borderColor = UIColor.lightGray.cgColor
   
    if String.getString(modelData.subjectId?.avatarId?.attachmentUrl) == ""{
        self.imgSharedUserImage.image = UIImage(named: "profile_icon")
    }
    if String.getString(modelData.sharedPostData?.subjectId?.avatarId?.attachmentUrl) == ""{
        self.userImage.image = UIImage(named: "profile_icon")
    }
    if String.getString(modelData.subjectId?.avatarId?.attachmentUrl) != ""{
        self.imgSharedUserImage.setImage(withString: String.getString(modelData.subjectId?.avatarId?.baseUrl ?? "") + String.getString(modelData.subjectId?.avatarId?.attachmentUrl))
    }
    if String.getString(modelData.sharedPostData?.subjectId?.avatarId?.attachmentUrl) != ""{
        
        self.userImage.setImage(withString: String.getString(modelData.subjectId?.avatarId?.baseUrl ?? "") + String.getString(modelData.sharedPostData?.subjectId?.avatarId?.attachmentUrl))
    //self.userImage.setImage(withString: kImageBaseUrl + String.getString(modelData.subjectId?.avatarId?.attachmentUrl))
    }
    likeImage.image = modelData.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
    
    likeCallback = { index in
        //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
        self.lblPostLikeCount.text = "\(modelData.likeCount ?? 0)"
        self.likeImage.image = modelData.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
        
    }

    self.imagePostCollectionView.isPagingEnabled = true

    self.imagePostCollectionView.showsHorizontalScrollIndicator = false

    self.imageArray.removeAll()

    if (modelData.sharedPostData?.attachments?.isEmpty == true) || (modelData.sharedPostData?.attachmentCount == 0){
             print("No Data")
            }else{

                for i in  0..<(modelData.sharedPostData?.attachments?.count ?? 0) {
                    let url = ((modelData.sharedPostData?.attachments?[i].attachmentLink?.baseUrl ?? "") + (modelData.sharedPostData?.attachments?[i].attachmentLink?.attachmentUrl ?? ""))
                    self.imageArray.append(url)
                }
            }
   

    if imageArray.count <= 0 || imageArray.count == 1{
        self.pageControl.alpha = 0
        self.vwpageControl.alpha = 0
    } else {
        self.pageControl.alpha = 1
        self.pageControl.numberOfPages = imageArray.count
        self.vwpageControl.alpha = 1
        self.pages = imageArray.count
        self.vwpageControl.pages = pages
        
        (0..<(pages )).map { $0 % 2 == 0 ? UIColor.clear : UIColor.clear }.forEach { color in
            let item = UIView()
            item.translatesAutoresizingMaskIntoConstraints = false
            item.backgroundColor = color
            stackView.addArrangedSubview(item)
            item.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        }
    }

    self.imagePostCollectionView.reloadData()
}
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
       // self.menuDelegate.menuBttonTapped(4, userID: 5)
        self.menuDelegate.menuBttonTapped(postID: self.data?.postID, userID: self.data?.subjectId?.userId ?? 0)
        
    }
    
    @objc func likeAction(_ tap: UITapGestureRecognizer){
        if self.data?.likeFlag == 0 {
            islike = 1
        }else{
            islike = 0
        }

        callLikeUnlikeApi(self.islike, self.data?.activityActionId, self.index)
        

    }
    
    @objc func showShareScreen(_ tap: UITapGestureRecognizer) {
        self.shareCallback?()
    }
    
    @objc func profileScreen(_ tap: UITapGestureRecognizer) {
        self.profileCallback?()
    }
    
    @objc func profileShareScreen(_ tap: UITapGestureRecognizer) {
        self.sharedProfileCallback?()
    }

    @objc func showCommentsScreen() {
        let model = PostCommentsUserData(userID: self.data?.subjectId?.userId ?? -1,
                                         postID: self.data?.postID ?? 0)
        self.commentCallback?(model)
    }
    
}

extension SharePostDescTableViewCell {
    
    func callLikeUnlikeApi(_ isLike: Int?, _ postId: Int? ,_ indexPath: Int?){
        let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0

        let params: [String:Any] = [
            "post_id": postId ?? 0,
            "like_or_unlike": isLike ?? 0,
            "user_id": selfID

        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLikeApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            self.data?.likeFlag = isLike
            if isLike == 0{
            self.data?.likeCount = ((self.data?.likeCount ?? 1) - 1)
            }else{
                self.data?.likeCount = ((self.data?.likeCount ?? 1) + 1)
            }
             self.likeCallback?(indexPath ?? 0)
            
        }
    }
}

extension SharePostDescTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imagePostCollectionView.dequeueReusableCell(withReuseIdentifier: "PostImageCollectionViewCell", for: indexPath) as? PostImageCollectionViewCell else{
            return UICollectionViewCell()
        }
      
     

      
//        for i in 0..<imageArray.count {
//            cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(imageArray[i]))
//            cell.imagePost.backgroundColor = .yellow
//        }
        cell.imagePost.setImage(withString: String.getString(imageArray[indexPath.row]))
       // cell.imagePost.contentMode = .scaleAspectFill
        //cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(data?.attachments?.attachmentLink?.attachmentUrl))
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.pageControl.currentPage = indexPath.row
//    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        vwpageControl.selectedPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: self.imagePostCollectionView.frame.width - 20, height: 220)
       // return CGSize(width: (self.imagePostCollectionView.frame.width), height: 220);
        
        let data = self.data?.sharedPostData?.attachments?[indexPath.row]
        
        
        /*if data?.attachmentLink?.height == data?.attachmentLink?.width {
            //let floatHeight = CGFloat(data?.attachmentLink?.height ?? 0)
            //return CGSize(width: (self.imagePostCollectionView.frame.width), height: 350);
            return CGSize(width: (self.imagePostCollectionView.frame.width), height: 350);
        } else if Int.getInt(data?.attachmentLink?.width) > Int.getInt(data?.attachmentLink?.height) {
           // let floatHeight = CGFloat(data?.attachmentLink?.width ?? 0)
            return CGSize(width: (self.imagePostCollectionView.frame.width), height: 200)
        } else {
            //let floatHeight = CGFloat(data?.attachmentLink?.width ?? 0)
            return CGSize(width: (self.imagePostCollectionView.frame.width), height: CGFloat(data?.attachmentLink?.height ?? 0
                                                                                                * 72 / 96)-250)
        }*/
        
        
        if data?.attachmentLink?.height == data?.attachmentLink?.width {
            //let floatHeight = CGFloat(data?.attachmentLink?.height ?? 0)
            //return CGSize(width: (self.imagePostCollectionView.frame.width), height: 350);
            return CGSize(width: (self.imagePostCollectionView.frame.width), height: 350);
        } else if Int.getInt(data?.attachmentLink?.width) > Int.getInt(data?.attachmentLink?.height) {
           // let floatHeight = CGFloat(data?.attachmentLink?.width ?? 0)
            
            if Int.getInt(data?.attachmentLink?.width) > 500 {
                return CGSize(width: (self.imagePostCollectionView.frame.width), height: 500)
            } else if Int.getInt(data?.attachmentLink?.width) > 300 {
                return CGSize(width: (self.imagePostCollectionView.frame.width), height: 400)
            } else {
                return CGSize(width: (self.imagePostCollectionView.frame.width), height: 300)
            }
            
            
        } else if Int.getInt(data?.attachmentLink?.height) > Int.getInt(data?.attachmentLink?.width) {
            // let floatHeight = CGFloat(data?.attachmentLink?.width ?? 0)
            
            if  Int.getInt(data?.attachmentLink?.height) < 350 {
                return CGSize(width: (self.imagePostCollectionView.frame.width), height: 350)
            } else {
                
                
                return CGSize(width: (self.imagePostCollectionView.frame.width), height: 500)
            }
            
             
         } else {
            //let floatHeight = CGFloat(data?.attachmentLink?.width ?? 0)
            return CGSize(width: (self.imagePostCollectionView.frame.width), height: CGFloat(data?.attachmentLink?.height ?? 0 * 72 / 96)-150)
        }
        
        
        
    }
//
//     func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        imagePostCollectionView?.collectionViewLayout.invalidateLayout();
//   }
}
