//
//  AddReviewViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 08/10/21.
//

import UIKit

class AddReviewRecipeViewController: UIViewController{
    
    @IBOutlet weak var allReviewTableView: UITableView!
    @IBOutlet weak var userImageVw: UIImageView!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var btnAddReview: UIButton!
    
    
    var arrAllReviewModel: [LatestReviewDataModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allReviewTableView.delegate = self
        allReviewTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapBack(_ sender: Any) {
    }
    
    @IBAction func tapAddReview(_ sender: Any) {
    }
    
    @IBAction func tap1star(_ sender: Any) {
    }
    @IBAction func tap2star(_ sender: Any) {
    }
    @IBAction func tap3star(_ sender: Any) {
    }
    @IBAction func tap4star(_ sender: Any) {
    }
    @IBAction func tap5star(_ sender: Any) {
    }
}

extension AddReviewRecipeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrAllReviewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddReviewTableViewCell") as! AddReviewTableViewCell
        return cell
    }
    
    
    
}
