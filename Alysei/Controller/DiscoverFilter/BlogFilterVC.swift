//
//  BlogFilterVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/9/21.
//

import UIKit

class BlogFilterVC: UIViewController {
    @IBOutlet weak var vwHeader: UIView!
    
    @IBOutlet weak var lblSpecialization:UILabel!
    @IBOutlet weak var lblBlogTitle: UILabel!
    
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vw2: UIView!
    
    var passSpecialization: String?
    var passBlogTitle: String?
    
    var passSelectedDataCallback: ((String,String) -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        vwHeader.addShadow()
        vw1.addBorder()
        vw2.addBorder()
        // Do any additional setup after loading the view.
    }
    func setData(){
        if self.passSpecialization == "" {
            self.lblSpecialization.text = "Specialization"
        }else{
            self.passSpecialization = self.lblSpecialization.text
        }
        
        if self.passBlogTitle == "" {
            self.lblBlogTitle.text = "Blog Titles"
        }else{
            self.passSpecialization = self.lblBlogTitle.text
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFilterAction(_ sender: UIButton){
        if self.passSpecialization == "" {
            self.lblSpecialization.text = "Specialization"
        }else{
            self.passSpecialization = self.lblSpecialization.text
        }
        
        if self.passBlogTitle == "" {
            self.lblBlogTitle.text = "Blog Titles"
        }else{
            self.passSpecialization = self.lblBlogTitle.text
        }
        self.passSelectedDataCallback?(passSpecialization ?? "",passBlogTitle ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearAction(_ sender: UIButton){
        self.passSpecialization = ""
        self.passBlogTitle = ""
    }
}
