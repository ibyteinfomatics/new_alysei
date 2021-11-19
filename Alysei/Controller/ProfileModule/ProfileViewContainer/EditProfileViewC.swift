//
//  EditProfileViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 15/01/21.
//

import UIKit

class EditProfileViewC: AlysieBaseViewC, AddProductCallBack {

    //MARK:  - IBOutlet -
    
    @IBOutlet weak var tableViewEditProfile: UITableView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnProfilePhoto: UIButton!
    @IBOutlet weak var btnCoverPhoto: UIButton!
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var imgViewCoverPhoto: UIImageView!

    //MARK:  - Properties -

    var isProfilePhotoCaptured = false
    var isCoverPhotoCaptured = false
    var profilePhotoAlreadyExists = false
    var coverPhotoAlreadyExists = false

    var featureListingId: String?
    var currentProductTitle: String?

    var profilePhoto: UIImage?
    var coverPhoto :UIImage?
    var userType = UserRoles.voyagers

    var picker = UIImagePickerController()
    var signUpViewModel: SignUpViewModel!
    var signUpStepOneDataModel: SignUpStepOneDataModel!
    var isCameProfileUpdate : isCameFrom?
    var fromProfileCompletion: Bool?
    var forProfileCompletionProfile: Bool?
    var forProfileCompletionCover: Bool?

    //MARK:  - ViewLifeCycle Methods -

    override func viewDidLoad() {

        super.viewDidLoad()
//        print("Profile Pic----------------------------------------------\(signUpViewModel.profileData?.avatarID?.attachmentURL ?? "")")
//        print("Cover Pic----------------------------------------------\(signUpViewModel.profileData?.coverID?.attachmentURL ?? "")")
        if fromProfileCompletion == true && forProfileCompletionProfile == true{
            self.tapProfilePhoto(UIButton())
        }
        if fromProfileCompletion == true && forProfileCompletionCover == true{
            self.tapCoverPhoto(UIButton())
        }
//        if let coverPhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().coverPhoto) {
//           //, (kSharedUserDefaults.loggedInUserModal.cover != nil) {
//            self.coverPhotoAlreadyExists = true
//            self.imgViewCoverPhoto.image = coverPhoto
//        }
        
        let imgUrl = (kImageBaseUrl + (self.signUpViewModel.profileData?.coverID?.attachmentURL ?? ""))
        self.imgViewCoverPhoto.setImage(withString: imgUrl)
        
//        if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
//           //, (kSharedUserDefaults.loggedInUserModal.avatar != nil)
//            self.profilePhotoAlreadyExists = true
//            self.imgViewProfile.image = profilePhoto
//        }
        let imgPUrl = (kImageBaseUrl + (self.signUpViewModel.profileData?.avatarID?.attachmentURL ?? ""))
        self.imgViewProfile.setImage(withString: imgPUrl)

        self.imgViewProfile.roundCorners(.allCorners, radius: (self.imgViewProfile.frame.width / 2.0))
        
        fetchProductsFromProfile()
    }

