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
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRegistrationType: UILabel!
    @IBOutlet weak var lblRestType: UILabel!
    @IBOutlet weak var dateTxf: UITextField!
    var toolBar = UIToolbar()
    let datePicker = UIDatePicker()
    var dataDropDown = DropDown()
    var arrEventType = ["Public","Private"]
    var arrRegistrationType = ["Free","Paid"]
    var selectDate: Date?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.addShadow()
     
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, yyyy"
        dateTxf.text = formatter.string(from: Date())
        vw1.addBorder()
        vw2.addBorder()
        vw3.addBorder()
        vw4.addBorder()
        showDatePicker()
//        let dateTap = UITapGestureRecognizer(target: self, action: #selector(opendatepicker))
//        self.vw1.addGestureRecognizer(dateTap)
        
        let eventTap = UITapGestureRecognizer(target: self, action: #selector(openEventTypeDropDown))
        self.vw2.addGestureRecognizer(eventTap)
        
        let regTap = UITapGestureRecognizer(target: self, action: #selector(openRegistTypedropDown))
        self.vw3.addGestureRecognizer(regTap)
       
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
//    @objc func opendatepicker(_ tap: UITapGestureRecognizer){
//    //Create a DatePicker
//
//    }
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
        formatter.dateFormat = "dd MMMM, yyyy"
        dateTxf.text = formatter.string(from: datePicker.date)
        
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
        self.lblDate.text = "\(selectDate ?? Date())"
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
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
}
