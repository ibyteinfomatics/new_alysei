//
//  EditRecipeViewController.swift
//  Filter App
//
//  Created by mac on 06/09/21.
//

import UIKit

class EditRecipeViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var cameraOpenView: UIView!
    @IBOutlet weak var selectMealView: UIView!
    @IBOutlet weak var selectCourseView: UIView!
    @IBOutlet weak var selectCookingSkillsView: UIView!
    @IBOutlet weak var selectCuisineView: UIView!
    @IBOutlet weak var selectDietView: UIView!
    @IBOutlet weak var selectFoodIntoleranceView: UIView!
    @IBOutlet weak var selectRegionView: UIView!
    @IBOutlet weak var editIngredients: UIButton!
    @IBOutlet weak var hoursLable: UILabel!
    @IBOutlet weak var minutesLable: UILabel!
    @IBOutlet weak var howMuchPeopleLable: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var mealLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
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
    
    var timer: Timer?
    var counter = 0
    var counter1 = 0
    var counter2 = 0
    var arrayMyRecipe: [HomeTrending]? = []
    var index = 0
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
    var str_return : String = String ()
    var arrOptions = [SelectMealDataModel]()
    var arrCourse = [SelectCourseDataModel]()
    var arrCuisine = [SelectCuisineDataModel]()
    var arrCookingSkill = [SelectCookingSkillsDataModel]()
    var arrDiet = [SelectRecipeDietDataModel]()
    var arrRegion = [SelectRegionDataModel]()
    var arrFoodIntolerance = [SelectFoodIntoleranceDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.uiSetup()
        
        
        picker1.delegate = self
        picker1.dataSource = self
        nameTextfield.delegate = self
        
        addPlusHourLongPressGesture()
        addMinusHourLongPressGesture()
        addPlusMinuteLongPressGesture()
        addMinusMinuteLongPressGesture()
        addPlusServingLongPressGesture()
        addMinusServingLongPressGesture()
        
        if arrayMyRecipe!.count > 0{
            let imgUrl = (kImageBaseUrl + (arrayMyRecipe?[index].image?.imgUrl ?? ""))
            recipeImage.setImage(withString: imgUrl)
           
            nameTextfield.text = arrayMyRecipe?[index].name
            
            cookingSkillLabel.text = arrayMyRecipe?[index].cookingSkill?.cookingSkillName
            self.cookingSkillLabel.textColor = .black
            strSelectedId = arrayMyRecipe?[index].cookingSkill?.cookinSkillId ?? 0
            
            cuisineLabel.text = arrayMyRecipe?[index].cuisin?.cuisineName
            self.cuisineLabel.textColor = .black
            strSelectedId2 = arrayMyRecipe?[index].cuisin?.cuisineId ?? 0
            
            mealLabel.text = arrayMyRecipe?[index].meal?.mealName
            self.mealLabel.textColor = .black
            strSelectedIdMeal = arrayMyRecipe?[index].meal?.recipeMealId
            
            courseLabel.text = arrayMyRecipe?[index].course?.courseName
            self.courseLabel.textColor = .black
            strSelectedIdCourse = arrayMyRecipe?[index].course?.recipeCourseId
            
            dietLabel.text = arrayMyRecipe?[index].diet?.dietName
            self.dietLabel.textColor = .black
            strSelecetdIdDiet = arrayMyRecipe?[index].course?.recipeCourseId
            
            foodIntoleranceLabel.text = arrayMyRecipe?[index].intolerance?.foodName
            self.foodIntoleranceLabel.textColor = .black
            strSelectedIdIntolerance = arrayMyRecipe?[index].intolerance?.foodId
            
            regionLabel.text = arrayMyRecipe?[index].region?.regionName
            self.regionLabel.textColor = .black
            strSelectedIdRegion = arrayMyRecipe?[index].region?.regionId
            
            hoursLable.text = "\(arrayMyRecipe?[index].hours ?? 0)"
            minutesLable.text = "\(arrayMyRecipe?[index].minute ?? 0)"
            howMuchPeopleLable.text = "\(arrayMyRecipe?[index].serving ?? 0)"
            
        }
    }
    
    func uiSetup(){
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        
        editIngredients.layer.cornerRadius = 6
        
        recipeImage.layer.cornerRadius = 6
        cameraOpenView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 6.0)
       
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
    
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
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
            self.mealLabel.text = self.str_return
//            self.mealNameLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.mealLabel.textColor = .black
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        
            
        case 4:
            if let stId = self.arrCourse[0].recipeCourseId
            {
                self.strSelectedIdCourse = stId
            }
            self.courseLabel.text = self.str_return
//            self.courseNameLabel.font = UIFont(name:"Montserrat-Regular",size: 14.0)
            self.courseLabel.textColor = .black
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
    
    @IBAction func editIngridient(_ sender: Any) {
        
    }
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapChangeImage(_ sender: Any) {
        self.alertToAddImage()
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
        if counter > 0 { counter -= 1 }
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
        if counter1 > 0 { counter1 -= 1 }
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
        if counter2 > 0 { counter2 -= 1 }
        howMuchPeopleLable.text = String(counter2)
        print(counter)
            self.howMuchPeopleLable.slideInFromLeft()
        }
    else{
        counter = 24
        howMuchPeopleLable.text = String(counter)
        print(counter)
        self.howMuchPeopleLable.slideInFromLeft()
    }
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
}

extension EditRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    self.dismiss(animated: true) { [self] in
        
            self.recipeImage.contentMode = .scaleAspectFill
        let scaledImage:UIImage = self.resizeImage(image: selectedImage, newWidth: 800)
        self.recipeImage.image = scaledImage
        let imgString = scaledImage.pngData()?.base64EncodedString()
        
        let preBaseStr = "data:image/png;base64,"
        arraySelectedImg = preBaseStr + (imgString ?? "")

    }
  }

}

extension EditRecipeViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (nameTextfield.text! as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        return numberOfChars < 21
    }
   
}
extension EditRecipeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
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
extension EditRecipeViewController{

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



