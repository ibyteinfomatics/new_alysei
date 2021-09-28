//
//  AddMissingToolViewController.swift
//  Alysei
//
//  Created by namrata upadhyay on 20/08/21.
//

import UIKit

class AddMissingToolViewController: UIViewController {
    
    @IBOutlet weak var newToolImageView: UIImageView!
    @IBOutlet weak var newToolNameTextField: UITextField!
    @IBOutlet weak var selectToolCategoryView: UIView!
    @IBOutlet weak var selectToolCategoryLabel: UILabel!
    @IBOutlet weak var addToolToRecipeBtn: UIButton!

  
    var picker = UIImagePickerController()
    var selectedImage = String()
    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strSelectedId = String()
    var str_return : String = String ()
    var arrCategory = NSMutableArray()
    var newSearchModel: [AddToolsDataModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        callAddNewTools()
        picker1.delegate = self
        picker1.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

//        sele.addDashBorder()
    }
    
    func setUI(){
        
        self.addToolToRecipeBtn.layer.cornerRadius = 5
        self.selectToolCategoryView.layer.borderWidth = 1
        self.selectToolCategoryView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        self.selectToolCategoryView.layer.cornerRadius = 5
    }
    
    func setPickerToolbar(){
        
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
    
       let cancelButton = UIBarButtonItem(title: "Cancle", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onCancelButtonTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        self.view.addSubview(toolBar)
        
            }
    
    @objc func onDoneButtonTapped() {
        self.selectToolCategoryLabel.text = self.str_return
        self.selectToolCategoryLabel.textColor = .black
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
    }
    
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
       }
    
    
    @IBAction func tapcrrossTool(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func tapToUploadToolPhoto(_ sender: Any) {
        
        self.alertToAddImage()
    }
    
    @IBAction func tapForSelectNewToolCategory(_ sender: Any) {
        
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func tapForAddToolToRecipe(_ sender: Any) {
        self.validation()
    }
    
    
    func validation(){
        if self.newToolImageView.image == nil{
                 showAlert(withMessage: AlertMessage.kUploadImage)
               }
        else if String.getString(newToolNameTextField.text).isEmpty == true{
            showAlert(withMessage: AlertMessage.kEnterToolName)
        }
        else if String.getString(selectToolCategoryLabel.text) == LabelandTextFieldTitle.selectCategory{
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

extension AddMissingToolViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    self.dismiss(animated: true) {
        
            self.newToolImageView.contentMode = .scaleToFill
        let scaledImage:UIImage = self.resizeImage(image: selectedImage, newWidth: self.view.frame.width)
             self.newToolImageView.image = scaledImage

    }
  }
}

extension AddMissingToolViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       
        return self.newSearchModel?.count ?? 0
    
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let stName = self.newSearchModel?[row].toolDataName
         {
             str_return = stName
         }
        return str_return
    }
    
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let stId = self.newSearchModel?[row].toolId
        {
            self.strSelectedId = String(stId)
        }
        if let stName = self.newSearchModel?[row].toolDataName
        {
            self.str_return = stName
        }
        
    }
}
extension AddMissingToolViewController{
    
    func callAddNewTools(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeTools, requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ (dictResponse, error, errorType, statusCode) in
       
            let dictResponse = dictResponse as? [String:Any]
            

                if let data = dictResponse?["data"] as? [[String:Any]]{
                    self.newSearchModel = data.map({AddToolsDataModel.init(with: $0)})
                    self.picker1.reloadAllComponents()


            }
        }
    }
}
