//
//  CreateBlogViewController.swift
//  Profile Screen
//
//  Created by mac on 02/09/21.
//

import UIKit
import Photos
import YPImagePicker

class CreateBlogViewController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate   {
    @IBOutlet weak var switchBar: UISwitch!
    @IBOutlet weak var draftView: UIView!
    @IBOutlet weak var draftLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var blogView: UIView!
    @IBOutlet weak var blogView1: UIView!
    @IBOutlet weak var blogTxf: UITextField!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionView1: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cameraText: UILabel!
    @IBOutlet weak var cameraIcon: UIImageView!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var headerText: UILabel!
    var blogtitle,fulldescription,imgurl,baseUrl,draft:String?
    var blo_id: Int?
    var typeofpage: String?
    
    // camera image
    var ypImages = [YPMediaItem]()
    var imagesFromSource = [UIImage]()
    var uploadImageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerText.text = AppConstants.kCreateBlog
        saveButton.setTitle(RecipeConstants.kSave, for: .normal)
        blogLabel.text = AppConstants.kBlogTitle
        descriptionLabel.text = AppConstants.kDescription
        draftLabel.text  = RecipeConstants.kDraft
        setUi()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateBlogViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        
        descriptionTextView.textContainer.heightTracksTextView = true
        descriptionTextView.isScrollEnabled = false
        
        if blogtitle != nil {
            
            blogTxf.text = blogtitle
            descriptionTextView.text = fulldescription
            descriptionTextView.textColor = .black
            uploadImage.setImage(withString: String.getString((baseUrl ?? "")+imgurl!), placeholder: UIImage(named: "image_placeholder"))
            
            if draft == "1" {
                switchBar.isOn = true
                draftLabel.text = AppConstants.Publish
            } else {
                switchBar.isOn = false
                draftLabel.text = RecipeConstants.kDraft
            }
            
            self.cameraIcon.isHidden = true
            self.cameraText.isHidden = true
            
            blogLabel.isHidden = false
            blogTxf.placeholder = ""
            blogView1.isHidden = false
          //  blogLabel.textColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            blogLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            
            descriptionLabel.isHidden = false
            descriptionView1.isHidden = false
            descriptionLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
        }
        
        if typeofpage == "read" {
            headerText.text = AppConstants.kBlog
            draftView.isHidden = true
            saveButton.isHidden = true
            blogTxf.isUserInteractionEnabled = true
            descriptionTextView.isUserInteractionEnabled = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()

    }
    