    func fetchProductsFromProfile() {
        if let nav = self.parent as? UINavigationController, let profileCon = nav.viewControllers.first as? ProfileViewC {
            profileCon.reloadFields()

        }

//        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSubmittedFields, method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())

        guard let request = WebServices.shared.buildURLRequest(APIUrl.kUserSubmittedFields, method: .GET) else {
            return
        }
        WebServices.shared.request(request) { data, urlResponse, statusCode, error in

        }

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToTop()
        
       self.tableViewEditProfile.reloadData()
    }
    func scrollToTop(){
       // self.tableViewEditProfile.setContentOffset(CGPointMake(0,  UIApplication.shared.statusBarFrame.height ), animated: true)
        self.tableViewEditProfile.setContentOffset(CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height ), animated: true)
    }
    //MARK: - IBAction -

    @IBAction func tapBack(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tapSave(_ sender: UIButton) {
        isCameProfileUpdate = .save
        self.postRequestToUpdateUserProfile()
    }

    @IBAction func tapCoverPhoto(_ sender: UIButton) {

        self.btnProfilePhoto.isSelected = false
        self.btnCoverPhoto.isSelected = true
        self.alertToAddImage()
    }

    @IBAction func tapProfilePhoto(_ sender: UIButton) {

        self.btnProfilePhoto.isSelected = true
        self.btnCoverPhoto.isSelected = false
        self.alertToAddImage()
    }

    //MARK: - Public Methods -

    func productAdded() {
        self.fetchProductsFromProfile()

    }

    //MARK:  - Private Methods -
    
    private func getEditProfileSelectTableCell(_ indexPath: IndexPath) -> UITableViewCell{

        let editProfileSelectTableCell = tableViewEditProfile.dequeueReusableCell(withIdentifier: EditProfileSelectTableCell.identifier(), for: indexPath) as! EditProfileSelectTableCell
        if self.signUpStepOneDataModel == nil{
            let model = self.signUpViewModel.arrSignUpStepOne.filter({($0.name == "product_type")})
            model.first?.selectedValue = self.createStringForProducts((model.first)!)

            let modelExp = self.signUpViewModel.arrSignUpStepOne.filter({($0.name == "expertise")})
            modelExp.first?.selectedValue = self.createStringForProducts((modelExp.first)!)
        
            let modelTitle =  self.signUpViewModel.arrSignUpStepOne.filter({($0.name == "title")})
            modelTitle.first?.selectedValue = self.createStringForProducts((modelTitle.first)!)

            let modelRes =  self.signUpViewModel.arrSignUpStepOne.filter({($0.name == "restaurant_type")})
            modelRes.first?.selectedValue = self.createStringForProducts((modelRes.first)!)
            
            let modelSpec =  self.signUpViewModel.arrSignUpStepOne.filter({($0.name == "speciality")})
            modelSpec.first?.selectedValue = self.createStringForProducts((modelSpec.first)!)
            
        }
        editProfileSelectTableCell.configure(withSignUpStepOneDataModel: self.signUpViewModel.arrSignUpStepOne[indexPath.row])
        editProfileSelectTableCell.lblHeadingTopConst.constant = 5 // indexPath.row == 0 ? 60 : 20

        return editProfileSelectTableCell
    }

    private func getSignUpMultiCheckboxTableCell(_ indexPath: IndexPath) -> UITableViewCell{

        let signUpMultiCheckboxTableCell = tableViewEditProfile.dequeueReusableCell(withIdentifier: SignUpMultiCheckboxTableCell.identifier(), for: indexPath) as! SignUpMultiCheckboxTableCell
        signUpMultiCheckboxTableCell.delegate = self
        signUpMultiCheckboxTableCell.configureStepOneData(withSignUpStepOneDataModel: self.signUpViewModel.arrSignUpStepOne[indexPath.row])
        signUpMultiCheckboxTableCell.lblHeadingTopConst.constant = 5 // indexPath.row == 0 ? 60 : 20
        return signUpMultiCheckboxTableCell
    }
    
    private func getEditProfileTextViewTableCell(_ indexPath: IndexPath) -> UITableViewCell{

        let editProfileTextViewTableCell = self.tableViewEditProfile.dequeueReusableCell(withIdentifier: EditProfileTextViewTableCell.identifier(), for: indexPath) as! EditProfileTextViewTableCell
        editProfileTextViewTableCell.configure(withSignUpStepOneDataModel: self.signUpViewModel.arrSignUpStepOne[indexPath.row])
        editProfileTextViewTableCell.lblHeadingTopConst.constant = 5 // indexPath.row == 0 ? 60 : 20
        return editProfileTextViewTableCell
    }

    private func getSignUpRadioTableCell(_ indexPath: IndexPath) -> UITableViewCell{

        let signUpFormTableCell = tableViewEditProfile.dequeueReusableCell(withIdentifier: SignUpFormTableCell.identifier(), for: indexPath) as! SignUpFormTableCell
        signUpFormTableCell.configure(withSignUpStepOneDataModel: self.signUpViewModel.arrSignUpStepOne[indexPath.row])
        signUpFormTableCell.delegate = self
        signUpFormTableCell.lblHeadingTopConst.constant = 5 // indexPath.row == 0 ? 60 : 20
        return signUpFormTableCell
    }

    private func openPicker(withArray arr: [String],model: SignUpStepOneDataModel,keyValue keyVal: String?) -> Void {

        let picker = RSPickerView.init(view: self.view, arrayList: arr, keyValue: keyVal, prevSelectedValue: 0, handler: {(selectedIndex: NSInteger, response: Any?) in

                                        if let strVal = response as? String{

                                            //        if model.arrOptions[selectedIndex].userFieldOptionId.isEmpty == true{
                                            //          kSharedInstance.signUpViewModel.roleId = model.arrOptions[selectedIndex].roleid
                                            //        }
                                            //        else{
                                            let optionId = model.arrOptions[selectedIndex].userFieldOptionId
                                            model.selectedValue = optionId
                                            //}
                                            model.selectedOptionName = strVal
                                            self.tableViewEditProfile.reloadData()
                                            print("selectedValue",strVal.uppercased())
                                        }})
        picker.viewContainer.backgroundColor = UIColor.white
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

//        let deletePhotoAction = UIAlertAction(title: AlertMessage.kDeletePhoto,
//                                              style: UIAlertAction.Style.default) { (action) in
//            if self.isProfilePhotoCaptured {
//                self.isProfilePhotoCaptured = false
//                self.imgViewProfile.image = UIImage(named: "user_icon_normal")
//                self.profilePhoto = nil
//            } else if self.isCoverPhotoCaptured {
//                self.isCoverPhotoCaptured = false
//                self.imgViewCoverPhoto.image = UIImage(named: "coverPhoto")
//                self.coverPhoto = nil
//            }
//        }
//        // remove photo action will be shown in alert only when user has captured an image for either profile picture or cover photo
//        if self.isProfilePhotoCaptured && self.btnProfilePhoto.isSelected {
//            alert.addAction(deletePhotoAction)
//        } else if self.isCoverPhotoCaptured && self.btnCoverPhoto.isSelected {
//            alert.addAction(deletePhotoAction)
//        }


//        let removePhotoAction = UIAlertAction(title: AlertMessage.kRemovePhoto,
//                                                 style: UIAlertAction.Style.default) { (action) in
//            if self.profilePhotoAlreadyExists && self.btnProfilePhoto.isSelected {
//                self.profilePhotoAlreadyExists = false
//                self.imgViewProfile.image = UIImage(named: "user_icon_normal")
//                self.profilePhoto = nil
//                self.deletePicture(UserDetailBasedElements().profilePhoto, imageType: 1)
//            } else if self.coverPhotoAlreadyExists &&  self.btnCoverPhoto.isSelected {
//                self.coverPhotoAlreadyExists = false
//                self.imgViewCoverPhoto.image = UIImage(named: "coverPhoto")
//                self.coverPhoto = nil
//                self.deletePicture(UserDetailBasedElements().coverPhoto, imageType: 2)
//            }
//        }

        // remove photo action will be shown in alert only when user has captured an image for either profile picture or cover photo
//        if self.profilePhotoAlreadyExists && self.btnProfilePhoto.isSelected {
//            alert.addAction(removePhotoAction)
//        } else if self.coverPhotoAlreadyExists && self.btnCoverPhoto.isSelected {
//            alert.addAction(removePhotoAction)
//        }

        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    private func deletePicture(_ imageName: String, imageType: Int) {

        switch imageType {
        case 1:
            print("delete profile photo")
            guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.Images.removeProfilePhoto)", method: .POST) else { return }
            WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
                guard data != nil else { return }
                if (error != nil) { print(error.debugDescription) }
                LocalStorage.shared.deleteImage(imageName)
                kSharedUserDefaults.loggedInUserModal.avatar?.clear()
            }
        case 2:
            print("delete cover photo")
            guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.Images.removeCoverPhoto)", method: .POST) else { return }
            WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
                guard data != nil else { return }
                if (error != nil) { print(error.debugDescription) }
                LocalStorage.shared.deleteImage(imageName)
                kSharedUserDefaults.loggedInUserModal.cover?.clear()
            }

        default:
            print("unidentified code")
        }

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

    private func createStringForProducts(_ model: SignUpStepOneDataModel) -> String{

        let filteredSelectedProduct = model.arrOptions.map({$0}).filter({$0.isSelected == true})

        var selectedProductNames: [String] = []
        var selectedProductOptionIds: [String] = []
        var selectedSubProductOptionIds: [String] = []

        for index in 0..<filteredSelectedProduct.count {

            //var selectedProductId: [String] = []
            var selectedSubProductIdLocal: [String] = []

            selectedProductNames.append(String.getString(filteredSelectedProduct[index].optionName))
            selectedProductOptionIds.append(String.getString(filteredSelectedProduct[index].userFieldOptionId))

            let sections = filteredSelectedProduct[index].arrSubSections

            for sectionIndex in 0..<sections.count {

                print("arrSelectedSubOptions",sections[sectionIndex].arrSelectedSubOptions)
                selectedSubProductIdLocal.append(contentsOf: sections[sectionIndex].arrSelectedSubOptions.map({$0}))
            }
            selectedSubProductOptionIds.append(contentsOf: selectedSubProductIdLocal)
        }

        switch filteredSelectedProduct.count {
        case 0:
            print("No Products found")
        case 1:
            model.selectedOptionName = selectedProductNames[0]
        default:
            let remainingProducts = (selectedProductNames.count - 1)
            model.selectedOptionName = selectedProductNames[0] + " & " + String.getString(remainingProducts) + " more"
        }
        print("product",selectedProductOptionIds)
        print("sub product",selectedSubProductOptionIds)

        let mergeArray = (selectedProductOptionIds + selectedSubProductOptionIds).orderedSet
        return mergeArray.filter({ $0 != ""}).joined(separator: ", ")
    }

    private func getFeaturedProductTableCell(_ indexPath: IndexPath) -> UITableViewCell{

//        let tempDict = [String: Any]()

        let featuredProductTableCell = self.tableViewEditProfile.dequeueReusableCell(withIdentifier: FeaturedProductTableCell.identifier(), for: indexPath) as! FeaturedProductTableCell
//        featuredProductTableCell.configureData(withProductCategoriesDataModel: ProductCategoriesDataModel(withDictionary: tempDict))
//        featuredProductTableCell.selectProductDelegate = self
        featuredProductTableCell.featureProductDeletage = self
        if self.signUpViewModel != nil {
            featuredProductTableCell.configureData(withProductCategoriesDataModel: self.signUpViewModel.arrProductCategories[indexPath.section])
        }
        featuredProductTableCell.delegate = self
        return featuredProductTableCell
    }

    private func postRequestToGetFeatureListing(_ featureListingId: String,navigationTitle: String) -> Void{

        self.featureListingId = featureListingId
        self.currentProductTitle = navigationTitle

        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetFeatureListing + featureListingId, method: .GET, controller: self, type: 2, param: [:], btnTapped: UIButton())
    }

    //MARK:  - WebService Methods -

    private func postRequestToUpdateUserProfile() -> Void{

        let compressProfileData = self.imgViewProfile.image!.jpegData(compressionQuality: 0.5)
        let compressedProfileImage = UIImage(data: compressProfileData!)

        let compressCoverData = self.imgViewCoverPhoto.image!.jpegData(compressionQuality: 0.5)
        let compressedCoverImage = UIImage(data: compressCoverData!)
        //
        //    let dict: [String:Any] = ["avatar_id": compressedProfileImage!,
        //                              "cover_id": compressedCoverImage!]
        //
        //    let imageParam:[String:Any] = [APIConstants.kImage: dict,
        //                                   APIConstants.kImageName:APIConstants.kImages]

        //imageParam.

        //imageParam[APIConstants.kImageName:APIConstants.k] =
 
        let dictStepOne = self.signUpViewModel.toDictionaryStepOne()
        var imageParam = [[String:Any]]()

        if self.profilePhoto != nil {
            let imageParamProfile:[String:Any] = [APIConstants.kImage: compressedProfileImage as Any,
                                                  APIConstants.kImageName: "avatar_id"
            ]
            imageParam.append(imageParamProfile)
        }
        if self.coverPhoto != nil {
            let imageParamCover: [String:Any] = [
                APIConstants.kImage : compressedCoverImage as Any,
                APIConstants.kImageName: "cover_id"
            ]
            imageParam.append(imageParamCover)
        }
        //    let dictUserImage : [String:Any] = [
        //        "avatar_id" : compressedProfileImage ?? UIImage(),
        //                         "cover_id" : compressedCoverImage ?? UIImage()
        //    ]
        let mergeDict = dictStepOne.compactMap { $0 }.reduce([:]) { $0.merging($1) { (current, _) in current } }
        disableWindowInteraction()
        CommonUtil.sharedInstance.postToServerRequestMultiPart(APIUrl.kUpdateUserProfile, params: mergeDict, imageParams: imageParam, controller: self) { (dictReponse) in

            guard let data = dictReponse["data"] as? [String: Any] else { return }
            if let coverID = data["cover_id"] as? [String: Any] {
                print(coverID)
                if self.coverPhoto != nil {
                    guard let id = coverID["id"] as? Int, let attachmentURL = coverID["attachment_url"]  as? String else {
                        return
                    }
                    LocalStorage.shared.deleteImage(UserDetailBasedElements().profilePhoto)
                    LocalStorage.shared.saveImage(compressCoverData, fileName: UserDetailBasedElements().coverPhoto)
                    let dict: [String: Any] = ["id": id, "attachment_url": attachmentURL]
                    kSharedUserDefaults.loggedInUserModal.cover = UserModel.cover(dict, for: "coverPhoto-\(kSharedUserDefaults.loggedInUserModal.userId ?? "").jpg")
                }
            } else {
                self.coverPhoto = nil
                LocalStorage.shared.deleteImage(UserDetailBasedElements().profilePhoto)
            }

            if let avatarID = data["avatar_id"] as? [String: Any] {
                if self.profilePhoto != nil {
                    guard let id = avatarID["id"] as? Int, let attachmentURL = avatarID["attachment_url"]  as? String else {
                        return
                    }
                    LocalStorage.shared.deleteImage(UserDetailBasedElements().profilePhoto)
                    LocalStorage.shared.saveImage(compressProfileData, fileName: UserDetailBasedElements().profilePhoto)
                    let dict: [String: Any] = ["id": id, "attachment_url": attachmentURL]
                    kSharedUserDefaults.loggedInUserModal.avatar = UserModel.avatar(dict, for: "profilePhoto-\(kSharedUserDefaults.loggedInUserModal.userId ?? "").jpg")
                }
            } else {
                self.profilePhoto = nil
                LocalStorage.shared.deleteImage(UserDetailBasedElements().profilePhoto)
            }
//            if self.profilePhoto != nil {
////                LocalStorage.shared.saveImage(compressProfileData, fileName: UserDetailBasedElements().profilePhoto)
//                let dict: [String: Any] = ["id": 0, "attachment_url": ""]
//                kSharedUserDefaults.loggedInUserModal.avatar = UserModel.imageAttachementModel(dict, for: "coverPhoto-\(kSharedUserDefaults.loggedInUserModal.userId ?? "").jpg")
//            }

            if self.isCameProfileUpdate == .save{
               // self.showAlert(withMessage: AlertMessage.kProfileUpdated){
                    self.navigationController?.popViewController(animated: true)
                //}
            }else{
                print("Profile Update Done")
            }
            

            //print("Success")
        }
        //CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: mergeDict, url: APIUrl.kUpdateUserProfile, image: imageParam, controller: self, type: 0)
    }
}

