//
//  PostDescTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/26/21.
//

import UIKit
import ScrollingPageControl
//import SocketIO
import Zoomy

//struct PostLikeUnlikeRequestModel: Codable, SocketData {
    struct PostLikeUnlikeRequestModel: Codable {

    let postOwnerID: Int
    let userID: Int?
    let postID: Int?
    let likeStatus: Int

    private enum CodingKeys: String, CodingKey {
        case postOwnerID = "post_owner_id"
        case userID = "user_id"
        case postID = "post_id"
        case likeStatus = "like_status"
    }
}

    //let manager = SocketManager(socketURL: URL(string: "https://alyseisocket.ibyteworkshop.com")!, config: [.log(true), .compress])


protocol ShareEditMenuProtocol {
    func menuBttonTapped(postID: Int?, userID: Int?)
}

class PostDescTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var lblPostDesc: UILabel!
    @IBOutlet weak var lblPostLikeCount: UILabel!
    @IBOutlet weak var lblPostCommentCount: UILabel!
    @IBOutlet weak var imageHeightCVConstant: NSLayoutConstraint!
    @IBOutlet weak var imagePostCollectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentImage: UIView!
    @IBOutlet weak var lblPostTime: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var follower: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnMoreLess: UIButton!
    @IBOutlet var vwpageControl: ScrollingPageControl!
   // @IBOutlet weak var collectionVieweHight: NSLayoutConstraint!
    
    var passImageTabCallBack: ((UIImageView) -> Void)? = nil
    var data: NewFeedSearchDataModel?
    var data1 : SinglePostDataModel?
    var likeCallback:((Int) -> Void)? = nil
    var shareCallback:(()->())?
    var commentCallback:((PostCommentsUserData) -> Void)? = nil
    var islike: Int?
    var index: Int?
    var imageArray = [String]()
    var imageheight = [Int]()
    var imagewidth = [Int]()
    var menuDelegate: ShareEditMenuProtocol!
    var isExpand = false
    var previousIndex: Int?
    var currentIndex: Int?
    var reloadCallBack: ((Int?,Int?) -> Void)? = nil
    var relaodSection : Int?
   
    var btnLikeCallback:((Int) -> Void)? = nil
    var profileCallback:(() -> ())?
    var pages = 0
    let stackView = UIStackView()
    var newHeightCllctn: Int?
    var imageZoomPost: UIImageView!
    
    var postLike:[PostClass]?
    
    