    @IBAction func btnMediaTapped(_ sender: Any) {
        
        if typeofpage != "read" {
            
            var config = YPImagePickerConfiguration()
            config.screens = [.library, .photo]
            config.library.maxNumberOfItems = 1
            config.showsPhotoFilters = true
            //config.showsCrop = .rectangle(ratio: 1.5)
            config.library.onlySquare = true
            config.library.preselectedItems = ypImages
            let picker = YPImagePicker(configuration: config)

            picker.didFinishPicking { [self, unowned picker] items, cancelled in
                self.ypImages = items
                for item in items {
                    switch item {
                    case .photo(let photo):
                       // self.imagesFromSource.append()
                        self.imagesFromSource.removeAll()
                        self.imagesFromSource.append(photo.modifiedImage ?? photo.image)
                        
                        uploadImageArray = [UIImage]()
                        uploadImageArray.append(self.imagesFromSource[0])
                        
                        self.uploadImage.image = photo.modifiedImage ?? photo.image
                        self.uploadImage.layer.cornerRadius = 4
                        
                        self.cameraIcon.isHidden = true
                        self.cameraText.isHidden = true
                        
                        print(photo)
                    case .video(v: let v):
                        print("not used")
                    }
                }
                picker.dismiss(animated: true, completion: nil)
            }

            self.present(picker, animated: true, completion: nil)
            
        }
       
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       self.view.endEditing(true)
       return false
     }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
      }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.blogTxf
        {
            self.blogLabel.isHidden = false
          self.blogTxf.placeholder = ""
          self.blogView1.isHidden = false
          self.blogView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.blogLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)

        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
       if textView == self.descriptionTextView{
        
           if self.descriptionTextView.text == AppConstants.kDescription {
            self.descriptionTextView.text = nil
        }
        
        self.descriptionTextView.textColor = .black
        self.descriptionLabel.isHidden = false
       // self.timeTxf.placeholder = ""
      self.descriptionView1.isHidden = false
      self.descriptionView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        self.descriptionLabel.textColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
       
        
      }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.blogTxf
        {
            
            self.blogLabel.isHidden = false
            self.blogTxf.placeholder = AppConstants.kBlog + " "
                self.blogView1.isHidden = false
                blogView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            self.blogLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
       
        }

   
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.descriptionTextView
        {
            //if self.descriptionTextView.text == ""
            //{
            self.descriptionLabel.isHidden = false
            //self.descriptionTextView.text = "Description"
                self.descriptionView1.isHidden = false
                self.descriptionTextView.textColor = .black
                descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
            self.descriptionLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
        //}

        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UISwitch) {
        
        if blogtitle != nil {
            updateBlogApi()
        } else {
           
            if blogTxf.text == "" {
                alert(msg: AlertMessage.kPleaseEnterTitle)
            } else if descriptionTextView.text == "" {
                alert(msg: AlertMessage.kPleaseEnterDescription)
            } else if self.uploadImageArray.count == 0 {
                alert(msg: AlertMessage.kPleaseUploadBlogImage)
            } else {
                createBlogApi()
            }
            
        }
       
    }
    
    @IBAction func switchButtonTapped(_ sender: UISwitch) {
        if switchBar.isOn{
            draftLabel.text = AppConstants.Publish
            draftView.layer.borderColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        }
        else{
            draftLabel.text = RecipeConstants.kDraft
            draftView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        }
    }
    
    
    func setUi(){
        
        blogLabel.isHidden = true
        descriptionLabel.isHidden = true
        
        descriptionTextView.text = AppConstants.kDescription
        descriptionTextView.textColor = .lightGray
       // descriptionTextView.font = UIFont(name: "Montserrat", size: 16)
        
        blogView1.isHidden = true
        descriptionView1.isHidden = true
        
        blogTxf.autocorrectionType = .no
        descriptionTextView.autocorrectionType = .no
        
        
        draftView.layer.cornerRadius = 4
        draftView.layer.borderWidth = 2
        draftView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        blogView.layer.cornerRadius = 4
        blogView.layer.borderWidth = 2
        blogView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
        
        
        descriptionView.layer.cornerRadius = 4
        descriptionView.layer.borderWidth = 2
        descriptionView.layer.borderColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
    }
    
    func createBlogApi(){
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        
        
        let params: [String:Any] = [
            
            "title": blogTxf.text ?? "",
            "date": String.getString(dateFormatter.string(from: date)),
            "time": String.getString(date.timeIntervalSince1970),
            "status": switchBar.isOn ? "1":"0",
            "description": descriptionTextView.text ?? "",
            
        ]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray[0],
                                         APIConstants.kImageName: "image_id"]
        
        
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kCreateBlog, image: imageParam, controller: self, type: 0)
        
    }
    
    func updateBlogApi(){
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        
        
        let params: [String:Any] = [
            
            "title": blogTxf.text ?? "",
            "date": String.getString(dateFormatter.string(from: date)),
            "time": String.getString(date.timeIntervalSince1970),
            "status": switchBar.isOn ? "1":"0",
            "description": descriptionTextView.text ?? "",
            "blog_id": String.getString(blo_id),
        ]
        
        let imageParam : [String:Any] = self.uploadImageArray.count > 0 ? [APIConstants.kImage: self.uploadImageArray[0],APIConstants.kImageName: "image_id"] : [:]

        
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kUpdateBlog, image: imageParam, controller: self, type: 0)
        
    }
    
    func alert(msg:String){
        let refreshAlert = UIAlertController(title: AppConstants.kAlert, message: msg, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: MarketPlaceConstant.kOk, style: .default, handler: { (action: UIAlertAction!) in
           
            self.parent?.dismiss(animated: true, completion: nil)
        }))
        
        //let parent = self.parentViewController?.presentedViewController as? HubsListVC
        self.parent?.present(refreshAlert, animated: true, completion: nil)
    }
    

}

extension CreateBlogViewController{
    
    override func didUserGetData(from result: Any, type: Int) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