//MARK:  - TableView Methods -

extension EditProfileViewC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var extraRows = 1
        if self.userType == .voyagers {
            extraRows = 0
        }
        return (self.signUpViewModel?.arrSignUpStepOne.count ?? 0) + extraRows
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= (self.signUpViewModel?.arrSignUpStepOne.count ?? 0) {
            return getFeaturedProductTableCell(indexPath)
        }
        let model = self.signUpViewModel.arrSignUpStepOne[indexPath.row]
        switch model.type {
        case AppConstants.Checkbox,AppConstants.Multiselect,AppConstants.Select:

            if (model.type == AppConstants.Checkbox) && ((model.multipleOption == true)){
                return self.getSignUpMultiCheckboxTableCell(indexPath)
            }
            else{
                return self.getEditProfileSelectTableCell(indexPath)
            }
        case AppConstants.Text:
            return self.getEditProfileTextViewTableCell(indexPath)
        case AppConstants.Radio:
            return self.getSignUpRadioTableCell(indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row >= (self.signUpViewModel?.arrSignUpStepOne.count ?? 0) {
            return 180.0
        }
        let model = self.signUpViewModel.arrSignUpStepOne[indexPath.row]

        switch model.type {
        case AppConstants.Select:
        
            if kSharedInstance.signUpStepTwoOptionsModel == nil {

                if (((model.isHidden == false) || (model.parentId?.isEmpty == false)) && model.selectedValue != "") {
                   // return 0.0
                    return 115.0
                }
                else{
                    return 0.0
                }
            }
            else{
            
                let parentIdArray = self.signUpViewModel.arrSignUpStepOne.map({$0.parentId})
                var selectedIndex: [Int?] = []
                for i in 0..<kSharedInstance.signUpStepTwoOptionsModel.count{

                    let firstIndex = parentIdArray.firstIndex(where: {$0 == kSharedInstance.signUpStepTwoOptionsModel[i].userFieldOptionId})
                    selectedIndex.append(firstIndex)
                }
                print("indexs",selectedIndex)

                if selectedIndex.contains(indexPath.row) || model.parentId?.isEmpty == true{
                    model.isHidden = false
                    return 115.0
                }
                else{
                    model.isHidden = true
                    return 0.0
                }
            }
        case AppConstants.Multiselect,AppConstants.Checkbox:
            return 80.0
        case AppConstants.Text:
            return 230.0
        case AppConstants.Radio:
            //return 130.0
            return 100.0
        default:
            return 0.0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let model = self.signUpViewModel.arrSignUpStepOne[indexPath.row]

        switch model.type {
        case AppConstants.Checkbox:
            if model.multipleOption == false{
                let controller = pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
                controller?.signUpStepOneDataModel = model
                controller?.stepOneDelegate = self
            }
        case AppConstants.Multiselect:
            let controller = pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
            controller?.signUpStepOneDataModel = model
            controller?.stepOneDelegate = self
        case AppConstants.Select:
            self.openPicker(withArray: model.arrOptions.map({String.getString($0.optionName)}), model: model, keyValue: nil)
        default:
            break
        }
    }
}

//MARK: - ImagePickerViewDelegate Methods -

extension EditProfileViewC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        self.dismiss(animated: true) {

            if self.btnProfilePhoto.isSelected == true{
                self.isProfilePhotoCaptured = true
                self.profilePhoto = selectedImage
                self.imgViewProfile.image = selectedImage
            }
            else if self.btnCoverPhoto.isSelected == true{
                self.isCoverPhotoCaptured = true
                self.coverPhoto = selectedImage
                self.imgViewCoverPhoto.image = selectedImage
            }
        }
    }
}

