//
//  AddMissingIngridientViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 20/08/21.
//

import UIKit

class AddMissingIngridientViewController: AlysieBaseViewC {

    @IBOutlet weak var newIngridentsImageView: UIImageView!
    @IBOutlet weak var newIngridientNameTextField: UITextField!
    @IBOutlet weak var selectIngridientCategoryView: UIView!
    @IBOutlet weak var selectIngridientCategoryLabel: UILabel!
    
    @IBOutlet weak var addIngridientToRecipeBtn: UIButton!

    var picker = UIImagePickerController()
    var selectedImage: String?
    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strSelectedId: Int?
    var arraySelectedImg = NSMutableArray()
    var str_return : String = String ()
    var arrCategory = NSMutableArray()
    var newSearchModel: [AddIngridientDataModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callSelectIngridientsCategory()
        self.setUI()
        picker1.delegate = self
        picker1.dataSource = self
       

        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

//        sele.addDashBorder()
    }
    

    func setUI(){
        
        self.selectIngridientCategoryView.layer.cornerRadius = 5
        self.selectIngridientCategoryView.layer.borderWidth = 1
        self.selectIngridientCategoryView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        self.addIngridientToRecipeBtn.layer.cornerRadius = 5
    }
    
    func setPickerToolbar(){
        
        picker1.backgroundColor = UIColor.white
        picker1.backgroundColor = UIColor.white
        picker1.setValue(UIColor.black, forKey: "textColor")
        picker1.autoresizingMask = .flexibleWidth
        picker1.contentMode = .center
        picker1.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 230)
        self.view.addSubview(picker1)
        picker1.reloadAllComponents()

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 40))
        toolBar.barTintColor = AppColors.mediumBlue.color
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
       let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onDoneButtonTapped))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    
       let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onCancelButtonTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        self.view.addSubview(toolBar)
        
            }
    
    @objc func onDoneButtonTapped() {
        self.selectIngridientCategoryLabel.text = self.str_return
        self.selectIngridientCategoryLabel.textColor = .black
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
    }
    
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
       }
    
    @IBAction func tapcrrossIngridients(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func tapToUploadIngridientPhoto(_ sender: Any) {
        
        self.alertToAddImage()
    }
    @IBAction func tapForSelectNewIngridientCategory(_ sender: Any) {
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func tapForAddIngridientToRecipe(_ sender: Any) {
        self.validation()

        postRequestToAddNewIngridient()
    }
    
    
    func validation(){
        if self.newIngridentsImageView.image == nil{
                 showAlert(withMessage: AlertMessage.kUploadImage)
               }
        else if String.getString(newIngridientNameTextField.text).isEmpty == true{
            showAlert(withMessage: AlertMessage.kEnterIngridientName)
        }
        else if String.getString(selectIngridientCategoryLabel.text) == LabelandTextFieldTitle.selectCategory{
            showAlert(withMessage: AlertMessage.kSelectCategory)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
        
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
        self.showAlert(withMessage: AlertMessage.kImagepicker )
      }
    }
    
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    
}

//MARK: - ImagePickerViewDelegate Methods -

extension AddMissingIngridientViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    self.dismiss(animated: true) {
        
            self.newIngridentsImageView.contentMode = .scaleToFill
        let scaledImage:UIImage = self.resizeImage(image: selectedImage, newWidth: self.view.frame.width)
             self.newIngridentsImageView.image = scaledImage
        guard let imgData2 = self.newIngridentsImageView.image!.pngData() else { return }
        let base64String2 = imgData2.base64EncodedString(options: .lineLength64Characters)
        let dict = ["image_id" : base64String2]

        self.arraySelectedImg.add(dict)

    }
  }
}

extension AddMissingIngridientViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       
        return self.newSearchModel?.count ?? 0
    
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let stName = self.newSearchModel?[row].ingridientDataName
         {
             str_return = stName
         }
        return str_return
    }
    
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
             if let stId = self.newSearchModel?[row].ingridientId
             {
                 self.strSelectedId = stId
             }
             if let stName = self.newSearchModel?[row].ingridientDataName
             {
                 self.str_return = stName
             }
        
    }
}
extension AddMissingIngridientViewController{
    
    func callSelectIngridientsCategory(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeIngridents, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
       
            let dictResponse = dictResponse as? [String:Any]
            
                if let data = dictResponse?["data"] as? [[String:Any]]{
                    self.newSearchModel = data.map({AddIngridientDataModel.init(with: $0)})
                    self.picker1.reloadAllComponents()
            }
        }
    }
    
    func postRequestToAddNewIngridient(){
        
        let params: [String:Any] = [APIConstants.kTitle: self.newIngridientNameTextField.text ?? "", APIConstants.kImage: self.arraySelectedImg , APIConstants.kCategory: self.strSelectedId ?? "0"]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.addNewIngridient, requestMethod: .POST, requestParameters: params, withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
            
             let resultNew = dictResponse as? [String:Any]
            if let message = resultNew!["message"] as? String{
                self.showAlert(withMessage: message)
            }
            
       


//            let controller = self.pushViewController(withName: AddIngredientsViewController.id(), fromStoryboard: StoryBoardConstants.kRecipesSelection) as? AddIngredientsViewController
//            controller?.addIngridientsTableView.reloadData()
//            controller?.addMissingIngridientsTableView.reloadData()
//            controller?.storeName = self.txtStoreName.text
//            controller?.marketPlaceStoreId = self.marketPlaceId
        }
    }
    
}
