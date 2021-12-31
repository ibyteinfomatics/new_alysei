//
//  createNewRecipeViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 27/07/21.
//

import UIKit

var createRecipeJson: [String : Any] = [:]

class CreateNewRecipeViewController: AlysieBaseViewC{
    @IBOutlet weak var scrollViewCreateRecipe: UIScrollView!
    @IBOutlet weak var createNewRecipeView: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var selectCookingSkillsView: UIView!
    @IBOutlet weak var selectCuisineView: UIView!
    @IBOutlet weak var selectMealView: UIView!
    @IBOutlet weak var selectCourseView: UIView!
    @IBOutlet weak var selectDietView: UIView!
    @IBOutlet weak var selectFoodIntoleranceView: UIView!
    @IBOutlet weak var selectRegionView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var hoursLable: UILabel!
    @IBOutlet weak var minutesLable: UILabel!
    @IBOutlet weak var howMuchPeopleLable: UILabel!
    @IBOutlet weak var uploadRecipeLbl: UILabel!
    @IBOutlet weak var clickHereLbl: UILabel!
    @IBOutlet weak var imgInfoLbl: UIView!
    
    @IBOutlet weak var recipeImgVw: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var cookingSkillLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var foodIntoleranceLabel: UILabel!
    
    @IBOutlet weak var minusHourButton: UIButton!
    @IBOutlet weak var plusHourButton: UIButton!
    @IBOutlet weak var minusMinBtn: UIButton!
    @IBOutlet weak var plusMinBtn: UIButton!
    @IBOutlet weak var minusServingBtn: UIButton!
    @IBOutlet weak var plusServingBtn: UIButton!
    
    var counter = 0
    var counter1 = 0
    var counter2 = 0
    var tag = 0
    var picker = UIImagePickerController()
    var selectedImage = String()
    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strSelectedId : Int?
    var strSelectedIdMeal : Int?
    var strSelectedIdCourse : Int?
    var strSelecetdIdDiet: Int?
    var strSelectedIdIntolerance: Int?
    var strSelectedIdRegion: Int?
    var strSelectedId2: Int?
    var arraySelectedImg: String?

    var arrOptions = [SelectMealDataModel]()
    var arrCourse = [SelectCourseDataModel]()
    var arrCuisine = [SelectCuisineDataModel]()
    var arrCookingSkill = [SelectCookingSkillsDataModel]()
    var arrDiet = [SelectRecipeDietDataModel]()
    var arrRegion = [SelectRegionDataModel]()
    var arrFoodIntolerance = [SelectFoodIntoleranceDataModel]()
    var str_return : String = String ()
   
    var timer: Timer?
    