//APIResponse
extension EditProfileViewC{

    override func didUserGetData(from result: Any, type: Int) -> Void{

        let dicResult = kSharedInstance.getDictionary(result)
        let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])

        switch type {
        case 0:
            //showAlert(withMessage: AlertMessage.kProfileUpdated){
                //self.navigationController?.popViewController(animated: true)
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: ProfileViewC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            //}
        case 1:
            break
        case 2:
            var arrSelectedFields: [ProductFieldsDataModel] = []
            if let fields = dicData[APIConstants.kFields] as? ArrayOfDictionary{
                arrSelectedFields = fields.map({ProductFieldsDataModel(withDictionary: $0)})
            }
           
            //self.postRequestToUpdateUserProfile()
            let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
            controller?.arrSelectedFields = arrSelectedFields
            controller?.featureListingId = self.featureListingId
            controller?.currentNavigationTitle = self.currentProductTitle
            controller?.delegate = self
        default:
            break
        }
    }
}


//RadioCell
extension EditProfileViewC: TappedSwitch{

    func tapSwitch(_ model: SignUpStepTwoDataModel?, _ stepOneModel: SignUpStepOneDataModel?, switchAnswer: UISwitch, btn: UIButton, currentTapType: Int?) {

        switch currentTapType {
        case 0:
            stepOneModel?.selectedValue = (switchAnswer.isOn == true) ?   AppConstants.Yes.capitalized : AppConstants.No
            self.tableViewEditProfile.reloadData()
        case 1:
            showAlert(withMessage: String.getString(stepOneModel?.hint))
        default:
            break
        }
    }
}