//    let manager = SocketManager(socketURL: URL(string: "https://alyseisocket.ibyteworkshop.com")!, config: [.log(true), .compress])
//    let socket = SocketManager(socketURL: URL(string: "https://alyseisocket.ibyteworkshop.com")!, config: [.log(true), .compress]).defaultSocket


   // let socket = manager.defaultSocket

    override func awakeFromNib() {
        super.awakeFromNib()
       
        pageControlUI()
        imagePostCollectionView.delegate = self
        imagePostCollectionView.dataSource = self
        imagePostCollectionView.isHidden = false
        
        btnMoreLess.isHidden = true
       // lblPostDesc.numberOfLines = 2
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.masksToBounds = true
        self.vwpageControl.selectedPage = pages
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        tap.numberOfTouchesRequired = 1
        self.viewLike.addGestureRecognizer(tap)


        let tap2 = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        tap2.numberOfTapsRequired = 2
        self.imagePostCollectionView.addGestureRecognizer(tap2)

        let showSharesGesture = UITapGestureRecognizer(target: self, action: #selector(self.showShareScreen))
        showSharesGesture.numberOfTouchesRequired = 1
        self.viewShare.addGestureRecognizer(showSharesGesture)
        
        let showCommentsGesture = UITapGestureRecognizer(target: self, action: #selector(self.showCommentsScreen))
        showCommentsGesture.numberOfTouchesRequired = 1
        self.commentImage.addGestureRecognizer(showCommentsGesture)
        
        let userimg = UITapGestureRecognizer(target: self, action: #selector(self.profileScreen(_:)))
        userimg.numberOfTouchesRequired = 1
        self.userImage.isUserInteractionEnabled = true
        self.userImage.addGestureRecognizer(userimg)


        self.menuButton?.imageView?.contentMode = .scaleAspectFit
//        self.menuButton.backgroundColor = .green

        
        // Initialization code
    }
    func pageControlUI(){
        _ = IndexPath(item: 0, section: 0)
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
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func menuButtonTapped(_ sender: UIButton) {

        if fromMenuTab == "PhotosPost"{
            
            self.menuDelegate.menuBttonTapped(postID: self.data?.postID, userID: Int(kSharedUserDefaults.loggedInUserModal.userId ?? ""))
        }
//        if fromMenuTab == "UserPostsViewController"{
//
//            self.menuDelegate.menuBttonTapped(postID: Int(postId), userID: Int(kSharedUserDefaults.loggedInUserModal.userId ?? ""))
//        }
        else{
            self.menuDelegate.menuBttonTapped(postID: self.data?.postID, userID: self.data?.subjectId?.userId ?? 0)
        }
        
    }
    
    @IBAction func btnMoreLessAction(_ sender: UIButton){
        reloadCallBack?(sender.tag, relaodSection)
    }
    
    @IBAction func btnLikeAction(_ sender: UIButton){
        btnLikeCallback?(sender.tag)
    }
    
    @objc func showShareScreen(_ tap: UITapGestureRecognizer) {
        self.shareCallback?()
    }
    
    @objc func profileScreen(_ tap: UITapGestureRecognizer) {
        self.profileCallback?()
    }
    
    
    func configCell(_ modelData: NewFeedSearchDataModel,postlike: [PostClass], _ index: Int) {
        
        _ = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0
        postLike = postlike
     
        self.viewLike.tag = index
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        self.viewLike.addGestureRecognizer(tap)

        self.data = modelData
    
        self.index = self.data?.postID ?? 0
       
        if modelData.subjectId?.roleId == UserRoles.producer.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Producer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.restaurant.rawValue{
            userName.text = modelData.subjectId?.restaurantName?.capitalized
            userNickName.text = "Restaurant,"//modelData.subjectId?.email?.lowercased()
        }else if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = "Voyager"//modelData.subjectId?.email?.lowercased()
            follower.isHidden = true
        }else if modelData.subjectId?.roleId == UserRoles.voiceExperts.rawValue{
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = "Voice Of Experts,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer1.rawValue {
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Importer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer2.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Distributer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer3.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Importer & Distributer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.travelAgencies.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Travel Agencies,"//modelData.subjectId?.email?.lowercased()
        }
        /*else{
  
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }*/
        
        if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            
            follower.isHidden = true
        } else {
            follower.isHidden = false
            follower.text = "\(modelData.follower_count ?? 0) Followers"
        }
        
        lblPostDesc.text = modelData.body
        
        for i in  0..<(postLike?.count ?? 0) {
            
            if self.postLike?[i].postId == self.data?.postID ?? 0 {
                lblPostLikeCount.text = "\(self.postLike?[i].likeCount ?? 0)"
            }
            
        }
        
        //lblPostLikeCount.text = "\(modelData.likeCount ?? 0)"
        lblPostCommentCount.text = "\(modelData.commentCount ?? 0)"
        lblPostTime.text = modelData.posted_at
        //islike = data.likeFlag
        if modelData.attachmentCount == 0 {
            imagePostCollectionView.isHidden = true
           
            
            //imageHeightCVConstant.constant = 0
//            imagePostCollectionView.alpha = 0.0
        }else{
            imagePostCollectionView.isHidden = false
        }

        self.userImage.layer.borderWidth = 0.5
        self.userImage.layer.borderColor = UIColor.lightGray.cgColor
        
       // let baseUrl =
      //  print("ImageUrl--------------------------------\(String.getString(modelData.subjectId?.avatarId?.attachmentUrl) )")
        if String.getString(modelData.subjectId?.avatarId?.attachmentUrl) == ""{
            self.userImage.image = UIImage(named: "profile_icon")
        }else{
        self.userImage.setImage(withString: (String.getString(modelData.subjectId?.avatarId?.baseUrl)) + String.getString(modelData.subjectId?.avatarId?.attachmentUrl))
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
        self.imagewidth.removeAll()
        self.imageheight.removeAll()
        if (modelData.attachments?.isEmpty == true) || (modelData.attachments?.count == 0){
            print("No Data")
        }else{
            for i in  0..<(modelData.attachments?.count ?? 0) {
                let baseUrl = modelData.attachments?[i].attachmentLink?.baseUrl ?? ""
                self.imageArray.append(baseUrl + "\(modelData.attachments?[i].attachmentLink?.attachmentUrl ?? "")")
                self.imagewidth.append(modelData.attachments?[i].attachmentLink?.width ?? 0)
                self.imageheight.append(modelData.attachments?[i].attachmentLink?.height ?? 0)
            }
            
            print("LoadImageArray------------------------------\(imageArray)")
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
        let  wordContains = modelData.body?.count ?? 0
        //let lblSize = lblPostDesc.numberOfLines
        //print("lableSize?>>>>>>>>>>>>>>>>>>>>>>>>>>>>",lblSize)
        if wordContains <= 60 {
//            btnMoreLess.isHidden = true
        }else{
           // btnMoreLess.isHidden = false
        }
       
        self.imagePostCollectionView.reloadData()
    }
    
    func configCell(_ modelData: NewFeedSearchDataModel, _ index: Int) {
        
        _ = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0
      
     
        self.viewLike.tag = index
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        self.viewLike.addGestureRecognizer(tap)

        self.data = modelData
    
        self.index = self.data?.postID ?? 0
       
        if modelData.subjectId?.roleId == UserRoles.producer.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Producer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.restaurant.rawValue{
            userName.text = modelData.subjectId?.restaurantName?.capitalized
            userNickName.text = "Restaurant,"//modelData.subjectId?.email?.lowercased()
        }else if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = "Voyager"//modelData.subjectId?.email?.lowercased()
            follower.isHidden = true
        }else if modelData.subjectId?.roleId == UserRoles.voiceExperts.rawValue{
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = "Voice Of Experts,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer1.rawValue {
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Importer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer2.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Distributer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer3.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Importer & Distributer,"//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.travelAgencies.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = "Travel Agencies,"//modelData.subjectId?.email?.lowercased()
        }
        /*else{
  
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }*/
        
        if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            
            follower.isHidden = true
        } else {
            follower.isHidden = false
            follower.text = "\(modelData.follower_count ?? 0) Followers"
        }
        
        lblPostDesc.text = modelData.body
        
       
        
        lblPostLikeCount.text = "\(modelData.likeCount ?? 0)"
        lblPostCommentCount.text = "\(modelData.commentCount ?? 0)"
        lblPostTime.text = modelData.posted_at
        //islike = data.likeFlag
        if modelData.attachmentCount == 0 {
            imagePostCollectionView.isHidden = true
            
           // imageHeightCVConstant.constant = 0
//            imagePostCollectionView.alpha = 0.0
        }else{
            imagePostCollectionView.isHidden = false
        }

        self.userImage.layer.borderWidth = 0.5
        self.userImage.layer.borderColor = UIColor.lightGray.cgColor
        
       // let baseUrl =
      //  print("ImageUrl--------------------------------\(String.getString(modelData.subjectId?.avatarId?.attachmentUrl) )")
        if String.getString(modelData.subjectId?.avatarId?.attachmentUrl) == ""{
            self.userImage.image = UIImage(named: "profile_icon")
        }else{
        self.userImage.setImage(withString: (String.getString(modelData.subjectId?.avatarId?.baseUrl)) + String.getString(modelData.subjectId?.avatarId?.attachmentUrl))
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
        self.imagewidth.removeAll()
        self.imageheight.removeAll()
        if (modelData.attachments?.isEmpty == true) || (modelData.attachments?.count == 0){
            print("No Data")
        }else{
            for i in  0..<(modelData.attachments?.count ?? 0) {
                let baseUrl = modelData.attachments?[i].attachmentLink?.baseUrl ?? ""
                self.imageArray.append(baseUrl + "\(modelData.attachments?[i].attachmentLink?.attachmentUrl ?? "")")
                self.imagewidth.append(modelData.attachments?[i].attachmentLink?.width ?? 0)
                self.imageheight.append(modelData.attachments?[i].attachmentLink?.height ?? 0)
                
            }
            
            print("LoadImageArray------------------------------\(imageArray)")
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
        let  wordContains = modelData.body?.count ?? 0
        //let lblSize = lblPostDesc.numberOfLines
        //print("lableSize?>>>>>>>>>>>>>>>>>>>>>>>>>>>>",lblSize)
        if wordContains <= 60 {
//            btnMoreLess.isHidden = true
        }else{
           // btnMoreLess.isHidden = false
        }
       
        self.imagePostCollectionView.reloadData()
    }
    
   

    @objc func likeAction(_ tap: UITapGestureRecognizer){
        if self.data?.likeFlag == 0 {
            islike = 1
        }else{
            islike = 0
        }

        //if (islike ?? 0) == 0 {
            callLikeUnlikeApi(self.islike, self.data?.activityActionId, self.index)
          //  return
       // }

    

    }

    @objc func showCommentsScreen() {
        let model = PostCommentsUserData(userID: self.data?.subjectId?.userId ?? -1,
                                         postID: self.data?.postID ?? 0)
        self.commentCallback?(model)
    }


}
extension PostDescTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imagePostCollectionView.dequeueReusableCell(withReuseIdentifier: "PostImageCollectionViewCell", for: indexPath) as? PostImageCollectionViewCell else{
            return UICollectionViewCell()}
      //  addZoombehavior(for: cell.imagePost)
       
        print("checkUrlImageurl--------------------------------\(String.getString(imageArray[indexPath.row]))")
        cell.imagePost.setImage(withString: String.getString(imageArray[indexPath.row]))
        cell.passImageCallBack = { imageZoomPost in
            self.imageZoomPost = imageZoomPost
            self.passImageTabCallBack?(self.imageZoomPost)
        }
        
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
        return CGSize(width: self.imagePostCollectionView.frame.width, height: CGFloat(newHeightCllctn ?? 0))



    }
//
//     func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        imagePostCollectionView?.collectionViewLayout.invalidateLayout();
//   }
}

extension PostDescTableViewCell {
    
    func callLikeUnlikeApi(_ isLike: Int?, _ postId: Int? ,_ indexPath: Int?){
        let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0

        let params: [String:Any] = [
            "post_id": postId ?? 0,
            "like_or_unlike": isLike ?? 0,
            "user_id": selfID

        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLikeApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            if statusCode == 200 {
                
                let response = dictResponse as? [String:Any]
                let total_like = response?["total_likes"] as? Int
                //let like_id = response?["like_id"] as? Int
                
                self.data?.likeCount = total_like
                kChatharedInstance.update_post(likecount: total_like ?? 0, postId: postId ?? 0)
            }
            
            self.data?.likeFlag = isLike
            
             self.likeCallback?(indexPath ?? 0)
            //self.receivePostLike()
            //print("likeid  ",self.postLike![359].likeCount)
        }
    }
   
        func viewForDot(at index: Int) -> UIView? {
            guard index == 0 else { return nil }
            let view = TriangleView()
            view.isOpaque = false
            return view
        }
    
}
import Zoomy

class PostImageCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate{
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var imageConstant: NSLayoutConstraint!

    var originalFrame = CGRect()
   
    var overlay: UIView = {
        let view = UIView(frame: UIScreen.main.bounds);

        view.alpha = 0
        view.backgroundColor = .black

        return view
    }()

    var isZooming = false
    var originalImageCenter:CGPoint?

    var fullScreenImage: UIImageView!
    var passImageCallBack: ((UIImageView) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.originalImageCenter = imagePost.center
        self.originalFrame = imagePost.frame

        self.imagePost.isUserInteractionEnabled = true

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
//        pinch.minimumNumberOfTouches = 2
//        pinch.maximumNumberOfTouches = 2
       self.imagePost.addGestureRecognizer(pinch)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan(sender:)))
       // pan.minimumNumberOfTouches = 2
      //  pan.maximumNumberOfTouches = 2
       // pan.delegate = self
        // self.imagePost.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(sender:)))
       // self.imagePost.addGestureRecognizer(tap)
    }
    @objc func pinch(sender:UIPinchGestureRecognizer) {
        passImageCallBack?(imagePost)
    }
    @objc func pan(sender:UIPanGestureRecognizer) {
        passImageCallBack?(imagePost)
    }
    @objc func tap(sender: UITapGestureRecognizer) {
        passImageCallBack?(imagePost)
    }
