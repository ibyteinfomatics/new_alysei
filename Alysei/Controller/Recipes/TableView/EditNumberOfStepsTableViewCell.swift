//
//  EditNumberOfStepsTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit
protocol EditNumberOfStepsDelegateProtocol {
    func editClickSteps(index: IndexPath)
    func deleteClickSteps(index: IndexPath)
}
class EditNumberOfStepsTableViewCell: UITableViewCell {
    @IBOutlet weak var stepTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var indexPath: IndexPath?
    var numberOfStepsDelegateProtocol: EditNumberOfStepsDelegateProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapForDeleteSteps(_ sender: Any) {
        numberOfStepsDelegateProtocol?.deleteClickSteps(index: indexPath!)
    }
    @IBAction func tapForEditSteps(_ sender: Any) {
        numberOfStepsDelegateProtocol?.editClickSteps(index: indexPath!)
    }
    
}
