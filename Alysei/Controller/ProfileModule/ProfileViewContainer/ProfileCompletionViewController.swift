//
//  ProfileCompletionViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/14/21.
//

import UIKit

class ProfileCompletionViewController: AlysieBaseViewC {
    
    
    //MARK: - IBOutlet -
    
    @IBOutlet weak var tblViewProfileCompletion: UITableView!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var percentageLabel: UILabel!
    
    //MARK: - Properties -
    
    var currentIndex: Int = 0
    var profileCompletionModel: [ProfileCompletionModel]?
    var signUpViewModel: SignUpViewModel!
    var userType: UserRoles!
    var percentage: String?
    
    //MARK:  - ViewLifeCycle Methods -
    //MARK: - Properties -
    private var editProfileViewCon: EditProfileViewC!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        percentageLabel.text = "\(percentage ?? "0")% completed"
        let floatPercentage = Float(percentage ?? "0") ?? 0
        progressbar.setProgress((floatPercentage/100), animated: false)
        self.postRequestToGetProgress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.postRequestToGetProgress()
    }
    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
    }
    
    //MARK:  - IBAction -
    
    @IBAction func tapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:  - Private Methods -
    
    private func getProfileCompletionTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tblViewProfileCompletion.dequeueReusableCell(withIdentifier: ProfileCompletionTableViewCell.identifier()) as! ProfileCompletionTableViewCell
        cell.delegate = self
        cell.configure(indexPath, currentIndex: self.currentIndex)
        cell.lbleTitle.text = profileCompletionModel?[indexPath.row].title
        //cell.imgViewCircle.image  = profileCompletionModel?[indexPath.row].status == true ? UIImage.init(named: "ProfileCompletion5") : UIImage.init(named: "grey_checked_icon")
        //        if profileCompletionModel?[indexPath.row].status == true  {
        //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                        cell.viewLine.layer.backgroundColor = AppColors.blue.color.cgColor
        //                    }
        //        }else{
        //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                        cell.viewLine.layer.backgroundColor = AppColors.lightGray.color.cgColor
        //                    }
        //        }
        cell.viewLine.isHidden = (indexPath.row == ((profileCompletionModel?.count ?? 0) - 1)) ? true : false
        
        //        switch indexPath.row {
        //                case 0:
        //                    self.currentIndex = 1
        //                   if  profileCompletionModel?[indexPath.row].status == true {
        //                    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                        cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion1")
        //                        //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                            cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#ccccff").cgColor
        //                        }
        //                    })
        //                    }else {
        //                        UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                            cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
        //                            //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                                cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
        //                            }
        //                        })
        //                    }
        //                    self.tblViewProfileCompletion.reloadData()
        //                case 1:
        //                    self.currentIndex = 2
        //                    if  profileCompletionModel?[indexPath.row].status == true {
        //                    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                        cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion2")
        //                        //cell.viewLine.backgroundColor = UIColor.init(hexString: "#9999ff")
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                            cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#9999ff").cgColor
        //                        }
        //                    })
        //                    }else {
        //                        UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                            cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
        //                            //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                                cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
        //                            }
        //                        })
        //                    }
        //                    self.tblViewProfileCompletion.reloadData()
        //                case 2:
        //                    self.currentIndex = 3
        //                    if profileCompletionModel?[indexPath.row].status == true {
        //                    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                        cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion3")
        //                        //cell.viewLine.backgroundColor = UIColor.init(hexString: "#7f7fff")
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                            cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#7f7fff").cgColor
        //                        }
        //                    })
        //                    }else {
        //                        UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                            cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
        //                            //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                                cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
        //                            }
        //                        })
        //                    }
        //                    self.tblViewProfileCompletion.reloadData()
        //                case 3:
        //                    self.currentIndex = 4
        //                       if profileCompletionModel?[indexPath.row].status == true {
        //                    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                        cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion4")
        //                        //cell.viewLine.backgroundColor = UIColor.init(hexString: "00cc00")
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                            cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00cc00").cgColor
        //                        }
        //                    })
        //                       }else{
        //                        UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                            cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
        //                            //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                                cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
        //                            }
        //                        })
        //                       }
        //                    self.tblViewProfileCompletion.reloadData()
        //                case 4:
        //                    self.currentIndex = 5
        //                    if profileCompletionModel?[indexPath.row].status == true {
        //                    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                        cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion5")
        //                        //cell.viewLine.backgroundColor = UIColor.init(hexString: "#00b300")
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                            cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00b300").cgColor
        //                        }
        //                    })
        //                }else{
        //                        UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                            cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
        //                            //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                                cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
        //                            }
        //                        })
        //                       }
        //                    self.tblViewProfileCompletion.reloadData()
        //                case 5:
        //                    self.currentIndex = -1
        //                    if profileCompletionModel?[indexPath.row].status == true {
        //                    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                        cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion6")
        //                        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                        //                cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00b300").cgColor
        //                        //            }
        //                    })
        //                    }else{
        //                        UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //                            cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
        //                            //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //                                cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
        //                            }
        //                        })
        //                       }
        //                    self.tblViewProfileCompletion.reloadData()
        //                default:
        //                    print("")
        //                }
        return cell
    }
    
    //MARK:  - WebService Methods -
    
    private func postRequestToGetProgress() -> Void{
        
        disableWindowInteraction()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProfileProgress, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictRespnose, error, errorType, statusCode) in
            let response = dictRespnose as? [String:Any]
            if let data = response?["data_progress"] as? [[String:Any]]{
                let profileArray = kSharedInstance.getArray(withDictionary: data)
                self.profileCompletionModel = profileArray.map{ProfileCompletionModel(with: $0)}
                
            }
            self.tblViewProfileCompletion.reloadData()
        }
    }
}