    override func viewDidLayoutSubviews() {
           self.scrollViewCreateRecipe.contentSize = CGSize(width: self.view.frame.size.width, height: 1250)
        
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.uiSetup()
        self.setTitle()
        picker1.delegate = self
        picker1.dataSource = self
        nameTextField.delegate = self
        nameTextField.autocorrectionType = .no
        let str = NSAttributedString(string: "Recipe Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        nameTextField.attributedPlaceholder = str
        addPlusHourLongPressGesture()
        addMinusHourLongPressGesture()
        addPlusMinuteLongPressGesture()
        addMinusMinuteLongPressGesture()
        addPlusServingLongPressGesture()
        addMinusServingLongPressGesture()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        photoView.addDashBorder()
        createNewRecipeView.drawBottomShadow()
    }
    
    func setTitle(){
        
        self.nameTextField.placeholder = LabelandTextFieldTitle.recipeName
        self.cookingSkillLabel.text = LabelandTextFieldTitle.selectCookingSkill
        self.cuisineLabel.text = LabelandTextFieldTitle.selectCuisine
        self.mealNameLabel.text = LabelandTextFieldTitle.selectMeal
        self.courseNameLabel.text = LabelandTextFieldTitle.selectCourse
        self.dietLabel.text = LabelandTextFieldTitle.selectDiet
        self.regionLabel.text = LabelandTextFieldTitle.selectRegion
        self.foodIntoleranceLabel.text = LabelandTextFieldTitle.selectFoodIntolerance
        
    }
    
    func uiSetup(){
        
        createNewRecipeView.layer.masksToBounds = false
        createNewRecipeView.layer.shadowRadius = 2
        createNewRecipeView.layer.shadowOpacity = 0.2
        createNewRecipeView.layer.shadowColor = UIColor.lightGray.cgColor
        createNewRecipeView.layer.shadowOffset = CGSize(width: 0 , height:2)
        //photoView.addDashBorder()
        selectCookingSkillsView.layer.borderWidth = 1
        selectCookingSkillsView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectCookingSkillsView.layer.cornerRadius = 5
        
        selectCuisineView.layer.borderWidth = 1
        selectCuisineView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectCuisineView.layer.cornerRadius = 5
        
        
        selectMealView.layer.borderWidth = 1
        selectMealView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectMealView.layer.cornerRadius = 5
        
        selectCourseView.layer.borderWidth = 1
        selectCourseView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectCourseView.layer.cornerRadius = 5
        
        selectDietView.layer.borderWidth = 1
        selectDietView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectDietView.layer.cornerRadius = 5
        
        selectRegionView.layer.borderWidth = 1
        selectRegionView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectRegionView.layer.cornerRadius = 5
        selectFoodIntoleranceView.layer.borderWidth = 1
        selectFoodIntoleranceView.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        selectFoodIntoleranceView.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 24
        nextButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
    }
    
    
    func setPickerToolbar(){
        
        picker1.backgroundColor = UIColor.white
        picker1.setValue(UIColor.black, forKey: "textColor")
        picker1.autoresizingMask = .flexibleWidth
        picker1.contentMode = .center
        picker1.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker1)
        picker1.reloadAllComponents()

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 40))
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
        
        switch picker1.tag {
        case 1:
            if let stId = self.arrCookingSkill[0].cookinSkillId
            {
                self.strSelectedId = stId
            }
            self.cookingSkillLabel.text = self.str_return
//            self.cookingSkillLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.cookingSkillLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()

        case 2:
            if let stId = self.arrCuisine[0].cuisineId
            {
                self.strSelectedId2 = stId
            }
            self.cuisineLabel.text = self.str_return
//            self.cuisineLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.cuisineLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        
            
        case 3:
            if let stId = self.arrOptions[0].recipeMealId
            {
                self.strSelectedIdMeal = stId
            }
            self.mealNameLabel.text = self.str_return
//            self.mealNameLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.mealNameLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        
            
        case 4:
            if let stId = self.arrCourse[0].recipeCourseId
            {
                self.strSelectedIdCourse = stId
            }
            self.courseNameLabel.text = self.str_return
//            self.courseNameLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.courseNameLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        
        
        case 5:
            if let stId = self.arrDiet[0].dietId
            {
                self.strSelecetdIdDiet = stId
            }
            self.dietLabel.text = self.str_return
//            self.dietLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.dietLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        
        case 6:
            if let stId = self.arrFoodIntolerance[0].foodId
            {
                self.strSelectedIdIntolerance = stId
            }
            self.foodIntoleranceLabel.text = self.str_return
            
//            self.foodIntoleranceLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.foodIntoleranceLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
           
            
        case 7:
            if let stId = self.arrRegion[0].regionId
            {
                self.strSelectedIdRegion = stId
            }
            self.regionLabel.text = self.str_return
//            self.regionLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.regionLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
       
        default:
            break
        }

    }
    
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
       }
    
    
    @IBAction func tapSelectMeal(_ sender: Any) {
        
        picker1.tag = 3
        toolBar.removeFromSuperview()
        picker1.reloadAllComponents()
        setPickerToolbar()
        postRequestToGetMeal()
    }
    

    @IBAction func tapSelectCourse(_ sender: Any) {
        
        picker1.tag = 4
        toolBar.removeFromSuperview()
        picker1.reloadAllComponents()
        setPickerToolbar()
        postRequestToGetCourse()
    }
    @IBAction func tapSelectCookingSkills(_ sender: Any) {
        picker1.tag = 1
        toolBar.removeFromSuperview()
        picker1.reloadAllComponents()
        self.view.isUserInteractionEnabled = false
        setPickerToolbar()
        postRequestToGetCookinSkills()
    }
    
    @IBAction func tapSelectCuisine(_ sender: Any) {
        picker1.tag = 2
        toolBar.removeFromSuperview()
        picker1.reloadAllComponents()
        setPickerToolbar()
        postRequestToGetCuisine()
    }
    
    @IBAction func tapSelectDiet(_ sender: Any) {
        
        picker1.tag = 5
        toolBar.removeFromSuperview()
        picker1.reloadAllComponents()
        setPickerToolbar()
        postRequestToGetDiet()
    }

    @IBAction func tapSelectFoodIntolerance(_ sender: Any) {
        
        picker1.tag = 6
        toolBar.removeFromSuperview()
        picker1.reloadAllComponents()
        setPickerToolbar()
        postRequestToGetFoodIntolerance()
    }
    
    @IBAction func tapSelectRegion(_ sender: Any) {
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
        if self.cuisineLabel.text == "Select Cuisine"{
            showAlert(withMessage: AlertMessage.kSelectCousin)
        }
        else{
            picker1.tag = 7
            picker1.reloadAllComponents()
            setPickerToolbar()
            postRequestToGetRegion(strSelectedId2 ?? 0)
        }
        
        
    }
    @IBAction func nextButton(_ sender: UIButton) {

        self.validateFields()
        createRecipeJson = ["recipeImage" : self.arraySelectedImg, "name" : self.nameTextField.text ?? "", "cookingSkill" : self.cookingSkillLabel.text ?? "","cookingSkillId" : self.strSelectedId ?? 0, "cusineId" : self.strSelectedId2 ?? 0, "cusine" : self.cuisineLabel.text ?? "", "meal" : self.mealNameLabel.text ?? "","mealId" : self.strSelectedIdMeal ?? 0, "course" : self.courseNameLabel.text ?? "","courseId" : self.strSelectedIdCourse ?? 0, "diet" : self.dietLabel.text ?? "","dietId" : self.strSelecetdIdDiet ?? 0, "foodIntolerance" : self.foodIntoleranceLabel.text ?? "","foodIntoleranceId" : self.strSelectedIdIntolerance ?? 0, "hour" : Int(self.hoursLable.text!) ?? 0, "minute" : Int(self.minutesLable.text!) ?? 0, "serving" : Int(self.howMuchPeopleLable.text!) ?? 0, "region" : self.regionLabel.text ?? "", "regionId" : self.strSelectedIdRegion ?? 0]
        
    }
    @IBAction func plusHoursButton(_ sender: UIButton) {


        if counter != 24{
        counter += 1

            hoursLable.text = String(counter)
             print(counter)
            self.hoursLable.slideInFromLeft()
        }
        else{
            counter = 0
            hoursLable.text = String(counter)
            print(counter)
            self.hoursLable.slideInFromLeft()
        }

    }
    @IBAction func minusHoursButton(_ sender: UIButton) {
       
       
        if counter != 0 {
            counter -= 1
        hoursLable.text = String(counter)
        print(counter)
            self.hoursLable.slideInFromLeft()
        }
    else{
        counter = 24
        hoursLable.text = String(counter)
        print(counter)
        self.hoursLable.slideInFromLeft()
    }
    }
    @IBAction func plusMinutesButton(_ sender: UIButton) {
        
        if counter1 != 60{
        counter1 += 1
            minutesLable.text = String(counter1)
             print(counter1)
            self.minutesLable.slideInFromLeft()
        }
        else{
            counter1 = 0
            minutesLable.text = String(counter1)
            print(counter1)
            self.minutesLable.slideInFromLeft()
        }
    }
    @IBAction func minusMinutesButton(_ sender: UIButton) {
     
        if counter1 != 0 {
            counter1 -= 1
        minutesLable.text = String(counter1)
        print(counter1)
            self.minutesLable.slideInFromLeft()
        }
    else{
        counter1 = 60
        minutesLable.text = String(counter1)
        print(counter1)
        self.minutesLable.slideInFromLeft()
    }
    }
    @IBAction func howMuchPeoplePlusButton(_ sender: UIButton) {
      
        if counter2 != 24{
            counter2 += 1
        
            howMuchPeopleLable.text = String(counter2)
             print(counter2)
            self.howMuchPeopleLable.slideInFromLeft()
        }
        else{
            counter2 = 0
            howMuchPeopleLable.text = String(counter2)
            print(counter2)
            self.howMuchPeopleLable.slideInFromLeft()
        }
    }
    @IBAction func howMuchPeopleMinusButton(_ sender: UIButton) {
    
        if counter2 != 0 {
            counter2 -= 1
        howMuchPeopleLable.text = String(counter2)
        print(counter2)
            self.howMuchPeopleLable.slideInFromLeft()
        }
    else{
        counter2 = 24
        howMuchPeopleLable.text = String(counter2)
        print(counter2)
        self.howMuchPeopleLable.slideInFromLeft()
    }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        let discoverRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverRecipeViewController") as! DiscoverRecipeViewController
        selectedIngridentsArray.removeAll()
        selectedToolsArray.removeAll()
        self.navigationController?.pushViewController(discoverRecipeVC, animated: true)
        
    }
    
    @IBAction func tapUploadImg(_ sender: Any) {
        
        self.alertToAddImage()
        
    }
    
    @objc func longPressPlusHour(sender: UIGestureRecognizer) {
        if sender.state == .began {

            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (_) in
                        
                if counter != 24{
                    counter += 1
                    hoursLable.text = String(counter)
                     print(counter)
                    self.hoursLable.slideInFromLeft()
                }
                else{
                    counter = 0
                    hoursLable.text = String(counter)
                    print(counter)
                    self.hoursLable.slideInFromLeft()
                }
                
            }
            
        }
        
        else if sender.state == .ended {
            timer?.invalidate()
        }
        }
    
    @objc func longPressPlusMinutes(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (_) in
                           
                if counter1 != 60{
                    counter1 += 1
                    minutesLable.text = String(counter1)
                     print(counter1)
                    self.minutesLable.slideInFromLeft()
                }
                else{
                    counter1 = 0
                    minutesLable.text = String(counter1)
                    print(counter1)
                    self.minutesLable.slideInFromLeft()
                }
                
            }
        }
        
        else if gesture.state == .ended {
            timer?.invalidate()
        }
    }
    
    @objc func longPressPlusServing(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (_) in
                
                
                if counter2 != 24{
                    counter2 += 1
                    
                    howMuchPeopleLable.text = String(counter2)
                    print(counter2)
                    self.howMuchPeopleLable.slideInFromLeft()
                }
                else{
                    counter2 = 0
                    howMuchPeopleLable.text = String(counter2)
                    print(counter2)
                    self.howMuchPeopleLable.slideInFromLeft()
                }
            }
        }
        
        else if gesture.state == .ended {
            timer?.invalidate()
        }
    }
    
   
    
    @objc func longPressMinusHour(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (_) in
                           
                
                if counter != 0 {
                    counter -= 1
                    hoursLable.text = String(counter)
                    print(counter)
                    self.hoursLable.slideInFromLeft()
                }
                else{
                    counter = 24
                    hoursLable.text = String(counter)
                    print(counter)
                    self.hoursLable.slideInFromLeft()
                }
            }
        }
        
        else if gesture.state == .ended {
            timer?.invalidate()
        }
    }
    
    @objc func longPressMinusMinutes(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (_) in
                           
               
                if counter1 != 0 {
                    counter1 -= 1
                    minutesLable.text = String(counter1)
                    print(counter1)
                    self.minutesLable.slideInFromLeft()
                }
                else{
                    counter1 = 60
                    minutesLable.text = String(counter1)
                    print(counter1)
                    self.minutesLable.slideInFromLeft()
                }
                
            }
        }
        
        else if gesture.state == .ended {
            timer?.invalidate()
        }
    }
    
    @objc func longPressMinusServing(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (_) in
                           
               
                if counter2 != 0 {
                    counter2 -= 1
                    howMuchPeopleLable.text = String(counter2)
                    print(counter2)
                    self.howMuchPeopleLable.slideInFromLeft()
                }
                else{
                    counter2 = 24
                    howMuchPeopleLable.text = String(counter2)
                    print(counter2)
                    self.howMuchPeopleLable.slideInFromLeft()
                }
            }
        }
        
        else if gesture.state == .ended {
            timer?.invalidate()
        }
    }

    func addPlusHourLongPressGesture(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressPlusHour))
        longPress.minimumPressDuration = 0.5
        self.plusHourButton.addGestureRecognizer(longPress)
    }
    
    func addMinusHourLongPressGesture(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressMinusHour))
        longPress.minimumPressDuration = 0.5

        self.minusHourButton.addGestureRecognizer(longPress)
    }
    
    func addPlusMinuteLongPressGesture(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressPlusMinutes))
        longPress.minimumPressDuration = 0.5
        self.plusMinBtn.addGestureRecognizer(longPress)
      
    }
    
    func addMinusMinuteLongPressGesture(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressMinusMinutes))
        longPress.minimumPressDuration = 0.5
        self.minusMinBtn.addGestureRecognizer(longPress)
      
    }
    
    func addPlusServingLongPressGesture(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressPlusServing))
        longPress.minimumPressDuration = 0.5
        self.plusServingBtn.addGestureRecognizer(longPress)
        
        
    }
    
    func addMinusServingLongPressGesture(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressMinusServing))
        longPress.minimumPressDuration = 0.5
    
        self.minusServingBtn.addGestureRecognizer(longPress)
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
    
    func isValidName() -> Bool {
        let passwordRegex = "^{3,20}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    // Validation on Next Button Click ----------------------
    
    private func validateFields() -> Void{
        
        if self.recipeImgVw.image == nil{
          showAlert(withMessage: AlertMessage.kUploadImage)
        }
     else if String.getString(nameTextField.text).isEmpty == true{
        showAlert(withMessage: AlertMessage.kEnterName)
      }
      else if nameTextField.text!.count < 3 {
            showAlert(withMessage: AlertMessage.kEnterValidName)
        }
      else if String.getString(cookingSkillLabel.text) == LabelandTextFieldTitle.selectCookingSkill{
        showAlert(withMessage: AlertMessage.kSelectCookingSkill)
      }
      else if String.getString(cuisineLabel.text) == LabelandTextFieldTitle.selectCuisine{
        showAlert(withMessage: AlertMessage.kSelectCousin)
      }
      else if String.getString(mealNameLabel.text) == LabelandTextFieldTitle.selectMeal{
        showAlert(withMessage: AlertMessage.kSelectMeal)
      }
      else if String.getString(courseNameLabel.text) == LabelandTextFieldTitle.selectCourse{
        showAlert(withMessage: AlertMessage.kSelectCourse)
      }
      else if String.getString(dietLabel.text) == LabelandTextFieldTitle.selectDiet{
        showAlert(withMessage: AlertMessage.kSelectDiet)
      }
      else if String.getString(hoursLable.text) == "0" && (String.getString(minutesLable.text) == "0"){
        showAlert(withMessage: AlertMessage.kSelectHour)
      }
      else if String.getString(howMuchPeopleLable.text) == "0"{
        showAlert(withMessage: AlertMessage.kSelecForPeople)
      }
      else if String.getString(regionLabel.text) == LabelandTextFieldTitle.selectRegion {
        showAlert(withMessage: AlertMessage.kSelectRegion)
      }
      else{
        let selectRecipeCategaryVC = self.storyboard?.instantiateViewController(withIdentifier: "AddIngredientsViewController") as! AddIngredientsViewController
        self.navigationController?.pushViewController(selectRecipeCategaryVC, animated: true)    }
      
    }
}

