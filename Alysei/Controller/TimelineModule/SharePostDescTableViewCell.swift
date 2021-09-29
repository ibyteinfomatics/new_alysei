//
//  SharePostDescTableViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 9/22/21.
//

import UIKit
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
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var lblPostTime: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblSharePostDesc: UILabel!
    @IBOutlet weak var lblSharedUserName: UILabel!
    @IBOutlet weak var lblSharedUserEmail: UILabel!
    @IBOutlet weak var imgSharedUserImage: UIImageView!
    @IBOutlet weak var lblSharedPostDesc: UILabel!
    @IBOutlet weak var lblSharedUserTitle: UILabel!
    @IBOutlet weak var vwHeader: UIView!

    var data: NewFeedSearchDataModel?
    var index: Int?
    var imageArray = [String]()
    var menuDelegate: ShareEditMenuProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
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
        lblSharedUserName.text = modelData.subjectId?.companyName?.capitalized
        userName.text = modelData.sharedPostData?.subjectId?.companyName?.capitalized
        lblSharedUserTitle.text = modelData.subjectId?.companyName?.capitalized
        
        lblSharedUserEmail.text = modelData.subjectId?.email
    //userName.text = modelData.subjectId?.companyName?.capitalized
    //userNickName.text = modelData.subjectId?.email
    }else if modelData.subjectId?.roleId == UserRoles.restaurant.rawValue{
        lblSharedUserName.text = modelData.subjectId?.restaurantName?.capitalized
        userName.text = modelData.sharedPostData?.subjectId?.restaurantName?.capitalized
        lblSharedUserTitle.text = modelData.subjectId?.restaurantName?.capitalized
        lblSharedUserEmail.text = modelData.subjectId?.email
        //userNickName.text = modelData.subjectId?.email
    }else{
        //userName.text = "\(modelData.subjectId?.firstName?.capitalized ?? "")" + "\(modelData.subjectId?.lastName?.capitalized ?? "")"
        lblSharedUserName.text = modelData.subjectId?.companyName?.capitalized
        userName.text = modelData.sharedPostData?.subjectId?.companyName?.capitalized
        lblSharedUserEmail.text = modelData.subjectId?.name?.capitalized
        lblSharedUserTitle.text = modelData.subjectId?.companyName?.capitalized
       // userNickName.text = modelData.subjectId?.name?.capitalized
    }
    lblPostDesc.text = modelData.sharedPostData?.body
    lblSharePostDesc.text = modelData.body
    lblPostLikeCount.text = "\(modelData.likeCount ?? 0)"
    lblPostCommentCount.text = "\(modelData.commentCount ?? 0)"
    lblPostTime.text = modelData.posted_at
    //islike = data.likeFlag
    if modelData.sharedPostData?.attachmentCount == 0 {
        imageHeightCVConstant.constant = 0
//            imagePostCollectionView.alpha = 0.0
    }else{
        imageHeightCVConstant.constant = 220
//            imagePostCollectionView.alpha = 1.0
    }
    self.userImage.layer.borderWidth = 0.5
    self.userImage.layer.borderColor = UIColor.lightGray.cgColor
    print("ImageUrl--------------------------------\(String.getString(modelData.subjectId?.avatarId?.attachmentUrl) )")
    if String.getString(modelData.subjectId?.avatarId?.attachmentUrl) == ""{
        self.imgSharedUserImage.image = UIImage(named: "profile_icon")
    }
    if String.getString(modelData.sharedPostData?.subjectId?.avatarId?.attachmentUrl) == ""{
        self.userImage.image = UIImage(named: "profile_icon")
    }
    if String.getString(modelData.subjectId?.avatarId?.attachmentUrl) != ""{
        self.imgSharedUserImage.setImage(withString: kImageBaseUrl + String.getString(modelData.subjectId?.avatarId?.attachmentUrl))
    }
    if String.getString(modelData.sharedPostData?.subjectId?.avatarId?.attachmentUrl) != ""{
        
        self.userImage.setImage(withString: kImageBaseUrl + String.getString(modelData.sharedPostData?.subjectId?.avatarId?.attachmentUrl))
    //self.userImage.setImage(withString: kImageBaseUrl + String.getString(modelData.subjectId?.avatarId?.attachmentUrl))
    }
    likeImage.image = modelData.likeFlag == 0 ? UIImage(named: "like_icon") : UIImage(named: "liked_icon")

    self.imagePostCollectionView.isPagingEnabled = true

    self.imagePostCollectionView.showsHorizontalScrollIndicator = false

    self.imageArray.removeAll()
//    for i in  0..<(modelData.sharedPostData?.attachmentCount ?? 0) {
//        self.imageArray.append(modelData.sharedPostData?.attachments?[i].attachmentLink?.attachmentUrl ?? "")
//
//
//
//    }
    if (modelData.sharedPostData?.attachments?.isEmpty == true) || (modelData.sharedPostData?.attachmentCount == 0){
             print("No Data")
            }else{
                    for i in  0..<(modelData.sharedPostData?.attachmentCount ?? 0) {
                        self.imageArray.append(modelData.sharedPostData?.attachments?[i].attachmentLink?.attachmentUrl ?? "")
                
                
                
                    }
            }
    print("ImageArrayCount---------------------------\(imageArray.count)")

    if imageArray.count <= 0 {
        self.pageControl.alpha = 0
    } else {
        self.pageControl.alpha = 1
        self.pageControl.numberOfPages = imageArray.count
    }

    self.imagePostCollectionView.reloadData()
}
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
       // self.menuDelegate.menuBttonTapped(4, userID: 5)
        self.menuDelegate.menuBttonTapped(self.data?.postID, userID: self.data?.subjectId?.userId ?? 0)
        
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

        print("ImageArray---------------------------------\(self.imageArray)")
//        for i in 0..<imageArray.count {
//            cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(imageArray[i]))
//            cell.imagePost.backgroundColor = .yellow
//        }

        cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(imageArray[indexPath.row]))
        cell.imagePost.contentMode = .scaleAspectFill
        //cell.imagePost.setImage(withString: kImageBaseUrl + String.getString(data?.attachments?.attachmentLink?.attachmentUrl))
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.pageControl.currentPage = indexPath.row
//    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: self.imagePostCollectionView.frame.width - 20, height: 220)
        return CGSize(width: (self.imagePostCollectionView.frame.width), height: 220);
    }
//
//     func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        imagePostCollectionView?.collectionViewLayout.invalidateLayout();
//   }
}
