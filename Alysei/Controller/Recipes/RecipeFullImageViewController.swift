//
//  RecipeFullImageViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 09/06/22.
//

import UIKit

class RecipeFullImageViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var imageUrl: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.setImage(withString: imageUrl ?? "",placeholder: UIImage(named: "image_placeholder"))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: false)
    }

}
