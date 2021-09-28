//
//  AddProductMarketplaceVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/4/21.
//

import UIKit
import TLPhotoPicker
import DropDown
import YPImagePicker

class AddProductMarketplaceVC: AlysieBaseViewC,TLPhotosPickerViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    //@IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    @IBOutlet weak var view10: UIView!
    @IBOutlet weak var view11: UIView!
    @IBOutlet weak var view12: UIView!
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var showStoreImage: UIImageView!
    @IBOutlet weak var showStoreName: UILabel!
    @IBOutlet weak var txtProductTitle: UITextField!
    @IBOutlet weak var txtProductDesc: UITextView!
    @IBOutlet weak var txtProductKeyWord: UITextField!
    @IBOutlet weak var txtProductCategory: UITextField!
    //@IBOutlet weak var txtProductSubCategory: UITextField!
    @IBOutlet weak var txtProductQuantityAvaliable: UITextField!
    @IBOutlet weak var txtProductBrandLabel: UITextField!
    @IBOutlet weak var txtProductMinOrderQuantity: UITextField!
    @IBOutlet weak var txtProductHandleIns: UITextView!
    @IBOutlet weak var txtProductDispatchIns: UITextView!
    @IBOutlet weak var txtProductSample: UITextField!
    @IBOutlet weak var txtProductPrice: UITextField!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var lblQunatityLabel: UILabel!
    @IBOutlet weak var lblMinimumQuantity: UILabel!
    @IBOutlet weak var lblHeadingLeading: NSLayoutConstraint!
    @IBOutlet weak var btnback: UIButton!
    
    var uploadImageArray = [UIImage]()
    //var selectedAssets = [TLPHAsset]()
    var imagesFromSource = [UIImage]()
    var ypImages = [YPMediaItem]()
    var storeImage = UIImage()
    var storeName: String?
    var arrProductType = [String]()
    var openDropDown: DropDownCheck?
    var productType: [SignUpOptionsDataModel]?
    let dataDropDown = DropDown()
    var productId: Int?
    var subProductId: Int?
    var brandLabelId: Int?
    var marketPlaceStoreId: Int?
    var availableForSample: String?
    var sampleArr = ["Yes","No"]
    var spaceCount = 0
    var quantityArr = ["No. of pieces", "No. of bottles","liters","kilograms","grams","milligrams"]
    var detailStoreImage: String?
    var detailStoreName: String?
    var fromVC: PushedFrom?
    var passEditProductDetail : MyStoreProductDetail?
    // var uploadStoreImage = [String]()
    var marketPlaceProductId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataUI()
        if fromVC == .myStoreDashboard{
            setEditProductDetail()
        }
        if fromVC == .myStoreDashboard{
            self.lblHeadingLeading.constant = 25
            btnback.isHidden = true
        }else {
            self.lblHeadingLeading.constant = 60
            btnback.isHidden = false
        }
        callGetDashboardStoreDetail()
        let tap = UITapGestureRecognizer(target: self, action: #selector(openProductCategory))
        self.view4.addGestureRecognizer(tap)
        //let subTap = UITapGestureRecognizer(target: self, action: #selector(openSubProductCategory))
        //self.view5.addGestureRecognizer(subTap)
        let brandTap = UITapGestureRecognizer(target: self, action: #selector(openBrands))
        self.view7.addGestureRecognizer(brandTap)
        let sampleTap = UITapGestureRecognizer(target: self, action: #selector(openSample))
        self.view11.addGestureRecognizer(sampleTap)
        
        let quantityTap = UITapGestureRecognizer(target: self, action: #selector(openQunatityDropDown))
        self.quantityView.addGestureRecognizer(quantityTap)
        // Do any additional setup after loading the view.
    }
    
    func setDataUI(){
        
        view1.addBorder()
        view2.addBorder()
        view3.addBorder()
        view4.addBorder()
        // view5.addBorder()
        view6.addBorder()
        view7.addBorder()
        view8.addBorder()
        view9.addBorder()
        view10.addBorder()
        view11.addBorder()
        view12.addBorder()
        txtProductHandleIns.delegate = self
        txtProductDispatchIns.delegate = self
        //showStoreImage.image = self.storeImage
        //showStoreName.text = self.storeName
        headerView.drawBottomShadow()
        showStoreImage.layer.cornerRadius = self.showStoreImage.frame.height / 2
        
    }
    func setEditProductDetail(){
        self.txtProductTitle.text = self.passEditProductDetail?.title
        self.txtProductDesc.text = self.passEditProductDetail?.description
        self.txtProductKeyWord.text = self.passEditProductDetail?.keywords
        self.txtProductCategory.text = self.passEditProductDetail?.product_Name
        self.txtProductPrice.text = self.passEditProductDetail?.product_price
        self.txtProductQuantityAvaliable.text = "\(self.passEditProductDetail?.quantity_available ?? 0)"
        self.txtProductBrandLabel.text = self.passEditProductDetail?.labels?.name
        self.txtProductMinOrderQuantity.text = self.passEditProductDetail?.min_order_quantity
        self.txtProductHandleIns.text = self.passEditProductDetail?.handling_instruction
        self.txtProductDispatchIns.text = self.passEditProductDetail?.dispatch_instruction
        self.txtProductSample.text = self.passEditProductDetail?.available_for_sample
        self.productId = self.passEditProductDetail?.product_category_id
        self.subProductId = self.passEditProductDetail?.product_subcategory_id
        for img in 0..<(self.passEditProductDetail?.product_gallery?.count ?? 0) {
            let urlString = kImageBaseUrl + "\(String.getString(self.passEditProductDetail?.product_gallery?[img].attachment_url))"
            do {
                let imageData = try Data(contentsOf: URL(string: urlString)!)
                if let image = UIImage(data: imageData) {
                    self.imagesFromSource.append(image)
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        print("ImageFromSourceData------------------------\(self.imagesFromSource)")
        collectionViewImage.reloadData()
    }
    
    private func alertToAddCustomPicker() -> Void {
        //        let viewCon = TLPhotosPickerViewController()
        //        viewCon.delegate = self
        //        viewCon.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
        //            self?.showExceededMaximumAlert(vc: picker)
        //        }
        //        var configure = TLPhotosPickerConfigure()
        //        configure.allowedVideoRecording = false
        //
        //        configure.mediaType = .image
        //        configure.numberOfColumn = 3
        //
        //        viewCon.configure = configure
        //        viewCon.selectedAssets = self.selectedAssets
        //        viewCon.logDelegate = self
        //
        //        self.present(viewCon, animated: true, completion: nil)
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 100000
        config.showsPhotoFilters = false
        
        config.library.preselectedItems = ypImages
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            self.ypImages = items
            for item in items {
                switch item {
                case .photo(let photo):
                    self.imagesFromSource.append(photo.originalImage ?? photo.image)
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            self.collectionViewImage.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        // use selected order, fullresolution image
        //print("dismiss")
        //self.selectedAssets = withTLPHAssets
        
        //print("selectedAssest-----------------\(self.selectedAssets)")
        
        self.collectionViewImage.reloadData()
        self.btnScroll()
        
        //iCloud or video
        //        getAsyncCopyTemporaryFile()
    }
    
    func photoPickerDidCancel() {
        // cancel
        print("cancel")
    }
    func showExceededMaximumAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "", message: "Exceed Maximum Number Of Selection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    @objc func openProductCategory(){
        openDropDown = .productType
        callProductCategory()
    }
    @objc func openSubProductCategory(){
        openDropDown = .productCategoryType
        callSubProductCategory()
    }
    @objc func openBrands(){
        openDropDown = .brandLabel
        callBrandCategory()
    }
    
    @objc func openSample(){
        openDropDown = .availableForSample
        self.dataDropDown.dataSource = self.sampleArr
        self.opendropDown()
        
    }
    func opendropDown(){
        dataDropDown.show()
        if openDropDown == .productType{
            dataDropDown.anchorView = view4
        }else if openDropDown == .productCategoryType{
            // dataDropDown.anchorView = view5
        }else if openDropDown == .brandLabel{
            dataDropDown.anchorView = view7
        }else if openDropDown == .availableForSample{
            dataDropDown.anchorView = view11
        }
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if openDropDown == .productType{
                self.txtProductCategory.text = item
                self.productId = productType?[index].marketplaceProductCategoryId
            }else if openDropDown == .productCategoryType{
                // self.txtProductSubCategory.text = item
                self.subProductId = productType?[index].marketplaceProductSubcategoryId
            }else if openDropDown == .brandLabel{
                self.txtProductBrandLabel.text = item
                self.brandLabelId = productType?[index].marketplaceBrandLabelId
            }else if openDropDown == .availableForSample{
                self.txtProductSample.text = item
            }
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    @objc func openQunatityDropDown(){
        dataDropDown.dataSource = self.quantityArr
        dataDropDown.show()
        dataDropDown.anchorView = quantityView
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblQunatityLabel.text = item
            self.lblMinimumQuantity.text = item
            
            
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    //MARK:- IBAction
    
    @IBAction func btnNextAction(_ sender: UIButton){
        
        let quantityAvailable = Int(self.txtProductQuantityAvaliable.text ?? "0") ?? 0
        let minOrderQuantity = Int(self.txtProductMinOrderQuantity.text ?? "0") ?? 0
        
        if minOrderQuantity > quantityAvailable{
            self.showAlert(withMessage: "Minimum Order quantity should be less or equal to quantity Available")
        }else{
            if fromVC == .myStoreDashboard{
                self.UpdateProductApi()
            }else{
                self.addProductApi()
            }
        }
        // _ = pushViewController(withName: MarketPlaceConfirmationVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCheckInfoAction(_ sender: UIButton){
        
        switch sender.tag {
        case 0:
            showInfo("Helps user to find product")
            print("0")
        case 1:
            showInfo("Handling Instruction can contains max 50 words")
            print("1")
        case 2:
            showInfo("Dispatch Instruction can contains max 200 words")
            print("2")
            
        default:
            break
        }
    }
    func showInfo(_ message: String){
        self.showAlert(withMessage: message)
    }
    
}
//MARK:- Custom Picker
extension AddProductMarketplaceVC: TLPhotosPickerLogDelegate {
    //For Log User Interaction
    func selectedCameraCell(picker: TLPhotosPickerViewController) {
        print("selectedCameraCell")
    }
    
    func selectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("selectedPhoto")
        print(picker.selectedAssets.count)
        //self.collectionViewImage.reloadData()
        // let image = picker.selectedAssets[at]
        //  print(image)
    }
    
    func deselectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("deselectedPhoto")
        // self.collectionViewImage.reloadData()
    }
    
    func selectedAlbum(picker: TLPhotosPickerViewController, title: String, at: Int) {
        print("selectedAlbum")
    }
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        self.showExceededMaximumAlert(vc: picker)
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        picker.dismiss(animated: true) {
            let alert = UIAlertController(title: "", message: "Denied albums permissions granted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        let alert = UIAlertController(title: "", message: "Denied camera permissions granted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        picker.present(alert, animated: true, completion: nil)
    }
    
    func showUnsatisifiedSizeAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Oups!", message: "The required size is: 300 x 300", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
extension AddProductMarketplaceVC: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == txtProductDispatchIns{
            
            let spaceCount = textView.text.filter{$0 == " "}.count
            if spaceCount <= 200{
                return true
            }else{
                return false
            }
        }else if textView == txtProductHandleIns{
            let spaceCount = textView.text.filter{$0 == " "}.count
            if spaceCount <= 50{
                return true
            }else{
                return false
            }
        }
        return true
        
    }
    
}
extension AddProductMarketplaceVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fromVC == .myStoreDashboard{
            return (imagesFromSource.count ) + 1
        }else{
            if self.imagesFromSource.count == 0{
                return 1
            }else{
                print("count-------------\(self.imagesFromSource.count)")
                return imagesFromSource.count + 1
                //return uploadImageArray.count + 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageMaketPlaceCollectionViewCell", for: indexPath) as? ImageMaketPlaceCollectionViewCell else {return UICollectionViewCell()}
        
        if fromVC == .myStoreDashboard {
            if indexPath.row < imagesFromSource.count {
                cell.viewAddImage.isHidden = true
                cell.btnDelete.isHidden = false
                self.uploadImageArray = [UIImage]()
                //print("ShowImage------------------------------------\(uploadImageArray[indexPath.row])")
                // cell.image.image = imagesFromSource[indexPath.row]
                for image in 0..<self.imagesFromSource.count {
                    
                    let asset = self.imagesFromSource[image]
                    //                            let image = asset.fullResolutionImage ?? UIImage()
                    self.uploadImageArray.append(asset)
                    
                }
                cell.image.image = uploadImageArray[indexPath.row]
                //cell.image.setImage(withString: kImageBaseUrl + "\(imagesFromSource[indexPath.row])")
                
            }else{
                cell.viewAddImage.isHidden = false
                cell.btnDelete.isHidden = true
            }
        }else{
            if imagesFromSource.count == 0{
                cell.viewAddImage.isHidden = false
                cell.btnDelete.isHidden = true
            }else {
                
                if indexPath.row < imagesFromSource.count{
                    cell.viewAddImage.isHidden = true
                    cell.btnDelete.isHidden = false
                    self.uploadImageArray = [UIImage]()
                    for image in 0..<self.imagesFromSource.count {
                        
                        let asset = self.imagesFromSource[image]
                        //let image = asset.fullResolutionImage ?? UIImage()
                        self.uploadImageArray.append(asset)
                        
                    }
                    cell.image.image = uploadImageArray[indexPath.row]
                    
                }else{
                    
                    cell.viewAddImage.isHidden = false
                    cell.btnDelete.isHidden = true
                    
                }
            }
        }
        cell.btnDelete.tag = indexPath.row
        cell.btnDeleteCallback = { tag in
            //                if self.fromVC == .myStoreDashboard{
            //                    self.imagesFromSource.remove(at: tag)
            //                }else{
            //                self.imagesFromSource.remove(at: tag)
            //                }
            self.imagesFromSource.remove(at: tag)
            if self.fromVC == .myStoreDashboard{
            print("marketplace_product_gallery_id----------------------------\(self.passEditProductDetail?.product_gallery?[tag].marketplace_product_gallery_id ?? 0)")
            self.removeGalleryPic(self.passEditProductDetail?.product_gallery?[tag].marketplace_product_gallery_id)
            }
            //self.uploadImageArray.remove(at: tag)
            self.collectionViewImage.reloadData()
        }
        //return cell
        
        return cell
    }
    
    func btnScroll() {
        collectionViewImage.scrollToItem(at: IndexPath(item: self.imagesFromSource.count, section: 0), at: UICollectionView.ScrollPosition.right, animated:true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if fromVC == .myStoreDashboard{
            return CGSize(width: collectionView.bounds.width / 3, height: 200)
        }else if self.imagesFromSource.count == 0{
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

extension AddProductMarketplaceVC{
    func callProductCategory(){
        self.arrProductType.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProducttCategory, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.productType = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
                print("Count ------------------------------\(self.productType?.count ??  0)")
                for product in 0..<(self.productType?.count ?? 0) {
                    self.arrProductType.append(self.productType?[product].name ?? "")
                }
                self.dataDropDown.dataSource = self.arrProductType
                self.opendropDown()
                
            }
        }
        
    }
    func callSubProductCategory(){
        self.arrProductType.removeAll()
        self.productType = [SignUpOptionsDataModel]()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSubProductCategoryId + "\(self.productId ?? 0)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.productType = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
                print("Count ------------------------------\(self.productType?.count ??  0)")
                for product in 0..<(self.productType?.count ?? 0) {
                    self.arrProductType.append(self.productType?[product].name ?? "")
                }
                self.dataDropDown.dataSource = self.arrProductType
                self.opendropDown()
                
            }
        }
        
    }
    func callBrandCategory(){
        self.arrProductType.removeAll()
        self.productType = [SignUpOptionsDataModel]()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kBrandLabel, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.productType = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
                print("Count ------------------------------\(self.productType?.count ??  0)")
                for product in 0..<(self.productType?.count ?? 0) {
                    self.arrProductType.append(self.productType?[product].name ?? "")
                }
                self.dataDropDown.dataSource = self.arrProductType
                self.opendropDown()
                
            }
        }
        
    }
    func addProductApi(){
        let params: [String:Any] = [
            APIConstants.kmarketplaceStoreId: "\(self.marketPlaceStoreId ?? 0)",
            APIConstants.kTitle: self.txtProductTitle.text ?? "",
            APIConstants.kDescription: self.txtProductDesc.text ?? "",
            APIConstants.kKeywords: self.txtProductKeyWord.text ?? "",
            APIConstants.kProductCategoryId : "\(self.productId ?? 0)",
            APIConstants.kProductSubCategoryId: "\(self.subProductId ?? 0)",
            APIConstants.kQuantityAvailable: self.txtProductQuantityAvaliable.text ?? "",
            APIConstants.kbrandLabelId: "\(self.brandLabelId ?? 0)",
            APIConstants.kMinOrderQuantity: self.txtProductMinOrderQuantity.text ?? "",
            APIConstants.kHandlingInstruction: self.txtProductHandleIns.text ?? "",
            APIConstants.kDispatchInstruction: self.txtProductDispatchIns.text ?? "",
            APIConstants.kAvailableForSample: self.txtProductSample.text ?? "",
            APIConstants.kProductPrice: self.txtProductPrice.text ?? ""
        ]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray,
                                         APIConstants.kImageName: "gallery_images[]"]
        
        
        print("ImageParam------------------------------\(imageParam)")
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kSaveProduct, image: imageParam, controller: self, imageGroupName: "gallery_images[]", type: 0)
    }
    func UpdateProductApi(){
        let params: [String:Any] = [
            APIConstants.kMarketPlaceProduct_id: "\(self.marketPlaceProductId ?? "0")",
            APIConstants.kTitle: self.txtProductTitle.text ?? "",
            APIConstants.kDescription: self.txtProductDesc.text ?? "",
            APIConstants.kKeywords: self.txtProductKeyWord.text ?? "",
            APIConstants.kProductCategoryId : "\(self.productId ?? 0)",
            APIConstants.kProductSubCategoryId: "\(self.subProductId ?? 0)",
            APIConstants.kQuantityAvailable: self.txtProductQuantityAvaliable.text ?? "",
            APIConstants.kbrandLabelId: "\(self.brandLabelId ?? 0)",
            APIConstants.kMinOrderQuantity: self.txtProductMinOrderQuantity.text ?? "",
            APIConstants.kHandlingInstruction: self.txtProductHandleIns.text ?? "",
            APIConstants.kDispatchInstruction: self.txtProductDispatchIns.text ?? "",
            APIConstants.kAvailableForSample: self.txtProductSample.text ?? "",
            APIConstants.kProductPrice: self.txtProductPrice.text ?? ""
        ]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray,
                                         APIConstants.kImageName: "gallery_images[]"]
        
        
        print("ImageParam------------------------------\(imageParam)")
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kUpdateProductApi, image: imageParam, controller: self, imageGroupName: "gallery_images[]", type: 0)
    }
    func callGetDashboardStoreDetail(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetStoreDetails, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"] as? [String:Any]{
                // self.storeImage = data["logo_id"] as? String
                self.detailStoreImage = data["logo_id"] as? String
                self.detailStoreName = data["name"] as? String
                self.imgStore.setImage(withString: kImageBaseUrl + String.getString(self.detailStoreImage))
                self.showStoreName.text = self.detailStoreName
                self.marketPlaceStoreId = data["marketplace_store_id"] as?Int
                self.setDataUI()
            }
            
        }
    }
        
        func removeGalleryPic(_ galleryPicId: Int?){
            
            let params: [String:Any] = [
                "gallery_type": "2",
                "marketplace_product_gallery_id": galleryPicId ?? 0
            ]
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kDeleteGalleryPic, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errortype, statuscode) in
                
                print("Image Deleted")
            }
        }
    
    //    func addProductApi(){
    //        let params: [String:Any] = [
    //            APIConstants.kmarketplaceStoreId: "\(self.marketPlaceStoreId ?? 0)",
    //            APIConstants.kTitle: self.txtProductTitle.text ?? "",
    //            APIConstants.kDescription: self.txtProductDesc.text ?? "",
    //            APIConstants.kKeywords: self.txtProductKeyWord.text ?? "",
    //            APIConstants.kProductCategoryId : "\(self.productId ?? 0)",
    //            APIConstants.kProductSubCategoryId: "\(self.subProductId ?? 0)",
    //            APIConstants.kQuantityAvailable: self.txtProductQuantityAvaliable.text ?? "",
    //            APIConstants.kbrandLabelId: "\(self.brandLabelId ?? 0)",
    //            APIConstants.kMinOrderQuantity: self.txtProductMinOrderQuantity.text ?? "",
    //            APIConstants.kHandlingInstruction: self.txtProductHandleIns.text ?? "",
    //            APIConstants.kDispatchInstruction: self.txtProductDispatchIns.text ?? "",
    //            APIConstants.kAvailableForSample: self.txtProductSample.text ?? "",
    //            APIConstants.kProductPrice: self.txtProductPrice.text ?? ""
    //        ]
    //
    //        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray,
    //                                         APIConstants.kImageName: "gallery_images"]
    //
    //
    //        print("ImageParam------------------------------\(imageParam)")
    //        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kSaveProduct, image: imageParam, controller: self, type: 0)
    //    }
    
    override func didUserGetData(from result: Any, type: Int) {
        //        self.showAlert(withMessage: "Post Successfully") {
        //        }
        kSharedUserDefaults.setValue("1", forKey: "is_store_created")
        self.uploadImageArray = [UIImage]()
        self.imagesFromSource.removeAll()
        self.uploadImageArray.removeAll()
        self.collectionViewImage.reloadData()
        if fromVC == .myStoreDashboard{
            self.navigationController?.popViewController(animated: true)
        }else{
            if fromVC == .addProduct{
                self.navigationController?.popViewController(animated: true)
            }else{
                _ = pushViewController(withName: MarketPlaceConfirmationVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
            }
        }
        
    }
}

