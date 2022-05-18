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
    
    //var passImageTabCallBack: ((UIImageView) -> Void)? = nil
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
        self.imageArray.removeAll()
        self.data = NewFeedSearchDataModel(with: [:])
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
            userNickName.text = AppConstants.kProducer + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.restaurant.rawValue{
            userName.text = modelData.subjectId?.restaurantName?.capitalized
            userNickName.text = AppConstants.kRestaurant + ","//modelData.subjectId?.email?.lowercased()
        }else if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = AppConstants.kVoyager //modelData.subjectId?.email?.lowercased()
            follower.isHidden = true
        }else if modelData.subjectId?.roleId == UserRoles.voiceExperts.rawValue{
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = AppConstants.kVoiceOfExperts + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer1.rawValue {
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kImporter + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer2.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kDistributer + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer3.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kImporterDistributer + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.travelAgencies.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kTravelAgencies + ","//modelData.subjectId?.email?.lowercased()
        }
        /*else{
  
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }*/
        
        if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            
            follower.isHidden = true
        } else {
            follower.isHidden = false
            follower.text = "\(modelData.follower_count ?? 0)" + " " +  AppConstants.Followers
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
            userNickName.text = AppConstants.kProducer + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.restaurant.rawValue{
            userName.text = modelData.subjectId?.restaurantName?.capitalized
            userNickName.text = AppConstants.kRestaurant + ","//modelData.subjectId?.email?.lowercased()
        }else if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = AppConstants.kVoyager //modelData.subjectId?.email?.lowercased()
            follower.isHidden = true
        }else if modelData.subjectId?.roleId == UserRoles.voiceExperts.rawValue{
            userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "") \(modelData.subjectId?.lastName?.capitalized ?? "")"
            userNickName.text = AppConstants.kVoiceOfExperts + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer1.rawValue {
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kImporter + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer2.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kDistributer + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.distributer3.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kImporterDistributer + ","//modelData.subjectId?.email?.lowercased()
        }else if modelData.subjectId?.roleId == UserRoles.travelAgencies.rawValue{
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = AppConstants.kTravelAgencies + ","//modelData.subjectId?.email?.lowercased()
        }
        /*else{
  
            userName.text = modelData.subjectId?.companyName?.capitalized
            userNickName.text = modelData.subjectId?.email?.lowercased()
        }*/
        
        if(modelData.subjectId?.roleId == UserRoles.voyagers.rawValue){
            
            follower.isHidden = true
        } else {
            follower.isHidden = false
            follower.text = "\(modelData.follower_count ?? 0)" + AppConstants.Followers
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
        cell.imagePost.image = UIImage(named: "image_placeholder")
        cell.tag = indexPath.row
        cell.delegate = self
      //  addZoombehavior(for: cell.imagePost)
       
        print("checkUrlImageurl--------------------------------\(String.getString(imageArray[indexPath.row]))")
       // cell.imagePost.setImage(withString: String.getString(imageArray[indexPath.row]))
//        cell.passImageCallBack = { imageZoomPost in
//            self.imageZoomPost = imageZoomPost
//            //self.passImageTabCallBack?(self.imageZoomPost)
      //  if let imgUrl = URL(string:imageArray[indexPath.row]){
      
        let imgUrl = imageArray[indexPath.row]
        let imgUrl1 = URL(string: imageArray[indexPath.row])
        if imgUrl != ""{
           // cell.imagePost.loadCacheImage(urlString: imgUrl)
            cell.imagePost.loadImageWithUrl(imgUrl1!)
        }else{
          print("No Photos")
        }
        
        
        
//        }
        
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
extension PostDescTableViewCell: SubclassedCellDelegate {
    func zooming(started: Bool) {
        self.imagePostCollectionView.isScrollEnabled = !started
    }
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
protocol SubclassedCellDelegate: AnyObject {
    func zooming(started: Bool)
}
class PostImageCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate{
    @IBOutlet weak var imagePost: ImageLoader!
    @IBOutlet weak var imageConstant: NSLayoutConstraint!
  
    var originalFrame = CGRect()
   
//    var overlay: UIView = {
//        let view = UIView(frame: UIScreen.main.bounds);
//
//        view.alpha = 0
//        view.backgroundColor = .black
//
//        return view
//    }()

    var isZooming = false
    var originalImageCenter:CGPoint?

    var fullScreenImage: UIImageView!
   // var passImageCallBack: ((UIImageView) -> Void)? = nil
    

    // the view that will be overlayed, giving a back transparent look
    var overlayView: UIView!
    
    // a property representing the maximum alpha value of the background
    let maxOverlayAlpha: CGFloat = 1.0
    // a property representing the minimum alpha value of the background
    let minOverlayAlpha: CGFloat = 0.4
    
    // the initial center of the pinch
    var initialCenter: CGPoint?
    // the view to be added to the Window
    var windowImageView: UIImageView?
    // the origin of the source imageview (in the Window coordinate space)
    var startingRect = CGRect.zero
    var pinchtouches: Int?
    var countTouch:Int? // = []
    var pinch : UIPinchGestureRecognizer?
    weak var delegate: SubclassedCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.originalImageCenter = imagePost.center
        self.originalFrame = imagePost.frame

        self.imagePost.isUserInteractionEnabled = true
        
       // if loadTypeCell == .sharePost{
        pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        self.imagePost.addGestureRecognizer(pinch ?? UIPinchGestureRecognizer())

            // let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan(sender:)))
            // pan.minimumNumberOfTouches = 2
             //pan.maximumNumberOfTouches = 2
            // pan.delegate = self
            //  self.imagePost.addGestureRecognizer(pan)
             
          //   let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(sender:)))
          //   self.imagePost.addGestureRecognizer(tap)
            
       // }


        
      
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //hide or reset anything you want hereafter, for example
        imagePost.image = UIImage(named: "image_placeholder")
        
    }
//    @objc func pinch(sender:UIPinchGestureRecognizer) {
//       // passImageCallBack?(imagePost)
//        self.imagePost.transform = self.imagePost.transform.scaledBy(x: sender.scale, y: sender.scale)
//                sender.scale = 1
//    }
//    @objc func pan(sender:UIPanGestureRecognizer) {
//       /// passImageCallBack?(imagePost)
//    }
//    @objc func tap(sender: UITapGestureRecognizer) {
//       // passImageCallBack?(imagePost)
//    }
   

    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        if sender.numberOfTouches != 2{
            guard let windowImageView = self.windowImageView else { return }
            
            // animate the change when the pinch has finished
            UIView.animate(withDuration: 0.5, animations: {
                // make the transformation go back to the original
                windowImageView.transform = CGAffineTransform.identity
            }, completion: { _ in
                
                // remove the imageview from the superview
                windowImageView.removeFromSuperview()
                
                // remove the overlayview
                self.overlayView.removeFromSuperview()
                
                // make the original view reappear
                self.imagePost.isHidden = false
                
                // tell the collectionview that we have stopped
                self.delegate?.zooming(started: false)
            })
        }
        if sender.numberOfTouches == 2{
        if sender.state == .began {
            // the current scale is the aspect ratio
            let currentScale = self.imagePost.frame.size.width / self.imagePost.bounds.size.width
            // the new scale of the current `UIPinchGestureRecognizer`
            let newScale = currentScale * sender.scale
            
            // if we are really zooming
            if newScale > 1 {
                // if we don't have a current window, do nothing
                guard let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
                
                // inform listeners that we are zooming, to stop them scrolling the UICollectionView
                self.delegate?.zooming(started: true)
                
                // setup the overlay to be the same size as the window
                overlayView = UIView.init(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: (currentWindow.frame.size.width),
                        height: (currentWindow.frame.size.height)
                    )
                )
                
                // set the view of the overlay as black
                overlayView.backgroundColor = UIColor.black
                
                // set the minimum alpha for the overlay
                overlayView.alpha = CGFloat(minOverlayAlpha)
                
                // add the subview to the overlay
                currentWindow.addSubview(overlayView)
                
                // set the center of the pinch, so we can calculate the later transformation
                initialCenter = sender.location(in: currentWindow)
                
                // set the window Image view to be a new UIImageView instance
                windowImageView = UIImageView.init(image: self.imagePost.image)
                
                // set the contentMode to be the same as the original ImageView
                windowImageView!.contentMode = .scaleAspectFill
                
                // Do not let it flow over the image bounds
                windowImageView!.clipsToBounds = true
                
                // since the to view is nil, this converts to the base window coordinates.
                // so where is the origin of the imageview, in the main window
                let point = self.imagePost.convert(
                    imagePost.frame.origin,
                    to: nil
                )
                
                // the location of the imageview, with the origin in the Window's coordinate space
                startingRect = CGRect(
                    x: point.x,
                    y: point.y,
                    width: imagePost.frame.size.width,
                    height: imagePost.frame.size.height
                )
                
                // set the frame for the image to be added to the window
                windowImageView?.frame = startingRect
              //  let lastTouchPoint = sender.location(in: imagePost)
               
              //  windowImageView?.center = lastTouchPoint
                
                // add the image to the Window, so it will be in front of the navigation controller
                currentWindow.addSubview(windowImageView!)
                
                // hide the original image
                imagePost.isHidden = true
            }
            
        } else if sender.state == .changed {
            // if we don't have a current window, do nothing. Ensure the initialCenter has been set
            guard let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                  let initialCenter = initialCenter,
                  let windowImageWidth = windowImageView?.frame.size.width
            else { return }
            
            // Calculate new image scale.
            let currentScale = windowImageWidth / startingRect.size.width
            
            // the new scale of the current `UIPinchGestureRecognizer`
            let newScale = currentScale * sender.scale
            
            // Calculate new overlay alpha, so there is a nice animated transition effect
          //  overlayView.alpha = minOverlayAlpha + (newScale - 1) < maxOverlayAlpha ? minOverlayAlpha + (newScale - 1) : maxOverlayAlpha

            // calculate the center of the pinch
            let pinchCenter = CGPoint(
                x: sender.location(in: currentWindow).x - (currentWindow.bounds.midX),
                y: sender.location(in: currentWindow).y - (currentWindow.bounds.midY)
            )
            
            // calculate the difference between the inital centerX and new centerX
            let centerXDif = initialCenter.x - sender.location(in: currentWindow).x
            // calculate the difference between the intial centerY and the new centerY
            let centerYDif = initialCenter.y - sender.location(in: currentWindow).y
            
            // calculate the zoomscale
            let zoomScale = (newScale * windowImageWidth >= imagePost.frame.width) ? newScale : currentScale

            // transform scaled by the zoom scale
            let transform = currentWindow.transform
                .translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: zoomScale, y: zoomScale)
                .translatedBy(x: -centerXDif, y: -centerYDif)

            // apply the transformation
            windowImageView?.transform = transform
            
            // Reset the scale
            sender.scale = 1
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            guard let windowImageView = self.windowImageView else { return }
            
            // animate the change when the pinch has finished
            UIView.animate(withDuration: 0.5, animations: {
                // make the transformation go back to the original
                windowImageView.transform = CGAffineTransform.identity
            }, completion: { _ in
                
                // remove the imageview from the superview
                windowImageView.removeFromSuperview()
                
                // remove the overlayview
                self.overlayView.removeFromSuperview()
                
                // make the original view reappear
                self.imagePost.isHidden = false
                
                // tell the collectionview that we have stopped
                self.delegate?.zooming(started: false)
            })
        }
        }
    }

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

//    func  showAlertOnTab(_ alpha: CGFloat, frame: CGRect, center: CGPoint) {
//        if let tab = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
//            if let navCon = tab.viewControllers?.first as? UINavigationController {
//                if let viewCon = navCon.viewControllers.first as? HomeViewC {
//                    viewCon.fullScreenImageView.frame = frame
//                    viewCon.fullScreenImageView.center = center
//                    viewCon.fullScreenImageView.alpha = alpha
//                    viewCon.fullScreenImageView.contentMode = .scaleAspectFill
//                    viewCon.fullScreenImageView.image = self.imagePost.image
//                   // print(viewCon.description)
//                }
//            }
//        }
//    }
}



