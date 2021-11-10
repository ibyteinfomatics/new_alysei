//
//  BlogFilterVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 11/9/21.
//

import UIKit

class BlogFilterVC: UIViewController {
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vw2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.addShadow()
        vw1.addBorder()
        vw2.addBorder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
