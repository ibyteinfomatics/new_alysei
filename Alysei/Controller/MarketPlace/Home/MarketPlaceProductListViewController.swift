//
//  MarketPlaceProductListViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/27/21.
//

import UIKit

class MarketPlaceProductListViewController: UIViewController {
    @IBOutlet weak var btnBack: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MarketPlaceProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceProductListTableVCell", for: indexPath) as? MarketPlaceProductListTableVCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}



class MarketPlaceProductListTableVCell: UITableViewCell{
    
}
