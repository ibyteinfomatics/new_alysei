//
//  OverLayLanguageVC.swift
//  Alysei
//
//  Created by Gitesh Dang on 22/02/22.
//

import UIKit

class OverLayLanguageVC: UIViewController {
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnItalian: UIButton!
    var btnCallback: ((Int) -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionBtnEnglish(_ sender: UIButton){
        self.dismiss(animated: true) {
            self.btnCallback?(sender.tag)
        }
        
        
    }
    @IBAction func actionBtnItalian(_ sender: UIButton){
        self.dismiss(animated: true) {
            self.btnCallback?(sender.tag)
        }
        
    }

}
