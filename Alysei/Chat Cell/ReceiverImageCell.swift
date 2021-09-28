//
//  ReceiverImageCell.swift
//  Traveller
//
//  Created by fluper on 23/07/19.
//  Copyright © 2019 Fluper. All rights reserved.
//

import UIKit

class ReceiverImageCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet weak var receiveimageView: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewSaveImage: UIView!
    @IBOutlet weak var saveImgBtn: UIButton!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    
    var DeleteCallBack :(()->())?
    var openImageCallBack :(()->())?
    var saveImageCallBack:(()->())?
    var likeImagecallback:(()->())?
    var LongDeleteCallBack :(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //longpressRight
        let rightPress = UILongPressGestureRecognizer(target: self, action: #selector(longpressRight))
        self.addGestureRecognizer(rightPress)
        
        /*let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        leftSwipe.direction = .left
        self.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressOnSaveBtn(_:)))
        saveImgBtn.addGestureRecognizer(longGesture)*/
    }
    
    @objc func longpressRight(longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            self.LongDeleteCallBack?()
                    // your code here, get the row for the indexPath or do whatever you want
        }
            
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        self.likeImagecallback?()
    }
    
    @IBAction func tap_DeleteBtn(_ sender: UIButton) {
        self.DeleteCallBack?()
    }
    
    @IBAction func tap_ImageBtn(_ sender: UIButton) {
        if viewSaveImage.isHidden {
            self.openImageCallBack?()
        }else {
            viewSaveImage.isHidden = true
        }
    }
    
    @IBAction func tap_SaveImageBtn(_ sender: UIButton) {
        self.saveImageCallBack?()        
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer){
        btnDelete.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.imageLeadingConstraint.constant = 15
            self.layoutIfNeeded()
        }
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer){
        self.btnDelete.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.imageLeadingConstraint.constant = 50
            self.layoutIfNeeded()
        }
    }
    
    @objc func longPressOnSaveBtn(_ guesture: UILongPressGestureRecognizer) {
        if guesture.state == .began {
            print_debug(items: "Long Press started")
            viewSaveImage.isHidden = false
            
        }else if guesture.state == .ended {
            print_debug(items: "Long Press Ended")
        }
    }
}
