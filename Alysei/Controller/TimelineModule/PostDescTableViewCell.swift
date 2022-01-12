//
//  PostDescTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/26/21.
//

import UIKit
import ScrollingPageControl
//import SocketIO

//struct PostLikeUnlikeRequestModel: Codable, SocketData {
    struct PostLikeUnlikeRequestModel: Codable {

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

    //let manager = SocketManager(socketURL: URL(string: "https://alyseisocket.ibyteworkshop.com")!, config: [.log(true), .compress])


protocol ShareEditMenuProtocol {
    func menuBttonTapped(_ postID: Int?, userID: Int)
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
    @IBOutlet weak var collectionVieweHight: NSLayoutConstraint!
    
    
    var data: NewFeedSearchDataModel?
    var likeCallback:((Int) -> Void)? = nil
    var shareCallback:(()->())?
    var commentCallback:((PostCommentsUserData) -> Void)? = nil
    var islike: Int?
    var index: Int?
    var imageArray = [String]()
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
        self.menuDelegate.menuBttonTapped(self.data?.postID, userID: self.data?.subjectId?.userId ?? 0)
        
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
    
    func configCell(_ modelData: NewFeedSearchDataModel, _ index: Int) {

        _ = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0

     
        self.viewLike.tag = index
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        self.viewLike.addGestureRecognizer(tap)

        self.data = modelData
//        self.index = index
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
            imageHeightCVConstant.constant = 0
//            imagePostCollectionView.alpha = 0.0
        }else{
            
            if modelData.attachments?.count ?? 0 > 1 {
                
                //var numbers = [Int]()
                var height1 = 0,height2 = 0,height3 = 0,height = 0
                for i in  0..<(modelData.attachments?.count ?? 0) {
                   // self.imageArray.append(modelData.attachments?[i].attachmentLink?.attachmentUrl ?? "")
                    //numbers.append(modelData.attachments?[i].attachmentLink?.width ?? 0)
                    if modelData.attachments?[i].attachmentLink?.height == modelData.attachments?[i].attachmentLink?.width {
                        height1 = 350
                    } else if Int.getInt(modelData.attachments?[i].attachmentLink?.width) > Int.getInt(modelData.attachments?[i].attachmentLink?.height) {
                        height2 = 300
                    } else if Int.getInt(modelData.attachments?[i].attachmentLink?.height) > Int.getInt(modelData.attachments?[i].attachmentLink?.width) && Int.getInt(modelData.attachments?[i].attachmentLink?.height) < 500{
                        
                        if Int.getInt(modelData.attachments?[i].attachmentLink?.height) < 350 {
                            height3 = 350
                        } else {
                            //height3 = Int(CGFloat(modelData.attachments?[i].attachmentLink?.height ?? 0 * 72 / 96)-200) //500
                            height3 = 500
                        }
                        
                        
                    }else if Int.getInt(modelData.attachments?[i].attachmentLink?.height) > 500{
                        height = 500
                    }
                }
            
                if height3 > height1 && height3 > height2{
                    height = height3
                } else if height1 > height3 && height1 > height2{
                    height = height1
                } else if height2 > height3 && height2 > height1{
                    height = height2
                }
                
                
                imageHeightCVConstant.constant = CGFloat(height)//500
               
            } else {
                if modelData.attachments?.first?.attachmentLink?.height == modelData.attachments?.first?.attachmentLink?.width {
                    imageHeightCVConstant.constant = 350
                } else if Int.getInt(modelData.attachments?.first?.attachmentLink?.width) > Int.getInt(modelData.attachments?.first?.attachmentLink?.height) {
                    
                    
                    if (Int.getInt(modelData.attachments?.first?.attachmentLink?.width)) > 500{
                        imageHeightCVConstant.constant = 500
                    } else if (Int.getInt(modelData.attachments?.first?.attachmentLink?.width)) > 300{
                        imageHeightCVConstant.constant = 400
                    } else {
                        imageHeightCVConstant.constant = 300
                    }
                    
                } else if Int.getInt(modelData.attachments?.first?.attachmentLink?.height) > Int.getInt(modelData.attachments?.first?.attachmentLink?.width) {
                //imageHeightCVConstant.constant = 350
                    
                    if Int.getInt(modelData.attachments?.first?.attachmentLink?.height) < 350 {
                        imageHeightCVConstant.constant = 350
                    } else {
                        //height3 = Int(CGFloat(modelData.attachments?[i].attachmentLink?.height ?? 0 * 72 / 96)-200) //500
                        imageHeightCVConstant.constant = 500
                    }
                    
                    
                    //imageHeightCVConstant.constant = CGFloat(modelData.attachments?.first?.attachmentLink?.height ?? 0 * 72 / 96)-150//500
                }
            }
            
            
//            imagePostCollectionView.alpha = 1.0
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
        if (modelData.attachments?.isEmpty == true) || (modelData.attachments?.count == 0){
            print("No Data")
        }else{
            for i in  0..<(modelData.attachments?.count ?? 0) {
                let baseUrl = modelData.attachments?[i].attachmentLink?.baseUrl ?? ""
                self.imageArray.append(baseUrl + "\(modelData.attachments?[i].attachmentLink?.attachmentUrl ?? "")")
                
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

        //let selfID = Int(kSharedUserDefaults.loggedInUserModal.userId ?? "-1") ?? 0
        //let params = ["post_owner_id": self.data?.subjectId?.userId ?? -1,
                     // "user_id": selfID,
                      //"post_id": self.data?.postID ?? -1,
                      //"like_status": islike ?? 1]

//        let sd = params.socketRepresentation()
//
//        socket.emit("doLike", with: [sd]) {
//            print("doLike - inside ")
//        }
//
//        socket.on("showLike") { showLikeData, showLikeAck in
//            print("inside show like - start")
//            print(showLikeData)
//            print("inside show like - end")
//
////            socket.disconnect()
//
//            if let data = showLikeData[0] as? [String: Any] {
//
//                if let postID = data["post_id"] as? Int {
//                    if postID != (self.data?.postID ?? -1) {
//                        return
//                    }
//                }
//
//                let totalLikes = data["total_likes"] as? Int
//                self.data?.likeCount = totalLikes ?? 0
//
//                let likeStatus = data["like_status"] as? Int
//                self.data?.likeFlag = likeStatus ?? 0
//
//                self.likeCallback?(self.index ?? 0)
//            }
//
//
//        }
//
//
//        socket.on(clientEvent: .error) { data, ack in
//            print(data)
//        }

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
            return UICollectionViewCell()
        }

        //print("ImageArray---------------------------------\(self.imageArray)")
//        for i in 0..<imageArray.count {
//            cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(imageArray[i]))
//            cell.imagePost.backgroundColor = .yellow
//        }
        cell.imagePost.contentMode = .scaleAspectFill
       // cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(imageArray[indexPath.row]))
        print("checkUrlImageurl--------------------------------\(String.getString(imageArray[indexPath.row]))")
        cell.imagePost.setImage(withString: String.getString(imageArray[indexPath.row]))
        
        //cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(data?.attachments?.attachmentLink?.attachmentUrl))
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.pageControl.currentPage = indexPath.row
//    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
       
        vwpageControl.selectedPage = indexPath.row
        
       // self.collectionView(self.imagePostCollectionView, cellForItemAt: IndexPath(item: 1, section: 0))
        //self.collectionView(self.imagePostCollectionView, layout: UICollectionViewLayout, sizeForItemAt: indexPath)
        
        /*if self.data?.attachments?.count ?? 0 > 1 {
            var height = 0
            if self.data?.attachments?[indexPath.row].attachmentLink?.height == self.data?.attachments?[indexPath.row].attachmentLink?.width {
                 height = 350
             } else if Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.width) > Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.height) {
                height = 200
             } else if Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.height) > Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.width) {
                height = Int(CGFloat(self.data?.attachments?[indexPath.row].attachmentLink?.height ?? 0
                                        * 72 / 96)-150)//500
             }
            
            let cellSize = CGSize(width:self.imagePostCollectionView.frame.width , height:CGFloat(height))

            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = cellSize
            imagePostCollectionView.setCollectionViewLayout(layout, animated: true)
        }*/
        
        
        
       /* if self.data?.attachments?[indexPath.row].attachmentLink?.height == self.data?.attachments?[indexPath.row].attachmentLink?.width {
            imageHeightCVConstant.constant = 350
        } else if Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.width) > Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.height) {
            imageHeightCVConstant.constant = 200
        } else if Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.height) > Int.getInt(self.data?.attachments?[indexPath.row].attachmentLink?.width) {
            imageHeightCVConstant.constant = CGFloat(self.data?.attachments?[indexPath.row].attachmentLink?.height ?? 0
                                                        * 72 / 96)-150//500
        }*/
       
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: self.imagePostCollectionView.frame.width - 20, height: 220)
        let data = self.data?.attachments?[indexPath.row]
        
        if self.data?.attachments?.count ?? 0 > 1 {
            //data = self.data?.attachments?[1]
        }
        
        
        
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

extension PostDescTableViewCell {
    
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
   
        func viewForDot(at index: Int) -> UIView? {
            guard index == 0 else { return nil }
            let view = TriangleView()
            view.isOpaque = false
            return view
        }
    
}

class PostImageCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate{
    @IBOutlet weak var imagePost: UIImageView!

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
        pan.minimumNumberOfTouches = 2
        pan.maximumNumberOfTouches = 2
        pan.delegate = self
        self.imagePost.addGestureRecognizer(pan)
    }

    @objc func pinch(sender:UIPinchGestureRecognizer) {
        var touchBaseView = sender.view
        if let tab = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
            if let navCon = tab.viewControllers?.first as? UINavigationController {
                if let viewCon = navCon.viewControllers.first as? HomeViewC {
                    touchBaseView = viewCon.view
                }
            }
        }
//        let touch1 = sender.location(ofTouch: 0, in: touchBaseView)

        let touch1 = sender.location(ofTouch: 0, in: touchBaseView)
        var midPointX = touch1.x
        var midPointY = touch1.y
        if sender.numberOfTouches > 1 {
            let touch2 = sender.location(ofTouch: 1, in: touchBaseView)
            midPointX = (touch1.x + touch2.x)/2
            midPointY = (touch1.y + touch2.y)/2
        }

        let touchedPoint = CGPoint(x: midPointX, y: midPointY)
//        let touch2 = sender.location(ofTouch: 1, in: sender.view)

        if sender.state == .began {
            self.imagePost.frame = UIScreen.main.bounds
            let currentScale = self.imagePost.frame.size.width / self.imagePost.bounds.size.width
            let newScale = currentScale*sender.scale
            if newScale > 1 {
                self.isZooming = true
            }
            self.showAlertOnTab(1.0, frame: self.imagePost.frame, center: touchedPoint)

        } else if sender.state == .changed {
            guard let view = sender.view else {return}
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                      y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            let currentScale = self.imagePost.frame.size.width / self.imagePost.bounds.size.width
            var newScale = currentScale*sender.scale
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.imagePost.transform = transform
                sender.scale = 1
            }else {
                view.transform = transform
                sender.scale = 1
            }
            self.showAlertOnTab(1.0, frame: self.imagePost.frame, center: touchedPoint)
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            self.showAlertOnTab(0.0, frame: self.imagePost.frame, center: CGPoint())
            guard let center = self.originalImageCenter else {return}

            self.imagePost.frame = self.bounds
            UIView.animate(withDuration: 0.3, animations: {
                self.imagePost.transform = CGAffineTransform.identity
                self.imagePost.center = center
                sender.scale = 1
            }, completion: { _ in
                self.isZooming = false
            })
        }
    }

    @objc func pan(sender: UIPanGestureRecognizer) {
        if self.isZooming && sender.state == .began {
            self.originalImageCenter = sender.view?.center
        } else if self.isZooming && sender.state == .changed {
            let translation = sender.translation(in: self)
            if let view = sender.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint.zero, in: self.imagePost.superview)
        }
    }

    func  showAlertOnTab(_ alpha: CGFloat, frame: CGRect, center: CGPoint) {
        if let tab = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
            if let navCon = tab.viewControllers?.first as? UINavigationController {
                if let viewCon = navCon.viewControllers.first as? HomeViewC {
                    viewCon.fullScreenImageView.frame = frame
                    viewCon.fullScreenImageView.center = center
                    viewCon.fullScreenImageView.alpha = alpha
                    viewCon.fullScreenImageView.contentMode = .scaleAspectFill
                    viewCon.fullScreenImageView.image = self.imagePost.image
                    print(viewCon.description)
                }
            }
        }
    }
}


