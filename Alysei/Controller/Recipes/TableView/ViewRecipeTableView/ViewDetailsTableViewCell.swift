//
//  ViewDetailsTableViewCell.swift
//  New Recipe module
//
//  Created by mac on 18/08/21.
//

import UIKit

class ViewDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var cell1View: UIView!
    @IBOutlet weak var energyCircularProgressView: CircularProgressView!
    @IBOutlet weak var proteinCircularProgressView: CircularProgressView!
    @IBOutlet weak var carbsCircularProgressView: CircularProgressView!
    @IBOutlet weak var fatCircularProgressView: CircularProgressView!
    @IBOutlet weak var utencilButton: UIButton!
    @IBOutlet weak var ingredientsButton: UIButton!
    @IBOutlet weak var ingredientsStatusView: UIView!
    @IBOutlet weak var utencilsStatusView: UIView!
    
    var reloadTableViewCallback:((Int) ->Void)? = nil
    enum source {
        case button1
        case button2
    }
    
//    var source = source.button1
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUi()
    }
    func setUi(){
        energyCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        energyCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        energyCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.3)
        
        
        proteinCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        proteinCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        proteinCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.5)
        
        
        carbsCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        carbsCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        carbsCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.7)
        
        
        
        fatCircularProgressView.trackColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        fatCircularProgressView.progressColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1)
        fatCircularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.9)

        
      
    }
    
    @IBAction func utencilsButton(_ sender: UIButton) {
//        self.source = .button2
            self.utencilButton.setTitleColor(.black, for: .normal)
                        self.utencilButton.setImage(#imageLiteral(resourceName: "icons8_kitchen"), for: .normal)
                        utencilsStatusView.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
            self.ingredientsButton.setTitleColor(.lightGray, for: .normal)
            self.ingredientsButton.setImage(#imageLiteral(resourceName: "icons8_kitchen1"), for: .normal)
            self.ingredientsStatusView.layer.backgroundColor = UIColor.clear.cgColor
        reloadTableViewCallback?(sender.tag)
         

    }
        
    @IBAction func ingredientsButton(_ sender: UIButton) {
//        self.source = .button1
        self.ingredientsButton.setTitleColor(.black, for: .normal)
                    self.ingredientsButton.setImage(#imageLiteral(resourceName: "icons8_kitchen"), for: .normal)
                    ingredientsStatusView.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
        self.utencilButton.setTitleColor(.lightGray, for: .normal)
        self.utencilButton.setImage(#imageLiteral(resourceName: "icons8_kitchen1"), for: .normal)
        self.utencilsStatusView.layer.backgroundColor = UIColor.clear.cgColor
        reloadTableViewCallback?(sender.tag)
    

    }
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