//    @objc func pinch(sender:UIPinchGestureRecognizer) {
//        //self.imagePost.image = nil
//        var touchBaseView = sender.view
//        if let tab = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
//            if let navCon = tab.viewControllers?.first as? UINavigationController {
//                if let viewCon = navCon.viewControllers.first as? HomeViewC {
//                    touchBaseView = viewCon.view
//                }
//            }
//        }
////        let touch1 = sender.location(ofTouch: 0, in: touchBaseView)
//
//        let touch1 = sender.location(ofTouch: 0, in: touchBaseView)
//        var midPointX = touch1.x
//        var midPointY = touch1.y
//        if sender.numberOfTouches > 1 {
//            let touch2 = sender.location(ofTouch: 1, in: touchBaseView)
//            midPointX = (touch1.x + touch2.x)/2
//            midPointY = (touch1.y + touch2.y)/2
//        }
//
//        let touchedPoint = CGPoint(x: midPointX, y: midPointY)
////        let touch2 = sender.location(ofTouch: 1, in: sender.view)
//
//        if sender.state == .began {
//            self.imagePost.frame = UIScreen.main.bounds
//            let currentScale = self.imagePost.frame.size.width / self.imagePost.bounds.size.width
//            let newScale = currentScale*sender.scale
//            if newScale > 1 {
//                self.isZooming = true
//                self.imagePost.isHidden = true
//            }
//            self.showAlertOnTab(1.0, frame: self.imagePost.frame, center: touchedPoint)
//
//
//        } else if sender.state == .changed {
//            guard let view = sender.view else {return}
//            self.imagePost.isHidden = true
//            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
//                                      y: sender.location(in: view).y - view.bounds.midY)
//            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
//                .scaledBy(x: sender.scale, y: sender.scale)
//                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
//            let currentScale = self.imagePost.frame.size.width / self.imagePost.bounds.size.width
//            var newScale = currentScale*sender.scale
//            if newScale < 1 {
//                newScale = 1
//                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
//                self.imagePost.transform = transform
//                sender.scale = 1
//            }else {
//                view.transform = transform
//                sender.scale = 1
//            }
//            self.showAlertOnTab(1.0, frame: self.imagePost.frame, center: touchedPoint)
//        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
//            self.showAlertOnTab(0.0, frame: self.imagePost.frame, center: CGPoint())
//
//
//            guard let center = self.originalImageCenter else {return}
//
//           // self.imagePost.frame = self.bounds
//
//            UIView.animate(withDuration: 0.3, animations: {
//                self.imagePost.transform = CGAffineTransform.identity
//                //self.imagePost.center = center
//                sender.scale = 1
//            }, completion: { _ in
//                self.isZooming = false
//                self.imagePost.isHidden = false
//
//            })
//        }
//    }

//    @objc func pan(sender: UIPanGestureRecognizer) {
//        if self.isZooming && sender.state == .began {
//            self.originalImageCenter = sender.view?.center
//        } else if self.isZooming && sender.state == .changed {
//            let translation = sender.translation(in: self)
//            if let view = sender.view {
//                view.center = CGPoint(x:view.center.x + translation.x,
//                                      y:view.center.y + translation.y)
//            }
//            sender.setTranslation(CGPoint.zero, in: self.imagePost.superview)
//        }
//    }

    func  showAlertOnTab(_ alpha: CGFloat, frame: CGRect, center: CGPoint) {
        if let tab = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
            if let navCon = tab.viewControllers?.first as? UINavigationController {
                if let viewCon = navCon.viewControllers.first as? HomeViewC {
                    viewCon.fullScreenImageView.frame = frame
                    viewCon.fullScreenImageView.center = center
                    viewCon.fullScreenImageView.alpha = alpha
                    viewCon.fullScreenImageView.contentMode = .scaleAspectFill
                    viewCon.fullScreenImageView.image = self.imagePost.image
                   // print(viewCon.description)
                }
            }
        }
    }
}



