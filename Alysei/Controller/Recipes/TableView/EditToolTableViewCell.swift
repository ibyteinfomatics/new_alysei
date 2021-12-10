//
//  EditToolTableViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 10/10/21.
//

import UIKit

protocol EditToolTableViewCellProtocol {
    func tapForTool(indexPath: IndexPath, data: ToolsArray, checkStatus: Bool?)
}
class EditToolTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var selectToolImgView: UIImageView!
    
  
    var checkDataStatus: Bool?
    var indexPath: IndexPath?
    var addToolDelegate : EditToolTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data: ToolsArray?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        if(selectedEditToolArray.contains(where: { $0.recipeToolIds == data?.recipeToolIds })) == true {
            self.selectToolImgView.isHidden = false
        }
        else if (editusedToolModel.contains(where: { $0.tool?.recipeToolIds == data?.recipeToolIds }))  == true {
            self.selectToolImgView.isHidden = false
                
        }
        else {
            self.selectToolImgView.isHidden = true
        }
        let imgUrl = ((data?.imageId?.baseUrl ?? "") + (data?.imageId?.imgUrl ?? ""))
        img.setImage(withString: imgUrl)
        label2.text = data?.toolTitle
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
        addButton.layer.cornerRadius = 5
        selectToolImgView.layer.cornerRadius = 5
        // Configure the view for the selected state
    }

    @IBAction func TapForAddTool(_ sender: UIButton) {
        
        if self.selectToolImgView.isHidden == true {
            addToolDelegate?.tapForTool(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0),data: data ?? ToolsArray(with: [:]), checkStatus: false)
        } else {
            addToolDelegate?.tapForTool(indexPath: indexPath ?? IndexPath(row: sender.tag, section: 0),data: data ?? ToolsArray(with: [:]), checkStatus: true)

        }
    }
}
