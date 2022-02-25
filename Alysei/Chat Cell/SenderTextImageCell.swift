//
//  SenderTextImageCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/02/22.
//

import UIKit

class SenderTextImageCell: UITableViewCell {

    @IBOutlet weak var sendimageView: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var saveImgBtn: UIButton!
    var DeleteCallBack :(()->())?
    var openImageCallBack :(()->())?
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
        self.addGestureRecognizer(rightSwipe)*/
        
    }
    
    @objc func longpressRight(longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            self.LongDeleteCallBack?()
                    // your code here, get the row for the indexPath or do whatever you want
        }
            
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func openImageAction(_ sender: UIButton) {
        self.openImageCallBack?()
        
    }
    
    @IBAction func tapOnLike(_ sender: UIButton) {
        
    }
    
    @IBAction func tap_DeleteBtn(_ sender: UIButton) {
        self.DeleteCallBack?()
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer){
        btnDelete.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.imgTrailingConstraint.constant = 50
            self.layoutIfNeeded()
        }
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer){
        
        UIView.animate(withDuration: 0.2) {
            self.imgTrailingConstraint.constant = 15
            self.btnDelete.isHidden = true
            self.layoutIfNeeded()
        }
    }
    
}
