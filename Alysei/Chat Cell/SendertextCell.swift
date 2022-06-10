//
//  SendertextCell.swift
//  Traveller
//
//  Created by fluper on 23/07/19.
//  Copyright © 2019 Fluper. All rights reserved.
//

import UIKit

class SendertextCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet var blueTickBtn: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblMsgTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tickImgView: UIImageView!
    @IBOutlet weak var likeImgView: UIImageView!
    
    //mARK:- OBject
    var DeleteCallBack :(()->())?
    var LikeCallBack :(()->())?
    var LongDeleteCallBack :(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        leftSwipe.direction = .left
        self.addGestureRecognizer(leftSwipe)*/
        
        //longpressRight
        let rightPress = UILongPressGestureRecognizer(target: self, action: #selector(longpressRight))
        self.addGestureRecognizer(rightPress)
        
        
        /*let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        tapGR.numberOfTapsRequired = 2
        bgView.addGestureRecognizer(tapGR)*/
    }
    func configCell(_ messages: OpenModel){
     likeImgView.isHidden = true
        let companyName = messages.sender?.companyName ?? ""
     let email = messages.sender?.email ?? ""
     let phone = messages.sender?.phone ?? ""
     let message = messages.message ?? ""
     lblMessage.text = ((companyName) + "\n" + (email) + "\n" + (phone) + (message))
     let timeInterval  = messages.created_at ?? ""
     print("timeInterval----------------------",timeInterval)
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
     dateFormatter.locale = Locale(identifier: "en")
     let date = dateFormatter.date(from: timeInterval)
     let newDateFormatter = DateFormatter()
     newDateFormatter.dateFormat = "HH:mm a"
     let dateString = newDateFormatter.string(from: date ?? Date())
     print("formatted date is =  \(dateString)")
     lbltime.text = dateString
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func tap_DeleteBtn(_ sender: UIButton) {
        self.DeleteCallBack?()
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer){
        btnDelete.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.lblMsgTrailingConstraint.constant = 60
            self.layoutIfNeeded()
        }
    }
    
    @objc func longpressRight(longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            self.LongDeleteCallBack?()
                    // your code here, get the row for the indexPath or do whatever you want
        }
            
        
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer){
        UIView.animate(withDuration: 0.2) {
            self.lblMsgTrailingConstraint.constant = 25
            self.btnDelete.isHidden = true
            self.layoutIfNeeded()
        }
    }
    
    @objc func handleDoubleTap(gesture: UITapGestureRecognizer){
        self.LikeCallBack?()
    }
    
}