//MARK: - ImagePickerViewDelegate Methods -

extension CreateNewRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    self.dismiss(animated: true) { [self] in
        
        self.recipeImgVw.contentMode = .scaleAspectFill
        let scaledImage = selectedImage.jpegData(compressionQuality: 0.5)
        let image = UIImage(data: scaledImage!)
//        let scaledImage:UIImage = self.resizeImage(image: selectedImage, newWidth: 800)
        self.recipeImgVw.image = image
        let imgString = image?.pngData()?.base64EncodedString()
        
        let preBaseStr = "data:image/png;base64,"
        arraySelectedImg = preBaseStr + (imgString ?? "")

    }
  }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
       let size = image.size
       
       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height
       
       // Figure out what our orientation is, and use that to form the rectangle
       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
       }
       
       // This is the rect that we've calculated out and this is what is actually used below
       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
       
       // Actually do the resizing to the rect using the ImageContext stuff
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       
       return newImage!
   }
}

extension CreateNewRecipeViewController: UITextFieldDelegate{
    
//    func textFieldDidBeginEditing(_ textField: UITextField)
//    {
//      textField.becomeFirstResponder()
//    }

//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
//    {
//        return true
//    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if nameTextField.text!.count < 3 {
//            showAlert(withMessage: AlertMessage.kEnterValidName)
//        }
//        self.view.endEditing(true)
//        return true
//    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (nameTextField.text! as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        return numberOfChars < 21
    }
   
}

