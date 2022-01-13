//
//  SharePostViewController.swift
//  Alysei
//
//  Created by Janu Gandhi on 20/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SharePostDisplayLogic: class {
    func dismissSelf()
}

class SharePostViewController: UIViewController, SharePostDisplayLogic {
    var interactor: SharePostBusinessLogic?
    var router: (NSObjectProtocol & SharePostRoutingLogic & SharePostDataPassing)?

    // MARK:- Object lifecycle
    var postDataModel: SharePost.PostData.post!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK:- Setup

    private func setup() {
        let viewController = self
        let interactor = SharePostInteractor()
        let presenter = SharePostPresenter()
        let router = SharePostRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK:- View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewHeader.drawBottomShadow()
//        self.imageCollectionView.register

        var name = ""
        if (kSharedUserDefaults.loggedInUserModal.displayName?.count ?? 0) > 0 {
            name = kSharedUserDefaults.loggedInUserModal.displayName ?? ""
        } else if (kSharedUserDefaults.loggedInUserModal.companyName?.count ?? 0) > 0 {
            name = kSharedUserDefaults.loggedInUserModal.companyName ?? ""
        } else if (kSharedUserDefaults.loggedInUserModal.restaurantName?.count ?? 0) > 0 {
            name = kSharedUserDefaults.loggedInUserModal.restaurantName ?? ""
        }
//        let name = (kSharedUserDefaults.loggedInUserModal.displayName?.count ?? 0) > 0 ?  kSharedUserDefaults.loggedInUserModal.displayName : ""
        
//            ((kSharedUserDefaults.loggedInUserModal.companyName?.count > 0) ?  kSharedUserDefaults.loggedInUserModal.companyName :
            // ?? kSharedUserDefaults.loggedInUserModal.companyName ?? kSharedUserDefaults.loggedInUserModal.restaurantName ?? ""
        self.usernameLabel.text = "\(name)"

        if let imageURLString = kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.attachment_url {
            let baseImageUrl = kSharedUserDefaults.loggedInUserModal.UserAvatar_id?.baseUrl ?? ""
            self.userProfileImage.setImage(withString: "\(baseImageUrl)\(imageURLString)")

            self.userProfileImage.contentMode = .scaleAspectFill
            self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.height / 2.0
            self.userProfileImage.layer.masksToBounds = true
            
            self.postOwnerImage.contentMode = .scaleAspectFill
            self.postOwnerImage.layer.cornerRadius = self.userProfileImage.frame.height / 2.0
            self.postOwnerImage.layer.masksToBounds = true

        }

        var postOwner = ""
//        if (self.postDataModel.postOwnerDetail?.name?.count ?? 0) > 0 {
//            postOwner = self.postDataModel.postOwnerDetail?.name ?? ""
//        } else if (self.postDataModel.postOwnerDetail?.companyName?.count ?? 0) > 0 {
//            postOwner = self.postDataModel.postOwnerDetail?.companyName ?? ""
//        } else if (self.postDataModel.postOwnerDetail?.restaurantName?.count ?? 0) > 0 {
//            postOwner = self.postDataModel.postOwnerDetail?.restaurantName ?? ""
//        }
        if self.postDataModel.postOwnerDetail?.roleId == UserRoles.producer.rawValue{
            postOwner = self.postDataModel.postOwnerDetail?.companyName ?? ""
        }else if self.postDataModel.postOwnerDetail?.roleId == UserRoles.restaurant.rawValue{
            postOwner = self.postDataModel.postOwnerDetail?.restaurantName ?? ""
        }else if (self.postDataModel.postOwnerDetail?.roleId == UserRoles.voyagers.rawValue || self.postDataModel.postOwnerDetail?.roleId == UserRoles.voiceExperts.rawValue){
            postOwner = (self.postDataModel.postOwnerDetail?.firstName  ?? "") + (self.postDataModel.postOwnerDetail?.lastName ?? "")
        }else{
            postOwner = self.postDataModel.postOwnerDetail?.companyName ?? ""
        }
        let imgUrl = ((self.postDataModel.postOwnerDetail?.avatarId?.baseUrl ?? "") + ( self.postDataModel.postOwnerDetail?.avatarId?.attachmentUrl ?? ""))
        self.postOwnerImage.setImage(withString: imgUrl)
        self.lblPostDesc.text = self.postDataModel.postDescription
        
        self.postOwnerUsernameLabel.text = "\(postOwner)"

        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self

        self.privacyTextfield.delegate = self
        self.privacyTextfield.addImageToRight("dropdown_selector")
        
    }

    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageCollectionView.reloadData()
    }

    //MARK:- IBOutlets

    @IBOutlet var backButton: UIButtonExtended!
    @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var privacyTextfield: UITextField!
    @IBOutlet var shareableTextLabel: UITextField!
    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet var postOwnerUsernameLabel: UILabel!
    @IBOutlet var lblPostDesc: UILabel!
    @IBOutlet var postOwnerImage: UIImageView!
    @IBOutlet weak var viewHeader: UIView!

    // MARK:- IBAction methods

    @IBAction func backButtonTapped(_ sender: Any) {
//        showAlert(withMessage: "dummy")
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func postButtonTapped(_ sender: Any) {
//        var privacyText = ""
//
//        switch self.privacyTextfield.text  {
//        case "public" :
//            privacyText = "public"
//        }
        let model = SharePost.Share.RequestModel(privacyLabel: "\(self.privacyTextfield.text ?? "")",
                                                 actionType: "post",
                                                 postID: self.postDataModel.postID,
                                                 body: self.shareableTextLabel.text)
        self.interactor?.sharePost(model)

    }
    // MARK:- protocol methods

    func dismissSelf() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SharePostViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.privacyTextfield {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            alertController.addAction(UIAlertAction(title: "Public", style: .default, handler: { (action: UIAlertAction!) in
                self.privacyTextfield.text = "Public"
            }))
            alertController.addAction(UIAlertAction(title: "Followers", style: .default, handler: { (action: UIAlertAction!) in
                self.privacyTextfield.text = "Followers"
            }))

            alertController.addAction(UIAlertAction(title: "Just Me", style: .default, handler: { (action: UIAlertAction!) in
                self.privacyTextfield.text = "Just Me"
            }))

            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))


            self.present(alertController, animated: true, completion: nil)

            return false
        }

        return true
    }


}