//MARK:  - TableViewMethods -

extension ProfileCompletionViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // StaticArrayData.ArrayProducerProfileCompletionDict.count
        return profileCompletionModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.getProfileCompletionTableCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension ProfileCompletionViewController: AnimationProfileCallBack{
    
    func animateViews(_ indexPath: Int, cell: ProfileCompletionTableViewCell) {
        
        //    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
        //      cell.imgViewCircle.layer.backgroundColor = UIColor.white.cgColor
        //      cell.imgViewCircle.layer.borderWidth = 1.0
        //      cell.imgViewCircle.makeCornerRadius(radius: 15.0)
        //      cell.imgViewCircle.layer.borderColor = AppColors.blue.color.cgColor
        //    })
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        //          cell.viewLine.layer.backgroundColor = AppColors.blue.color.cgColor
        //        }
        switch indexPath {
        case 0:
            self.currentIndex = 1
            if  profileCompletionModel?[indexPath].status == true {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion1")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#ccccff").cgColor
                    }
                })
            }else {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
                })
            }
            self.tblViewProfileCompletion.reloadData()
        case 1:
            self.currentIndex = 2
            if  profileCompletionModel?[indexPath].status == true {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion2")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#9999ff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#9999ff").cgColor
                    }
                })
            }else {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
                })
            }
            self.tblViewProfileCompletion.reloadData()
        case 2:
            self.currentIndex = 3
            if  profileCompletionModel?[indexPath].status == true {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion3")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#7f7fff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#7f7fff").cgColor
                    }
                })
            }else {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
                })
            }
            self.tblViewProfileCompletion.reloadData()
        case 3:
            self.currentIndex = 4
            if  profileCompletionModel?[indexPath].status == true {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion4")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "00cc00")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00cc00").cgColor
                    }
                })
            }else {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
                })
            }
            self.tblViewProfileCompletion.reloadData()
        case 4:
            self.currentIndex = 5
            if  profileCompletionModel?[indexPath].status == true {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion5")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#00b300")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00b300").cgColor
                    }
                })
            }else {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
                })
            }
            self.tblViewProfileCompletion.reloadData()
        case 5:
            self.currentIndex = -1
            if  profileCompletionModel?[indexPath].status == true {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "ProfileCompletion6")
                    //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    //                cell.viewLine.layer.backgroundColor = UIColor.init(hexString: "#00b300").cgColor
                    //            }
                })
            }else {
                UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
                    cell.imgViewCircle.image = UIImage.init(named: "grey_checked_icon")
                    //cell.viewLine.backgroundColor = UIColor.init(hexString: "#ccccff")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        cell.viewLine.layer.backgroundColor = UIColor.lightGray.cgColor
                    }
                })
            }
            self.tblViewProfileCompletion.reloadData()
        default:
            print("")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileCompletionModel?[indexPath.row].title {
        case ProfileCompletion.HubSelection :
            let nextVC = CountryListVC()
            editHubValue = "1"
//            nextVC.isEditHub = true
            self.navigationController?.pushViewController(nextVC, animated: true)
        case ProfileCompletion.ContactInfo :
            
            guard let controller = self.storyboard?.instantiateViewController(identifier: "ContactDetailViewController") as? ContactDetailViewController else {return}
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            // let controller = pushViewController(withName: EditProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? EditProfileViewC
            // controller?.signUpViewModel = self.signUpViewModel
            //controller?.userType = self.userType ?? .voyagers
            // self.editProfileViewCon = controller
            guard let controller = self.storyboard?.instantiateViewController(identifier: "EditProfileViewC") as? EditProfileViewC else {return}
            controller.signUpViewModel = self.signUpViewModel
            controller.userType = self.userType ?? .voyagers
            //self.editProfileViewCon = controller
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
}