extension UIView {
    func addDashBorder() {
        let color = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 10).cgPath
        
        self.layer.masksToBounds = true
        
        self.layer.addSublayer(shapeLayer)
    }
    
}

        
extension UIView {
     // Name this function in a way that makes sense to you...
     // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
         // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
 
       // Set its callback delegate to the completionDelegate that was provided (if any)
       if let delegate: AnyObject = completionDelegate {
        slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
       }

        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromTop
       slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed

        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")    }

}
        

extension CreateNewRecipeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch picker1.tag {
        case 1:
            return self.arrCookingSkill.count
          

        case 2:

            return self.arrCuisine.count
      
            
        case 3:

            return self.arrOptions.count
            
        case 4:

            return self.arrCourse.count
            
        case 5:

        return self.arrDiet.count
        case 6:

        return self.arrFoodIntolerance.count
            
        case 7:

        return self.arrRegion.count

        default:

        break

        }
     return 0
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch picker1.tag {
        
        case 3:

            if let stName = self.arrOptions[row].mealName
         {
                str_return = stName
         }

        case 4:

            if let stName = self.arrCourse[row].courseName
         {
             str_return = stName
         }
        case 1:

            if let stName = self.arrCookingSkill[row].cookingSkillName
         {
             str_return = stName
         }
        case 2:

            if let stName = self.arrCuisine[row].cuisineName
         {
             str_return = stName
         }
        case 5:

            if let stName = self.arrDiet[row].dietName
         {
             str_return = stName
         }
        case 6:

            if let stName = self.arrFoodIntolerance[row].foodName
         {
             str_return = stName
         }
        case 7:

            if let stName = self.arrRegion[row].regionName
         {
             str_return = stName
         }
            

        default: break

        }
      return str_return
    }
    
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        switch picker1.tag {
        
        case 3:
             if let stId = self.arrOptions[row].recipeMealId
             {
                 self.strSelectedId = stId
             }
             if let stName = self.arrOptions[row].mealName
             {
                self.str_return = stName
             }
        
        case 4:
             if let stId = self.arrCourse[row].recipeCourseId
             {
                 self.strSelectedIdCourse = stId
             }
             if let stName = self.arrCourse[row].courseName
             {
                 self.str_return = stName
             }
        case 1:
             if let stId = self.arrCookingSkill[row].cookinSkillId
             {
                 self.strSelectedId = stId
             }
             if let stName = self.arrCookingSkill[row].cookingSkillName
             {
                 self.str_return = stName
             }
        case 2:
             if let stId = self.arrCuisine[row].cuisineId
             {
                 self.strSelectedId2 = stId
             }
             if let stName = self.arrCuisine[row].cuisineName
             {
                self.str_return = stName
             }
        case 5:
             if let stId = self.arrDiet[row].dietId
             {
                 self.strSelecetdIdDiet = stId
             }
             if let stName = self.arrDiet[row].dietName
             {
                self.str_return = stName
             }
        case 6:
            if let stId = self.arrFoodIntolerance[row].foodId
             {
                 self.strSelectedIdIntolerance = stId
             }
             if let stName = self.arrFoodIntolerance[row].foodName
             {
                self.str_return = stName
             }
        case 7:
             if let stId = self.arrRegion[row].regionId
             {
                 self.strSelectedIdRegion = stId
             }
             if let stName = self.arrRegion[row].regionName
             {
                self.str_return = stName
             }
        default:
            break
        }
    }
}

