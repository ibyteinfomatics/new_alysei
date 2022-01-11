//
//  UpdateProfileCoverImgVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/10/21.
//

import UIKit

class UpdateProfileCoverImgVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var imgCoverPic: UIImageView!

    var passprofilePicUrl: String?
    var passImagebaseUrl: String?
    var passCoverbaseUrl: String?
    var passCoverPicUrl: String?
    var imageParams = [[String:Any]]()
    var picker = UIImagePickerController()
    var checkUploadImg: Int?
    var imagePickerCallback: (() -> Void)? = nil
    
    var profilePic: UIImage?
    var coverPic: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        imgProfilePic.layer.cornerRadius = self.imgProfilePic.frame.height / 2
        imgProfilePic.layer.masksToBounds = true
        imgProfilePic.layer.borderWidth = 0.5
        imgProfilePic.layer.borderColor = UIColor.lightGray.cgColor
        self.view.layer.cornerRadius = 10
        if passprofilePicUrl == "" || passprofilePicUrl == nil {
            imgProfilePic.image = UIImage(named: "profile_icon")
        }else{
            let imgUrl = ((passImagebaseUrl ?? "") + (passprofilePicUrl ?? ""))
            imgProfilePic.setImage(withString: imgUrl)
        }
        
        if passCoverPicUrl == "" || passCoverPicUrl == nil {
            imgCoverPic.image = UIImage(named: "image_placeholder")
        }else{
            let imgUrl = ((passCoverbaseUrl ?? "") + (passCoverPicUrl ?? ""))
            imgCoverPic.setImage(withString: imgUrl)
        }
        
    }
    
    @IBAction func btnUpdateCover(_ sender: UIButton){
        checkUploadImg = sender.tag
        alertToAddImage()
    }
    
    @IBAction func btnUpdateProfile(_ sender: UIButton){
        checkUploadImg = sender.tag
        alertToAddImage()
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton){
        if imgProfilePic.image == UIImage(named: "profile_icon"){
            profilePic = UIImage()
        }
        if  imgCoverPic.image == UIImage(named: "image_placeholder"){
            coverPic = UIImage()
        }
        callSaveApi()
    }
    
    private func showImagePicker(withSourceType type: UIImagePickerController.SourceType,mediaType: MediaType) -> Void {

        if UIImagePickerController.isSourceTypeAvailable(type) {

            self.picker.mediaTypes = mediaType.CameraMediaType
            self.picker.allowsEditing = true
            self.picker.sourceType = type
            self.present(self.picker,animated: true,completion: {
                self.picker.delegate = self
            })
            self.picker.delegate = self }
        else{
            self.showAlert(withMessage: "This feature is not available.")
        }
    }
    
    private func alertToAddImage() -> Void {

        let alert:UIAlertController = UIAlertController(title: AlertMessage.kSourceType, message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        let cameraAction = UIAlertAction(title: AlertMessage.kTakePhoto,
                                         style: UIAlertAction.Style.default) { (action) in
            self.showImagePicker(withSourceType: .camera, mediaType: .image)
        }

        let galleryAction = UIAlertAction(title: AlertMessage.kChooseLibrary,
                                          style: UIAlertAction.Style.default) { (action) in
            self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
        }

        let cancelAction = UIAlertAction(title: AlertMessage.kCancel,
                                         style: UIAlertAction.Style.cancel) { (action) in
            print("\(AlertMessage.kCancel) tapped")
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)

        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
extension UpdateProfileCoverImgVC {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        self.dismiss(animated: true) {

            if self.checkUploadImg == 0{
               
                //self.imgCoverPic = selectedImage
                self.imgCoverPic.image = selectedImage
                self.coverPic = selectedImage
               
            }
            else {
              //  self.isCoverPhotoCaptured = true
                //self.coverPhoto = selectedImage
                self.imgProfilePic.image = selectedImage
                self.profilePic = selectedImage
            }
        }
    }
}

extension UpdateProfileCoverImgVC{
    func callSaveApi(){
        
        let imageParamProfile : [String:Any] = [APIConstants.kImage: self.profilePic ?? UIImage(),
                                         APIConstants.kImageName: APIConstants.kAvatarId]
        imageParams.append(imageParamProfile)
        let imageParamCover : [String:Any] = [APIConstants.kImage: self.coverPic ?? UIImage(),
                                         APIConstants.kImageName: APIConstants.kCoverId]
      
        imageParams.append(imageParamCover)
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: APIUrl.kSaveProfileCover, requestMethod: .post, requestImages: imageParams, requestVideos: [:], requestData: [:]) { dictResponse, error, errtype,statusCode in
            switch statusCode {
            case 200:
                self.imagePickerCallback?()
                self.dismiss(animated: true, completion: nil)
            default:
                print("Error")
            }
            
        }
    }
    
   
}
