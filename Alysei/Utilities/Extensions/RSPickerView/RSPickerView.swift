//
//  RSPickerView.swift
//  Evango
//
//  Created by Office on 22/06/16.
//  Copyright © 2016 Collabroo. All rights reserved.
//

import UIKit

//let kGetScreenWidth              = UIScreen.mainScreen().bounds.size.width
//let kGetScreenHeight             = UIScreen.mainScreen().bounds.size.height
let pickerTopMargin: CGFloat = 0

class RSPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
  
    //MARK: - Closures -
    
    private var callBack = {(index: Int, response: Any?) -> () in }
    
    fileprivate var numOfComponents:Int { return 1 }
    
    //MARK: - Public Methods -
    
    var arrData: [Any]!
    var strKey: String?
    var pickerView: UIPickerView!
    var viewContainer: UIView!
    
    //MARK: - Initializer Methods -
    
    convenience init(view: UIView, arrayList list: [Any], keyValue key: String?, prevSelectedValue selected:Int = 0, handler completionBlock: @escaping (_ index: Int, _ response: Any?) -> ()) {
      
        self.init(frame: view.bounds)
        
        //let screenHeight = kScreenHeight
        arrData = list
        strKey = key
        
        let viewHt = view.bounds.size.height
      let cHt = 240.0
        let yValue = viewHt - CGFloat(cHt) - pickerTopMargin
        viewContainer = UIView(frame: CGRect(x: 0, y: viewHt, width: kScreenWidth, height: CGFloat(cHt)))
        viewContainer.backgroundColor = UIColor.darkGray
      //pickerView = UIPickerView(frame: CGRect(x: 2, y: 0, width: kScreenWidth, height: (kScreenHeight/2 - 100.0)))
        pickerView = UIPickerView(frame: CGRect(x: 2, y: 0, width: kScreenWidth, height: 230))
        pickerView.delegate = self
        pickerView.dataSource = self
        viewContainer.addSubview(pickerView)
        
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        viewHeader.backgroundColor = AppColors.mediumBlue.color
        
        let btnCancel = getButton(xValue: 1.0, buttonTitle: "Cancel")
        viewHeader.addSubview(btnCancel)
        
        let btnDone = getButton(xValue: kScreenWidth - 71.0, buttonTitle: "Done")
        viewHeader.addSubview(btnDone)
        
        viewContainer.addSubview(viewHeader)
        self.addSubview(viewContainer)
        
        view.addSubview(self)
        callBack = completionBlock
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options: .beginFromCurrentState, animations: {
            var frame = self.viewContainer.frame
            frame.origin.y = yValue
            self.viewContainer.frame = frame
        }, completion: nil)
        
        pickerView.reloadAllComponents()
        
        if (self.numOfComponents - 1) >= 0 {
         
          pickerView.selectRow(selected, inComponent: (self.numOfComponents - 1), animated: true)
        }
    }
    
    override init(frame: CGRect){
      
      super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
      
      fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- ----------Private Methods----------
  
    private func getButton(xValue: CGFloat, buttonTitle title: String) -> UIButton
    {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: xValue, y: 1, width: 70, height: 35)
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        
        if (title == "Cancel"){
          button.addTarget(self, action: #selector(tapCancel(sender:)), for: .touchUpInside)
        }
        else{
          button.addTarget(self, action: #selector(tapDone(sender:)), for: .touchUpInside)
        }
        return button
    }
    
    //MARK: - IBAction Methods -
  
    @objc func tapCancel(sender: UIButton){
      
        kSharedAppDelegate.window!.endEditing(true)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .beginFromCurrentState, animations: {
            var frame = self.viewContainer.frame
            frame.origin.y = self.frame.size.height
            self.viewContainer.frame = frame
        }) { (finished) in
            //self.callBack(-1, nil)
            self.removeFromSuperview()
        }
    }
    
    @objc func tapDone(sender: UIButton)
    {
      kSharedAppDelegate.window?.endEditing(true)
        UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options: .beginFromCurrentState, animations: {
            var frame = self.viewContainer.frame
            frame.origin.y = self.frame.size.height
            self.viewContainer.frame = frame
        })
        { (finished) in
            if finished
            {
                if self.arrData.count > 0
                {
                    if self.strKey == nil
                    {
                        self.callBack(self.pickerView.selectedRow(inComponent: 0), String.getString(self.arrData[self.pickerView.selectedRow(inComponent: 0)]).capitalized)
                    }
                    else
                    {
                        self.callBack(self.pickerView.selectedRow(inComponent: 0), String.getString(kSharedInstance.getDictionary(self.arrData[self.pickerView.selectedRow(inComponent: 0)])[self.strKey!]).capitalized)
                    }
                }
                else
                {
                    self.callBack(-1, nil)
                }
                self.removeFromSuperview()
            }
        }
    }
    
    
    //MARK:- ----------Picker View Delegate Methods----------
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return self.numOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return arrData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let key = strKey else { return String.getString(arrData[row]) }
        
        let dictData = kSharedInstance.getDictionary(arrData[row])
        return String.getString(dictData[key])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
    }
}
