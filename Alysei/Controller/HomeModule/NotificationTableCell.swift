//
//  NotificationTableCell.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 21/01/21.
//

import UIKit

class NotificationTableCell: UITableViewCell {
    
    //MARK: - IBOutlet -
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imgViewNotification: UIImageView!
    @IBOutlet weak var photo: NSLayoutConstraint!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var count: UIButton!
    
    //MARK: - Public Methods -
    
    public func configure(){
      
    
        name.text = "Anthony Tran is now connected with you."
        message.text = "few seconds ago"
    }

}