extension SharePostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postDataModel.attachments?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SharePostCollectionViewCell else {
            return UICollectionViewCell()
        }

        let imageString = "\((self.postDataModel.attachments?[indexPath.row].attachmentLink?.baseUrl ?? "") + (self.postDataModel.attachments?[indexPath.row].attachmentLink?.attachmentUrl ?? ""))"

        if let url = URL(string: imageString) {
            cell.image.contentMode = .scaleAspectFill
            cell.image.loadImageWithUrl(url)
           // print("size:  \(cell.image.getSize())")
//            cell.image.frame.size = CGSize(width: cell.frame.width, height: cell.frame.height)
//            cell.layoutSubviews()
        }
//        cell.image.setImage(withString: "\(imageString)")
//        cell.image.setImage(withString: "\(imageString)", placeholder: nil) { image in
//            cell.image.image = image
//            cell.image.contentMode = .scaleAspectFit
////            cell.image.sizeToFit()
//        }

//        cell.image.frame = cell.frame
//        DispatchQueue.global(qos: .background).async {
//            let url = URL(string: imageString)!
//            do {
//                let data = try Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    cell.image.image = UIImage(data: data)
//                    cell.image.contentMode = .center
//                    cell.layoutSubviews()
////                    cell.image.sizeToFit()
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }


//        cell.contentView.sizeToFit()
//        cell.sizeToFit()


//        cell.backgroundColor = .green
//        cell.contentView.backgroundColor = .yellow
//        cell.image.backgroundColor = .brown

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: 200.0, height: 200.0)
        let width = collectionView.frame.width
        let height = collectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }

}