//TappedDone
extension EditProfileViewC: TappedDoneStepOne{

    func tapDone(_ signUpStepOneDataModel: SignUpStepOneDataModel) {

        self.signUpStepOneDataModel = nil
        self.signUpStepOneDataModel = signUpStepOneDataModel
        signUpStepOneDataModel.selectedValue = self.createStringForProducts(signUpStepOneDataModel)
        self.navigationController?.popViewController(animated: true)
        self.tableViewEditProfile.reloadData()
    }
}

//CheckboxCell
extension EditProfileViewC: SignUpMultiSelectDelegate{

    func tappedCheckBox(collectionView: UICollectionView, signUpStepTwoOptionsModel: SignUpStepTwoOptionsModel?, signUpStepTwoDataModel: SignUpStepTwoDataModel?, signUpStepOneDataModel: SignUpStepOneDataModel?, btn: UIButton, cell: SignUpMultiCheckboxTableCell) {


        if btn == cell.btnInfo{

            showAlert(withMessage: String.getString(signUpStepTwoDataModel?.hint))
        }
        else{

            signUpStepTwoOptionsModel?.isSelected = (signUpStepTwoOptionsModel?.isSelected == true) ? false : true
            collectionView.reloadData()

            kSharedInstance.signUpStepTwoOptionsModel = signUpStepOneDataModel?.arrRestaurantOptions.filter({$0.isSelected == true})

            var selectedOptionId:[String] = []
            for i in 0..<kSharedInstance.signUpStepTwoOptionsModel.count{
                selectedOptionId.append(String.getString(signUpStepOneDataModel?.arrRestaurantOptions[i].userFieldOptionId))
            }
            signUpStepOneDataModel?.selectedValue = selectedOptionId.joined(separator: ", ")

        }
        self.tableViewEditProfile.reloadData()
    }
}


