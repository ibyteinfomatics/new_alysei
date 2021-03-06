//
//  EditPostViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 29/09/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import YPImagePicker

var txtEditPost: String?
protocol EditPostDisplayLogic: class{
    // func displaySomething(viewModel: EditPost.Something.ViewModel)
    func dismissSelf()
}

class EditPostViewController: UIViewController, EditPostDisplayLogic
{
    func dismissSelf() {
        
    }
    
    @IBOutlet weak var btnPostPrivacy: UIButton!
    @IBOutlet weak var txtPost: UITextView!
    // @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var viewHeaderShadow: UIView!
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var imgPrivacy: UIImageView!
    @IBOutlet weak var vwPrivacy: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnPost: UIButton!
    
    var privacy:String?
   // var privacyImageArray = [AppConstants.kPublic,AppConstants.Followers,AppConstants.OnlyMe,AppConstants.Connections]
    var privacyImageArray = ["Public","Followers","OnlyMe","Connections"]
    
    var postDesc: String?
    //    var picker = UIImagePickerController()
    var uploadImageArray = [UIImage]()
    var uploadImageArray64 = [String]()
    //    var selectedAssets = [TLPHAsset]()
    // var imagesFromSource = [UIImage]()
    var imagesFromSource = [String]()
    var ypImages = [YPMediaItem]()
    var descriptionPost: String?
    var imgHeight: Int?
    var imgWidth: Int?
    var interactor: EditPostBusinessLogic?
    var router: (NSObjectProtocol & EditPostRoutingLogic & EditPostDataPassing)?
    var postDataModel: EditPost.EditData.edit!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = EditPostInteractor()
        let presenter = EditPostPresenter()
        let router = EditPostRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        lblHeader.text = AppConstants.kWhatsNew
        btnPost.setTitle(AppConstants.kPost, for: .normal)
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        //let request = EditPost.Something.Request()
        // interactor?.doSomething(request: request)
        txtPost.textContainer.heightTracksTextView = true
        txtPost.isScrollEnabled = false
      
