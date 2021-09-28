//
//  Receivertextcell.swift
//  Traveller
//
//  Created by fluper on 23/07/19.
//  Copyright © 2019 Fluper. All rights reserved.
//

import UIKit

class Receivertextcell: UITableViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblMsgTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatBoxView: UIView!
    @IBOutlet weak var likeImgView: UIImageView!
    
    //mARK:- OBject
    var DeleteCallBack :(()->())?
    var LikeCallBack :(()->())?
    var LongDeleteCallBack :(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //longpressRight
        let rightPress = UILongPressGestureRecognizer(target: self, action: #selector(longpressRight))
        self.addGestureRecognizer(rightPress)
        
       /* let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        leftSwipe.direction = .left
        self.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        tapGR.numberOfTapsRequired = 1
        likeImgView.addGestureRecognizer(tapGR)*/
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc func longpressRight(longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            self.LongDeleteCallBack?()
                    // your code here, get the row for the indexPath or do whatever you want
        }
            
        
    }
    
    @IBAction func tap_DeleteBtn(_ sender: UIButton) {
        self.DeleteCallBack?()
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer){
        btnDelete.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.lblMsgTrailingConstraint.constant = 25
            self.layoutIfNeeded()
        }
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer){
        self.btnDelete.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.lblMsgTrailingConstraint.constant = 60
            self.layoutIfNeeded()
        }
    }
    
    @objc func handleDoubleTap(gesture: UITapGestureRecognizer){
        self.LikeCallBack?()
    }
    
}
