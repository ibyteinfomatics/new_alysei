//
//  AddFeatureViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

protocol AddFeaturedProductCallBack {
  
  func productAdded() -> Void
}

class AddFeatureViewC: AlysieBaseViewC {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var tblViewAddFeature: UITableView!
  @IBOutlet weak var viewNavigation: UIView!
  @IBOutlet weak var imgViewProduct: UIImageView!
  @IBOutlet weak var btnUploadImage: UIButton!
  @IBOutlet weak var lblNavigationHeading: UILabel!
  
  //MARK: - Properties -

  var productCategoriesDataModel: ProductCategoriesDataModel!
  var arrSelectedFields: [ProductFieldsDataModel] = []
  var featureListingId: String?
  var currentNavigationTitle: String?
  var delegate: AddFeaturedProductCallBack?
  var picker = UIImagePickerController()

  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.initialImageSetUp()
  }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.delegate?.productAdded()
//        self.navigationController?.popViewController(animated: true)

    }
  
  override func viewDidLayoutSubviews(){
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapClose(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapUpload(_ sender: UIButton) {
    
    let currentArray = (arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields : self.arrSelectedFields
    //currentArray[0].productTitle
    
         if imgViewProduct.image == nil{
          showAlert(withMessage: AlertMessage.kUploadImage)
            return
        }
    for i in 1..<(currentArray.count ){
        if (currentArray[i].selectedValue == "" && currentArray[i].required == AppConstants.Yes){
            showAlert(withMessage: "\(currentArray[i].productTitle ?? "") is required")
            return
        }
        else if imgViewProduct.image == nil{
          showAlert(withMessage: AlertMessage.kUploadImage)
            return
        }
    }
    self.postRequestToAddProduct()

//    let tuple = self.validateFields(currentArray)
//    if tuple.0 == false{
//
//     //showAlert(withMessage: tuple.1)
//        showAlert(withMessage: "\(currentArray[Int.getInt(tuple.1)].productTitle ?? "") is required")
//    }
//    else if imgViewProduct.image == nil{
//      showAlert(withMessage: AlertMessage.kUploadImage)
//    }
//    else{
//      self.postRequestToAddProduct()
//    }
  }
  
  @IBAction func tapUploadImage(_ sender: UIButton) {
    
    self.alertToAddImage()
  }
  
  //MARK: - Private Methods -
  
  private func openPicker(model: ProductFieldsDataModel,keyValue keyVal: String?) -> Void {
    
    let arrOptionNames = model.arrOptions.map({String.getString($0.optionName)})
    let arrOptionId = model.arrOptions.map({String.getString($0.featuredListingOptionId)})
    
    let picker = RSPickerView.init(view: self.view, arrayList: arrOptionNames, keyValue: keyVal, prevSelectedValue: 0, handler: {(selectedIndex: NSInteger, response: Any?) in
      
      if let strVal = response as? String{
        let selectedOptionId = arrOptionId[selectedIndex]
        model.selectedValue = selectedOptionId
        model.selectedOptionName = strVal
        self.tblViewAddFeature.reloadData()
        print("selectedValue",strVal.uppercased())
      }})
    picker.viewContainer.backgroundColor = UIColor.white
  }
  
  private func openDatePicker(_ model: ProductFieldsDataModel) -> Void {
    
    self.view.endEditing(true)
    let picker = RSDatePicker.init(view: self.view, pickerMode: .dateAndTime, handler: { (response: Any?) in
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
      if let date = response as? Date{
        
        model.selectedValue = Date.getLocalDateFromUTC(date: date).stringWithFormat(format: "yyyy-MM-dd HH:mm")
        self.tblViewAddFeature.reloadData()
        print("date",date)
      }})
    picker.setMinimumDate(date: Date.getLocalDateFromUTC(date: getCurrentDate()))
    picker.viewContainer.backgroundColor = UIColor.white
  }
    
  private func getAddFeatureCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let addFeatureTableCell = tblViewAddFeature.dequeueReusableCell(withIdentifier: AddFeatureTableCell.identifier() , for: indexPath) as! AddFeatureTableCell
    let model = (self.arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields[indexPath.row] : self.arrSelectedFields[indexPath.row]
    addFeatureTableCell.configure(withProductFieldsDataModel: model)
    return addFeatureTableCell
  }
  
  private func alertToAddImage() -> Void {
    
    let alert:UIAlertController = UIAlertController(title: AlertMessage.kSourceType, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    let cameraAction = UIAlertAction(title: AlertMessage.kTakePhoto, style: UIAlertAction.Style.default){
      UIAlertAction in
      self.showImagePicker(withSourceType: .camera, mediaType: .image)
    }
    let galleryAction = UIAlertAction(title: AlertMessage.kChooseLibrary, style: UIAlertAction.Style.default){
      UIAlertAction in
      self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
    }
    let cancelAction = UIAlertAction(title: AlertMessage.kCancel, style: UIAlertAction.Style.cancel){
      UIAlertAction in
    }
    alert.addAction(cameraAction)
    alert.addAction(galleryAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
  }
  
  private func showImagePicker(withSourceType type: UIImagePickerController.SourceType,mediaType: MediaType) -> Void {
    
    if UIImagePickerController.isSourceTypeAvailable(type){
      
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
  
  private func initialImageSetUp() -> Void{
    
    if arrSelectedFields.count != 0{
      
      let filter = self.arrSelectedFields.map({$0}).filter({$0.type == AppConstants.File})
      self.imgViewProduct.setImage(withString: kImageBaseUrl + String.getString(filter.first?.selectedValue))
      self.lblNavigationHeading.text = AppConstants.Add + String.getString(self.currentNavigationTitle)
    }
    else{
      self.lblNavigationHeading.text = AppConstants.Add + String.getString(self.productCategoriesDataModel.title)
    }

  }
  
  private func validateFields(_ currentArray: [ProductFieldsDataModel]) -> (Bool,String){
  
    for item in currentArray{
      if item.type != AppConstants.File{
//        if (item.selectedValue?.isEmpty == true){
        if ((item.required ?? "").lowercased() == "yes")  && (item.selectedValue?.isEmpty == true) {
          return(false,"All Information is required")
        }
      }
    }
    return (true,"")
  }
  
  func toDictionaryAddProduct() -> [[String:Any]]{
  
     let currentArray = (arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields : self.arrSelectedFields
    
     var dicSignUp: [[String:Any]] = [[APIConstants.kFeaturedListingTypeId:String.getString(currentArray[0].featuredListingTypeId)]]
    
     if featureListingId != nil{
      
      dicSignUp.append([APIConstants.kFeaturedListingId: String.getString(self.featureListingId)])

     }
    
     for i in 0..<currentArray.count{
  
        if currentArray[i].type != AppConstants.File{
  
          dicSignUp.append([String.getString(currentArray[i].featuredListingFieldId): currentArray[i].selectedValue as Any])
        }
      }
      print(dicSignUp)
      return dicSignUp
  }
  
  //MARK: - WebService Methods -
  
  private func postRequestToAddProduct() -> Void{

    let dictProduct = self.toDictionaryAddProduct()

    let compressData = self.imgViewProduct.image!.jpegData(compressionQuality: 0.5)
    let compressedImage = UIImage(data: compressData!)

    let currentArray = (arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields : self.arrSelectedFields
    let model = currentArray.filter({$0.type == AppConstants.File})
    let imageParam:[String:Any] = [APIConstants.kImage: compressedImage as Any,
                                   APIConstants.kImageName:String.getString(model.first?.featuredListingFieldId)]

    let mergeDict = dictProduct.compactMap { $0 }.reduce([:]) { $0.merging($1) { (current, _) in current } }
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: mergeDict, url: APIUrl.kAddFeaturedProducts, image: imageParam, controller: self, type: 0)
  }
}

//MARK: - ImagePickerViewDelegate Methods -

extension AddFeatureViewC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    self.dismiss(animated: true) {
      
      self.imgViewProduct.image = selectedImage

    }
  }
}

//MARK: - TableView Methods -

extension AddFeatureViewC: UITableViewDataSource, UITableViewDelegate{
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return (self.arrSelectedFields.count == 0) ? self.productCategoriesDataModel?.arrProductFields.count ?? 0 : self.arrSelectedFields.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let model = (self.arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields[indexPath.row] : self.arrSelectedFields[indexPath.row]
    return (model.type != AppConstants.File) ? self.getAddFeatureCell(indexPath) : UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let model = (self.arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields[indexPath.row] : self.arrSelectedFields[indexPath.row]
    
    switch model.type {
    case AppConstants.Calander:
      self.openDatePicker(model)
    case AppConstants.Select:
      self.openPicker(model: model, keyValue: nil)
    default:
      break
    }
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let model = (self.arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields[indexPath.row] : self.arrSelectedFields[indexPath.row]
    
//    if String.getString(model.selectedValue).count < 20{
//
//      return (model.type != AppConstants.File) ? 100.0 : 0.0
//    }
   // else{
    return (model.type != AppConstants.File) ? 100.0 : 0.0
    //}
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let model = (self.arrSelectedFields.count == 0) ? self.productCategoriesDataModel.arrProductFields[indexPath.row] : self.arrSelectedFields[indexPath.row]
    return (model.type != AppConstants.File) ? 140.0 : 0.0
  }
}

extension AddFeatureViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    self.delegate?.productAdded()
    self.navigationController?.popViewController(animated: true)
  }
}