// Api Calling ---------------

extension CreateNewRecipeViewController{

     func postRequestToGetMeal() -> Void{
        self.view.isUserInteractionEnabled = false
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeMeal, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
            
            let res = response as? [String:Any]
            
            if let data = res?["data"] as? [[String:Any]]{
                self.arrOptions = data.map({SelectMealDataModel.init(with: $0)})
            }
           
            self.picker1.reloadAllComponents()
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
    func postRequestToGetCourse() -> Void{
        self.view.isUserInteractionEnabled = false
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeCources, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrCourse = data.map({SelectCourseDataModel.init(with: $0)})
           }
           
           self.picker1.reloadAllComponents()
        self.view.isUserInteractionEnabled = true
       }
       
   }
    
    
    func postRequestToGetRegion(_ cuisineId: Int) -> Void{
        self.view.isUserInteractionEnabled = false
    let param: [String:Any] = [APIConstants.kCousinId: cuisineId]

       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getrecipeRegion, requestMethod: .GET, requestParameters: param, withProgressHUD: true) { (response, error, errorType, statusCode) in

           let res = response as? [String:Any]

           if let data = res?["data"] as? [[String:Any]]{
            self.arrRegion = data.map({ SelectRegionDataModel.init(with: $0)})
           }

           self.picker1.reloadAllComponents()
        self.view.isUserInteractionEnabled = true
       }

   }
    

    func postRequestToGetCuisine() -> Void{
        self.view.isUserInteractionEnabled = false
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getCuisine, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrCuisine = data.map({SelectCuisineDataModel.init(with: $0)})
           }
           
           self.picker1.reloadAllComponents()
        self.view.isUserInteractionEnabled = true
       }
       
   }
    
    func postRequestToGetCookinSkills() -> Void{
        self.view.isUserInteractionEnabled = false
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getCookingSkill, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrCookingSkill = data.map({SelectCookingSkillsDataModel.init(with: $0)})
           }
           
           self.picker1.reloadAllComponents()
        self.view.isUserInteractionEnabled = true
       }
       
   }
    
    func postRequestToGetDiet() -> Void{
        self.view.isUserInteractionEnabled = false
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getRecipeDiet, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrDiet = data.map({SelectRecipeDietDataModel.init(with: $0)})
           }
           
           self.picker1.reloadAllComponents()
        self.view.isUserInteractionEnabled = true
       }
       
   }
    func postRequestToGetFoodIntolerance() -> Void{
        self.view.isUserInteractionEnabled = false
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFoodIntolerance, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrFoodIntolerance = data.map({SelectFoodIntoleranceDataModel.init(with: $0)})
           }
           
           self.picker1.reloadAllComponents()
        self.view.isUserInteractionEnabled = true
       }
       
   }
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
