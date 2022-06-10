//
//  EventFilterVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/9/21.
//

import UIKit
import DropDown

class EventFilterVC: UIViewController {
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vw3: UIView!
    @IBOutlet weak var vw4: UIView!
    @IBOutlet weak var lblEventType: UILabel!
    @IBOutlet weak var lblRegistrationType: UILabel!
    @IBOutlet weak var lblRestType: UILabel!
    @IBOutlet weak var dateTxf: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClearFilter: UIButton!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!
    @IBOutlet weak var btnApplyFilter: UIButton!
    var toolBar = UIToolbar()
    let datePicker = UIDatePicker()
    var dataDropDown = DropDown()
    var arrEventType = [AppConstants.kPublic,AppConstants.kPrivate]
    var arrRegistrationType = [AppConstants.kFree,AppConstants.kPaid,AppConstants.kBuyInvitation]
    var selectDate: Date?
    
    var productType: ProductType?
    var arrProductType = [String]()
   // var restauId: Int?
   
    var passSelectedDataCallback: ((String,String,String,String,String) -> Void)? = nil
    
    var clearFiltercCallBack: (() -> Void)? = nil
    
    var passSelectedDate: String?
    var passSelectedEventType: String?
    var passSelectedRegistrationType: String?
    var passSelectedRestType: String?
    var passRestId,eventType,regisatrationType,dateget: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataAndUI()
        lblTitle.text = MarketPlaceConstant.kFilter
        btnClearFilter.setTitle(MarketPlaceConstant.kClearFilters, for: .normal)
        btnApplyFilter.setTitle(MarketPlaceConstant.kApplyFilters, for: .normal)
        lblTitle1.text = AppConstants.kSelectADate
        lblTitle2.text = AppConstants.kEventType
        lblTitle3.text = AppConstants.kRegistrationType
        lblTitle4.text = AppConstants.kRestaurantType
//        let dateTap = UITapGestureRecognizer(target: self, action: #selector(opendatepicker))
//        self.vw1.addGestureRecognizer(dateTap)
        
        let eventTap = UITapGestureRecognizer(target: self, action: #selector(openEventTypeDropDown))
        self.vw2.addGestureRecognizer(eventTap)
        
        let regTap = UITapGestureRecognizer(target: self, action: #selector(openRegistTypedropDown))
        self.vw3.addGestureRecognizer(regTap)
        
        let resTap = UITapGestureRecognizer(target: self, action: #selector(openRestaurantdropDown))
        self.vw4.addGestureRecognizer(resTap)
        
        callGetValueOfFieldApi()
       
    }
    
    func setDataAndUI(){
        
        vwHeader.drawBottomShadow()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        
        if passSelectedDate == "" || passSelectedDate == nil{
           // dateTxf.text = formatter.string(from: Date())
        }else{
        dateTxf.text = passSelectedDate
            dateget  = passSelectedDate
        }
        
        if passSelectedEventType == "" || passSelectedEventType == nil{
            //lblEventType.text = "Public"
        }else{
            lblEventType.text = passSelectedEventType
            eventType = passSelectedEventType
        }
        
        if passSelectedRegistrationType == "" || passSelectedRegistrationType == nil{
            //lblRegistrationType.text = "Free"
        }else{
            lblRegistrationType.text = passSelectedEventType
            regisatrationType = passSelectedEventType
        }
        if passSelectedRestType == "" || passSelectedRestType == nil{
            lblRestType.text = AppConstants.kSelectRestType
        }else{
            lblRestType.text = passSelectedRestType
        }
        
        
        vw1.addBorder()
        vw2.addBorder()
        vw3.addBorder()
        vw4.addBorder()
        showDatePicker()
          
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
//    @objc func opendatepicker(_ tap: UITapGestureRecognizer){
//    //Create a DatePicker
//
//    }
    
    @IBAction func btnFilterAction(_ sender: UIButton){
        if lblRestType.text == AppConstants.kSelectRestType {
            passSelectedRestType = ""
        }else{
            passSelectedRestType = lblRestType.text
        }
        self.passSelectedDataCallback?(dateget ?? "",eventType ?? "",regisatrationType ?? "", passSelectedRestType ?? "",passRestId ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearAction(_ sender: UIButton){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTxf.text = AppConstants.kChooseDate
        lblEventType.text = AppConstants.kSelectEvent
        lblRegistrationType.text = AppConstants.kSelectRegistration
        lblRestType.text = AppConstants.kSelectRestType
        passRestId = ""
        dateget = ""
        eventType = ""
        regisatrationType = ""
        //lblRestType.text = AppConstants.kSelectRestType
        //clearFiltercCallBack?()
        //self.navigationController?.popViewController(animated: true)
        
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        dateTxf.inputAccessoryView = toolbar
        dateTxf.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTxf.text = formatter.string(from: datePicker.date)
        dateget = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
       }
    
    @objc func onDoneButtonTapped() {
        //self.lblDate.text = "\(selectDate ?? Date())"
        self.dateTxf.text = "\(selectDate ?? Date())"
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    @objc func openEventTypeDropDown(){
        openEventdropDown()
    }
    @objc func openRegistTypedropDown(){
        openRegistdropDown()
    }
    func openEventdropDown(){
        dataDropDown.dataSource = arrEventType
        dataDropDown.show()
    
        dataDropDown.anchorView = vw2

        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            self.lblEventType.text = item
            eventType = item
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    
    func openRegistdropDown(){
        dataDropDown.dataSource = arrRegistrationType
        dataDropDown.show()
    
        dataDropDown.anchorView = vw3

        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            self.lblRegistrationType.text = item
            regisatrationType = item
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    @objc func openRestaurantdropDown(){
        dataDropDown.dataSource = arrProductType
        dataDropDown.show()
    
        dataDropDown.anchorView = vw4

        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            self.lblRestType.text = item
            self.passRestId = self.productType?.options?[index].userFieldOptionId
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    
    func callGetValueOfFieldApi(){
        self.arrProductType.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFieldValue + "10", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"] as? [String:Any]{
                self.productType = ProductType.init(with: data)
                for product in 0..<(self.productType?.options?.count ?? 0) {
                    self.arrProductType.append(self.productType?.options?[product].optionName ?? "")
                }
            }
            
            
        }
        
    }
    

    
    
    
}
