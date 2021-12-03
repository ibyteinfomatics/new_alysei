//
//  BlogsTableViewCell.swift
//  Profile Screen
//
//  Created by mac on 28/08/21.
//

import UIKit

class BlogsTableViewCell: UITableViewCell {
    @IBOutlet weak var blogImage: UIImageView!
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var blogDescription: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwContainerlbl: UIView!
    @IBOutlet weak var lblDraftPublsh: UILabel!
    
    var btnDeleteCallback:((Int) -> Void)? = nil
    var btnEditCallback:((Int) -> Void)? = nil
    var btnMoreCallback:((Int) -> Void)? = nil
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vwContainer.layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.8).cgColor
        vwContainer.layer.shadowRadius = 2
        vwContainer.layer.shadowOpacity = 0.8
        vwContainer.layer.shadowOffset = .zero
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
    
    @IBAction func btnMoreAction(_ sender: UIButton){
        btnMoreCallback?(sender.tag)
    }
    
    @IBAction func btnEditAction(_ sender: UIButton){
        btnEditCallback?(sender.tag)
    }
    
}
