//


import UIKit

class SeemImageVC: UIViewController {
    
      @IBOutlet weak var chatImage : UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var url : String?
    var from : String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let url = URL(string: (self.url ?? ""))
       // chatImage.kf.indicatorType = .activity
        //chatImage.kf.setImage(with:url,placeholder:UIImage(named: "addPicture"))
        
        chatImage.setImage(withString: url!, placeholder: UIImage(named: "gallery_image"))
        
       // let logoTap = UITapGestureRecognizer(target: self, action: #selector(logoTapped(_:)))
       // self.logoImageView.addGestureRecognizer(logoTap)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        if from == "company" {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }

}
