//
//  AddQuantityViewController.swift
//  Alysei Recipe Module
//
//  Created by mac on 05/08/21.
//

import UIKit


protocol ChildViewControllerDelegate
{
     func childViewControllerResponse()
}

class AddQuantityViewController: UIViewController {
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var unitView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    var delegate: ChildViewControllerDelegate?
    var toolBar = UIToolbar()
    var picker1  = UIPickerView()
    var strReturn = String()
    var arrQuantity = NSMutableArray()
    var arrUnit = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        picker1.delegate = self
        picker1.dataSource = self
        
       arrQuantity = ["1", "2"]
         arrUnit = ["Kg", "Piece"]
        setupUI()
        
       
    }
    
    func setupUI(){
        quantityView.layer.borderWidth = 1
        quantityView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        quantityView.layer.cornerRadius = 5
        unitView.layer.borderWidth = 1
        unitView.layer.borderColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        unitView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
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
        
        switch picker1.tag {
        case 1:
            self.quantityLbl.text = self.strReturn
            toolBar.removeFromSuperview()
            picker1.removeFromSuperview()
        case 2:
            self.unitLabel.text = self.strReturn
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
    
    @IBAction func tapQuantity(_ sender: Any) {
        picker1.tag = 1
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func tapUnit(_ sender: Any) {
        picker1.tag = 2
        picker1.reloadAllComponents()
        setPickerToolbar()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    


}

extension AddQuantityViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch picker1.tag {
        case 1:
            
            return self.arrQuantity.count

        case 2:

        return self.arrUnit.count
            

        default:

        break

        }
     return 0
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var str_return : String = String ()
    
        switch picker1.tag {
        
        case 1:

            if let stName = self.arrQuantity.object(at: row) as? String
         {
                str_return = stName
         }

        case 2:

            if let stName = self.arrUnit.object(at: row) as? String
         {
             str_return = stName
         }

        default: break

        }
      return str_return
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        var strSelectedId = String()
        switch picker1.tag {
        
        case 1:
            
            if row == 0
            {
                self.strReturn = self.arrQuantity[0] as! String
                 
            }
            if row == 1
            {
                self.strReturn = self.arrQuantity[1] as! String
                 
            }
        
        case 2:
            if row == 0{
                self.strReturn = self.arrUnit[0] as! String
            }
            if row == 1
            {
                self.strReturn = self.arrUnit[1] as! String
                 
            }
      
        default:
            break
        }
    }
}
