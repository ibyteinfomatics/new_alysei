//
//  ImageWithText.swift
//  Alysei
//
//  Created by Gitesh Dang on 24/02/22.
//

import UIKit
import IQKeyboardManagerSwift

class ImageWithText: AlysieBaseViewC {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var chatTextView: IQTextView!
    @IBOutlet weak var sendView: UIView!
    
    @IBOutlet weak var textViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint     : NSLayoutConstraint!

    var image : UIImage?
    var shouldUpdateFocus = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        sendView.layer.cornerRadius = 20
        sendView.layer.borderWidth = 1
        sendView.layer.borderColor = UIColor.lightGray.cgColor
        
        img.image = image
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }
    
    override func dismissKeyboard() {
            view.endEditing(true)
        self.viewBottomConstraint.constant = 20
        }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            IQKeyboardManager.shared.enableAutoToolbar = true
            IQKeyboardManager.shared.enable = true
        }
    
    @IBAction func sendTextMessage(_ sender: Any) {
        
    }

    @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                var keyboardHeight: CGFloat?
                shouldUpdateFocus = true
                if #available(iOS 11.0, *) {
                    keyboardHeight = keyboardRectangle.height - view.safeAreaInsets.bottom
                } else {
                    keyboardHeight = keyboardRectangle.height
                }
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewBottomConstraint.constant = (keyboardHeight ?? 0)
                    self.view.layoutIfNeeded()
                }) { (succeed) in
//                    DispatchQueue.main.async {
//                      //  self.scrollToLastCell()
//                    }
                }
                
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