extension RangeReplaceableCollection where Element: Hashable {

    var orderedSet: Self {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    mutating func removeDuplicates() {
        var set = Set<Element>()
        removeAll { !set.insert($0).inserted }
    }
}


extension EditProfileViewC: AddFeaturedProductCallBack {
    func tappedAddProduct(withProductCategoriesDataModel model: ProductCategoriesDataModel, featureListingId: String?) {

        if featureListingId == nil{
            //self.postRequestToUpdateUserProfile()
            let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
            controller?.productCategoriesDataModel = model
            controller?.delegate = self
        }
        else{
            self.postRequestToGetFeatureListing(String.getString(featureListingId), navigationTitle: String.getString(model.title))
        }
    }
}

extension EditProfileViewC: FeaturedProductCollectionCellProtocol {

    func deleteProduct(_ productID: Int) {

        let alertController = UIAlertController(title: "", message: "Are you surely want to delete this product?", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteProduct("\(APIUrl.FeaturedProduct.delete)\(productID)")
        }

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true)

    }

    private func deleteProduct(_ urlStringWithProductID: String) {
        guard let urlRequest = WebServices.shared.buildURLRequest("\(urlStringWithProductID)", method: .POST) else { return }
        WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
            guard let data = data else { return }
            if (error != nil) { print(error.debugDescription) }
            self.fetchProductsFromProfile()
        }
    }

}