        vwPrivacy.layer.borderColor = UIColor.darkGray.cgColor
        vwPrivacy.layer.borderWidth = 0.5
        setUserData()
    }
    func setUserData(){
        let roleID = UserRoles(rawValue:Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)  ) ?? .voyagers
        var name = ""
        switch roleID {
        case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
            name = "\(kSharedUserDefaults.loggedInUserModal.companyName ?? "")"
        //                case .voiceExperts, .voyagers:
        case .restaurant :
            name = "\(kSharedUserDefaults.loggedInUserModal.restaurantName ?? "")"
        default:
            name = "\(kSharedUserDefaults.loggedInUserModal.firstName ?? "") \(kSharedUserDefaults.loggedInUserModal.lastName ?? "")"
        }
        userName.text = name
        if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
            //  if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().coverPhoto) {
            self.userImage.image = profilePhoto
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.masksToBounds = true
            switch roleID {
            case .distributer1, .distributer2, .distributer3:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.distributer1.rawValue).cgColor
            case .producer:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
            case .travelAgencies:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.travelAgencies.rawValue).cgColor
            case .voiceExperts:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voiceExperts.rawValue).cgColor
            case .voyagers:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voyagers.rawValue).cgColor
            case .restaurant :
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.restaurant.rawValue).cgColor
            default:
                self.userImage.layer.borderColor = UIColor.white.cgColor
            }
        }else{
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.borderColor = UIColor.white.cgColor
        }
        txtPost.text = self.postDataModel.postDescription
        txtPost.textColor = .black
        btnPostPrivacy.setTitle(self.postDataModel?.privacy?.capitalized, for: .normal)
        for i in 0..<(self.postDataModel.attachments?.count  ?? 0){
            self.imagesFromSource.append(self.postDataModel.attachments?[i].attachmentLink?.attachmentUrl ?? "")
        }
        self.collectionViewImage.reloadData()
    }
    
    //  func displaySomething(viewModel: EditPost.Something.ViewModel)
    //  {
    //    //nameTextField.text = viewModel.name
    //  }
    private func alertToAddCustomPicker() -> Void {
        
        txtEditPost = txtPost.text
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 100000
        config.showsPhotoFilters = false
        self.descriptionPost = txtPost.text
        config.library.preselectedItems = ypImages
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            self.ypImages = items
            for item in items {
                switch item {
                case .photo(let photo):
                    //self.imagesFromSource.append(photo.modifiedImage ?? photo.image)
                    self.imgWidth = photo.asset?.pixelWidth
                    self.imgHeight = photo.asset?.pixelHeight
                    
                    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ImgHeight>>>>>>>>>>>>>>>>>>>>>>>>>>>>>",self.imgHeight ?? 0)
                    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ImgHWidth>>>>>>>>>>>>>>>>>>>>>>>>>>>>>",self.imgWidth ?? 0)
                    print(photo)
                    
                case .video(let video):
                    print(video)
                }
                self.txtPost.text = self.descriptionPost
            }
            
            self.collectionViewImage.reloadData()
            picker.dismiss(animated: true, completion: nil)
            if txtEditPost == AppConstants.kEnterText {
                self.txtPost.textColor = .lightGray
            }else{
                self.txtPost.textColor = .black
            }
        }
        
        self.present(picker, animated: true, completion: nil)
        
    }
    @IBAction func postAction(_ sender: UIButton){
        
        if (txtPost.text == AppConstants.kEnterText && self.imagesFromSource.count == 0) || (txtPost.text == "" && self.imagesFromSource.count == 0) {
//            showAlert(withMessage: "Please enter some post")
           showAlert(withMessage: AppConstants.kSaySomething)

       }else if (imagesFromSource.count == 0 && txtPost.text == AppConstants.kEnterText){
       let charSet = CharacterSet.whitespaces
       let trimmedString = txtPost.text.trimmingCharacters(in: charSet)
       if trimmedString == "" {
           showAlert(withMessage: AppConstants.kSaySomething)
       }
       }else if (imagesFromSource.count == 0){
           let rawString = txtPost.text
           let whitespace = CharacterSet.whitespacesAndNewlines
           let trimmed = rawString?.trimmingCharacters(in: whitespace)
           if trimmed?.count == 0 {
               showAlert(withMessage: AppConstants.kSaySomething)
           }else{
               editPostApi()
               }
       }
       else{
           editPostApi()
       }
//        if (txtPost.text == AppConstants.kEnterText && self.imagesFromSource.count == 0) {
//            //            showAlert(withMessage: "Please enter some post")
//            showAlert(withMessage: AppConstants.KPostCantBeEmpty)
//
//        }else{
//             editPostApi()
//        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func changePrivacyAction(_ sender: UIButton){
       // postPrivacyTableView.isHidden = false
        txtPost.resignFirstResponder()
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alertController.addAction(UIAlertAction(title: AppConstants.kPublic, style: .default, handler: { (action: UIAlertAction!) in
                self.btnPostPrivacy.setTitle(AppConstants.kPublic, for: .normal)
            }))
            alertController.addAction(UIAlertAction(title: AppConstants.Followers, style: .default, handler: { (action: UIAlertAction!) in
                self.btnPostPrivacy.setTitle(AppConstants.Followers, for: .normal)
            }))

        alertController.addAction(UIAlertAction(title: AppConstants.OnlyMe, style: .default, handler: { (action: UIAlertAction!) in
                self.btnPostPrivacy.setTitle(AppConstants.OnlyMe, for: .normal)
            }))
        alertController.addAction(UIAlertAction(title: AppConstants.Connections, style: .default, handler: { (action: UIAlertAction!) in
                
                self.btnPostPrivacy.setTitle(AppConstants.Connections, for: .normal)
            }))

            alertController.addAction(UIAlertAction(title: MarketPlaceConstant.kCancel, style: .cancel, handler: { (action: UIAlertAction!) in
            }))


            self.present(alertController, animated: true, completion: nil)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let finalText = updatedText.removeWhitespace()
        if finalText.count <= 200{
            return true
        }else{
            return false
        }
    }
}
extension EditPostViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.imagesFromSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditCollectionViewCell", for: indexPath) as? EditCollectionViewCell else {return UICollectionViewCell()}
        
        cell.btnDelete.isHidden = true
        let imageString = (self.postDataModel.attachments?[indexPath.row].attachmentLink?.baseUrl ?? "") + "\(self.postDataModel.attachments?[indexPath.row].attachmentLink?.attachmentUrl ?? "")"
        
        if let url = URL(string: imageString) {
            
            cell.image.contentMode = .scaleAspectFill
            cell.image.loadImageWithUrl(url)
           // print("size:  \(cell.image.getSize())")
            //            cell.image.frame.size = CGSize(width: cell.frame.width, height: cell.frame.height)
            //            cell.layoutSubviews()
        }
        return cell
    }
    
    func btnScroll() {
        collectionViewImage.scrollToItem(at: IndexPath(item: self.imagesFromSource.count, section: 0), at: UICollectionView.ScrollPosition.right, animated:true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.imagesFromSource.count == 0{
            return CGSize(width: collectionView.bounds.width , height: 200)
        }else{
            return CGSize(width: collectionView.bounds.width / 3, height: 200)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.imagesFromSource.count ==  0 {
            // alertToAddImage()
            alertToAddCustomPicker()
        }else if indexPath.row >= self.imagesFromSource.count{
            //alertToAddImage()
            alertToAddCustomPicker()
        }
    }
}
//MARK: UITableView
//extension EditPostViewController : UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = postPrivacyTableView.dequeueReusableCell(withIdentifier: "PostPrivacyTableViewCell", for: indexPath) as? PostPrivacyTableViewCell else {return UITableViewCell()}
//        cell.selectionStyle = .none
//        cell.labelPrivacy.text = privacyArray[indexPath.row]
//        cell.imgPrivacy.image = UIImage(named: privacyImageArray[indexPath.row])
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        postPrivacyTableView.isHidden = true
//        btnPostPrivacy.setTitle(privacyArray[indexPath.row], for: .normal)
//        imgPrivacy.image = UIImage(named: privacyImageArray[indexPath.row])
//    }
//
//
//}
extension EditPostViewController {
    func editPostApi(){

        postDesc = txtPost.text
        if txtPost.text == AppConstants.kEnterText {
            postDesc = ""
        }

        let params: [String:Any] = [
            
            "action_type": "post",
            "post_id": "\(self.postDataModel.postID)",
            "body": postDesc ?? "",
            "privacy": btnPostPrivacy.title(for: .normal)?.lowercased() ?? ""
            
        ]
        
       // CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kEditPost, image: imageParam, controller: self, type: 0)
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kEditPost, method: .POST, controller: self, type: 0, param: params, btnTapped: UIButton())
      
    }
    override func didUserGetData(from result: Any, type: Int) {
//        self.showAlert(withMessage: "Post Successfully") {
//        }
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = Tabbar.home.rawValue

    }
}
class EditCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var image: ImageLoader!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    var btnDeleteCallback:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
}
