//
//  NumberofStepsTableViewCell.swift
//  Alysei Recipe Module
//
//  Created by mac on 09/08/21.
//

import UIKit

protocol NumberOfStepsDelegateProtocol {
    func editClickSteps(index: IndexPath)
//    func deleteClickSteps(index: IndexPath)
}
class NumberofStepsTableViewCell: UITableViewCell {

    @IBOutlet weak var stepTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var indexPath: IndexPath?
    var numberOfStepsDelegateProtocol: NumberOfStepsDelegateProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func tapForEditSteps(_ sender: Any) {
        numberOfStepsDelegateProtocol?.editClickSteps(index: indexPath!)
    }
    
//    @IBAction func tapForDeleteSteps(_ sender: Any) {
//        numberOfStepsDelegateProtocol?.deleteClickSteps(index: indexPath!)
//    }
}
