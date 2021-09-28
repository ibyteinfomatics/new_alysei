//
//  MarketPlaceOptionViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/27/21.
//

import UIKit

class MarketPlaceOptionViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MarketPlaceOptionViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketPlaceOptionTableViewCell", for: indexPath) as? MarketPlaceOptionTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MarketPlaceProductListViewController") as? MarketPlaceProductListViewController else {return}
    
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


class MarketPlaceOptionTableViewCell: UITableViewCell{
    
    @IBOutlet weak var vwContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.addShadow()
    }
    
}
