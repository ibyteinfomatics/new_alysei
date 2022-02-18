//
//  UniversalSearchViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 18/11/21.
//

import UIKit

var arraySearchByAward : [AwardDatum]? = []
var searchUniversal = false
var searchTap = false
let titleArrayUniversal = ["People","Blogs","Trips","Events","Posts", "Awards"]
let titleUniversal = ["All","People","Blogs","Trips","Events","Posts", "Awards"]

class UniversalSearchViewController: AlysieBaseViewC {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var bubbleCollectionView: UICollectionView!
    @IBOutlet weak var universalSearchTableView: UITableView!
    @IBOutlet weak var dividerView: UIView!
    
    var currentIndex : Int = -1
    var searchType : Int = 0
    var updatedText = String()
    var loadIndex = 0
    var arraySearchByPeople : [UserDataModel]? = []
    var arraySearchByBolg : [BlogDatum]? = []
    var arraySearchByTrips : [TripDatum]? = []
    var arraySearchByEvents : [EventDatum]? = []
    var arraySearchByPost = [NewFeedSearchDataModel]()
    var indexOfPageToRequest = 1
    var notimodel:NotificationListModel?
    var lastpage: Int?
    var blogLastpage: Int?
    var tripsLastpage: Int?
    var eventsLastpage:Int?
    var postsLastpage: Int?
    var awardsLastPage:Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if searchTap == true{
            getUniversalSearchData(1, updatedText,1)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bubbleCollectionView.delegate = self
        bubbleCollectionView.dataSource = self
        universalSearchTableView.delegate = self
        universalSearchTableView.dataSource = self
        universalSearchTableView.isHidden = true
        dividerView.isHidden = true
        searchTextField.delegate = self
        // self.tabBarController?.tabBar.isHidden = true
        self.dividerView.layer.backgroundColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        universalSearchTableView.register(UINib(nibName: "PeopelTableViewCell", bundle: nil), forCellReuseIdentifier: "PeopelTableViewCell")
        universalSearchTableView.register(UINib(nibName: "BlogTableViewCell", bundle: nil), forCellReuseIdentifier: "BlogTableViewCell")
        universalSearchTableView.register(UINib(nibName: "TripTableViewCell", bundle: nil), forCellReuseIdentifier: "TripTableViewCell")
        universalSearchTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        universalSearchTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        //        universalSearchTableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableViewCell")
        universalSearchTableView.register(UINib(nibName: "AwardTableViewCell", bundle: nil), forCellReuseIdentifier: "AwardTableViewCell")
        //        universalSearchTableView.register(UINib(nibName: "FeaturedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeaturedTableViewCell")
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "seguePostsToSharePost" {
            if let dataModel = sender as? SharePost.PostData.post {
                if let viewCon = segue.destination as? SharePostViewController {
                    viewCon.postDataModel = dataModel
                }
            }
        }
        
        if segue.identifier == "seguePostsToEditPost" {
            if let dataModel = sender as? EditPost.EditData.edit {
                if let viewCon = segue.destination as? EditPostViewController {
                    viewCon.postDataModel = dataModel
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView.drawBottomShadow()
    }
    
    @IBAction func tapBackBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tapCancelBtn(_ sender: Any) {
        self.searchTextField.text = nil
        dividerView.isHidden = true
        searchTap = false
        loadIndex = 0
        searchType = 0
        arraySearchByPeople?.removeAll()
        arraySearchByBolg?.removeAll()
        arraySearchByTrips?.removeAll()
        arraySearchByEvents?.removeAll()
        arraySearchByPost.removeAll()
        universalSearchTableView.reloadData()
        universalSearchTableView.isHidden = true
        bubbleCollectionView.reloadData()
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        if scrollView == universalSearchTableView{
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {
            if searchType == 0 {
                print("No pagination")
            }else{
            if indexOfPageToRequest >= lastpage ?? 0{
                print("No Data")
            }else{
            // increments the number of the page to request
            indexOfPageToRequest += 1

            // call your API for more data
                getUniversalSearchData(1, updatedText, indexOfPageToRequest)
            }
                

            // tell the table view to reload with the new data
            self.universalSearchTableView.reloadData()
            }
        }
        }
    }
   
}

extension UniversalSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titleUniversal.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return self.getBusinessCategoryCollectionCell(indexPath)
    }
    
    private func getBusinessCategoryCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        let businessCategoryCollectionCell = bubbleCollectionView.dequeueReusableCell(withReuseIdentifier: UniversalSearchCollectionViewCell.identifier(), for: indexPath) as! UniversalSearchCollectionViewCell
        
        businessCategoryCollectionCell.configData(indexPath: indexPath, currentIndex: self.currentIndex)
        return businessCategoryCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        self.currentIndex = indexPath.item
        self.loadIndex = indexPath.item
        switch currentIndex {
        case 0:
            self.searchType = 0
            if self.searchTextField.text != ""{
                searchTap = true
                dividerView.isHidden = false
                
                getUniversalSearchData(1, updatedText,1)
                universalSearchTableView.isHidden = false
            }
            else{
                searchTap = false
            }
        case 1:
            self.searchType = 1
            if self.searchTextField.text != ""{
                searchTap = true
                dividerView.isHidden = false
                universalSearchTableView.isHidden = false
                indexOfPageToRequest = 1
                getUniversalSearchData(1, updatedText,1)
                arraySearchByEvents?.removeAll()
                arraySearchByBolg?.removeAll()
                arraySearchByTrips?.removeAll()
                arraySearchByPost.removeAll()
                arraySearchByAward?.removeAll()
            }
            else{
                searchTap = false
            }
        case 2:
            self.searchType = 2
            if self.searchTextField.text != ""{
                searchTap = true
                dividerView.isHidden = false
                universalSearchTableView.isHidden = false
                indexOfPageToRequest = 1
                getUniversalSearchData(1, updatedText,1)
                arraySearchByEvents?.removeAll()
                arraySearchByPeople?.removeAll()
                arraySearchByTrips?.removeAll()
                arraySearchByPost.removeAll()
                arraySearchByAward?.removeAll()
            }
            else{
                searchTap = false
            }
            
        case 3:
            self.searchType = 3
            if self.searchTextField.text != ""{
                searchTap = true
                dividerView.isHidden = false
                universalSearchTableView.isHidden = false
                indexOfPageToRequest = 1
                getUniversalSearchData(1, updatedText,1)
                arraySearchByEvents?.removeAll()
                arraySearchByPeople?.removeAll()
                arraySearchByBolg?.removeAll()
                arraySearchByPost.removeAll()
                arraySearchByAward?.removeAll()
            }
            else{
                searchTap = false
            }
            
        case 4:
            self.searchType = 4
            if self.searchTextField.text != ""{
                searchTap = true
                dividerView.isHidden = false
                universalSearchTableView.isHidden = false
                indexOfPageToRequest = 1
                getUniversalSearchData(1, updatedText,1)
                arraySearchByTrips?.removeAll()
                arraySearchByPeople?.removeAll()
                arraySearchByBolg?.removeAll()
                arraySearchByPost.removeAll()
                arraySearchByAward?.removeAll()
            }
            else{
                searchTap = false
            }
            
        case 5:
            self.searchType = 5
            if self.searchTextField.text != ""{
                searchTap = true
                dividerView.isHidden = false
                universalSearchTableView.isHidden = false
                indexOfPageToRequest = 1
                getUniversalSearchData(1, updatedText,1)
                arraySearchByTrips?.removeAll()
                arraySearchByPeople?.removeAll()
                arraySearchByBolg?.removeAll()
                arraySearchByEvents?.removeAll()
                arraySearchByAward?.removeAll()
            }
            else{
                searchTap = false
            }
        case 6:
            self.searchType = 6
            if self.searchTextField.text != ""{
                searchTap = true
                dividerView.isHidden = false
                universalSearchTableView.isHidden = false
                indexOfPageToRequest = 1
                getUniversalSearchData(1, updatedText,1)
                arraySearchByTrips?.removeAll()
                arraySearchByPeople?.removeAll()
                arraySearchByBolg?.removeAll()
                arraySearchByPost.removeAll()
                arraySearchByEvents?.removeAll()
            }
            else{
                searchTap = false
            }
        default:
            break
        }
        
        bubbleCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.bubbleCollectionView.reloadData()
        self.universalSearchTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.item == 0{
            return CGSize(width: 100 , height: 55.0)
        }
        else{
            return CGSize(width: 150 , height: 55.0)
        }
    }
    
}

//MARK:  - UITableViewMethods -

extension UniversalSearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchType == 0{
            return titleArrayUniversal.count
        }
        else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchType == 0{
            return titleArrayUniversal[section]
        }
        else{
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.layer.backgroundColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            
        }
    }
    func tableView(_ tableView: UITableView,  heightForFooterInSection section: Int) -> CGFloat {
        if searchType == 0{
            switch section{
            case 5:
                return 0
            default:
                return 10
            }
        }
        else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if searchType == 0{
            return 40
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchTap == true{
            switch searchType{
            case 0:
                switch section{
                case 0:
                    if arraySearchByPeople?.count ?? 0 == 0{
                        return 1
                    }
                    else{
                        return arraySearchByPeople?.count ?? 0
                    }
                case 1:
                    if arraySearchByBolg?.count ?? 0 == 0{
                        return 1
                    }
                    else{
                        return arraySearchByBolg?.count ?? 0
                    }
                case 2:
                    if arraySearchByTrips?.count ?? 0 == 0{
                        return 1
                    }
                    else{
                        return arraySearchByTrips?.count ?? 0
                    }
                case 3:
                    if arraySearchByEvents?.count ?? 0 == 0{
                        return 1
                    }
                    else{
                        return arraySearchByEvents?.count ?? 0
                    }
                case 4:
                    if arraySearchByPost.count == 0{
                        return 1
                    }
                    else{
                        return arraySearchByPost.count
                    }
                case 5:
                    return 1
                    
                default:
                    return 1
                }
            case 1:
                if arraySearchByPeople?.count ?? 0 == 0{
                    return 1
                }
                else{
                    return arraySearchByPeople?.count ?? 0
                }
            case 2:
                if arraySearchByBolg?.count ?? 0 == 0{
                    return 1
                }
                else{
                    return arraySearchByBolg?.count ?? 0
                }
            case 3:
                if arraySearchByTrips?.count ?? 0 == 0{
                    return 1
                }
                else{
                    return arraySearchByTrips?.count ?? 0
                }
            case 4:
                if arraySearchByEvents?.count ?? 0 == 0{
                    return 1
                }
                else{
                    return arraySearchByEvents?.count ?? 0
                }
            case 5:
                if arraySearchByPost.count == 0{
                    return 1
                }
                else{
                    return arraySearchByPost.count
                }
            case 6:
                return 1
            default:
                return 1
            }
        }
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = universalSearchTableView.dequeueReusableCell(withIdentifier: PeopelTableViewCell.identifier()) as! PeopelTableViewCell
        let cell2 = universalSearchTableView.dequeueReusableCell(withIdentifier: BlogTableViewCell.identifier()) as! BlogTableViewCell
        let cell3 = universalSearchTableView.dequeueReusableCell(withIdentifier: TripTableViewCell.identifier()) as! TripTableViewCell
        let cell4 = universalSearchTableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier()) as! EventTableViewCell
        //        let cell5 = universalSearchTableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier()) as! CompanyTableViewCell
        guard let cell5 = universalSearchTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier()) as? PostTableViewCell else{return UITableViewCell()}
        let cell6 = universalSearchTableView.dequeueReusableCell(withIdentifier: AwardTableViewCell.identifier()) as! AwardTableViewCell
        //        let cell8 = universalSearchTableView.dequeueReusableCell(withIdentifier: FeaturedTableViewCell.identifier()) as! FeaturedTableViewCell
        if searchTap == true{
            switch searchType{
            case 0:
                switch indexPath.section{
                case 0:
                    
                    if arraySearchByPeople?.count == 0{
                        cell1.noItemLabel.isHidden = false
                        cell1.mainVw.isHidden = true
                    }
                    else{
                        cell1.noItemLabel.isHidden = true
                        cell1.mainVw.isHidden = false
                        
                        
                        if arraySearchByPeople?[indexPath.row].compnyName != "" {
                            cell1.labelPeopleName.text = arraySearchByPeople?[indexPath.row].compnyName
                        } else if arraySearchByPeople?[indexPath.row].first_name != ""{
                            cell1.labelPeopleName.text = (arraySearchByPeople?[indexPath.row].first_name)!+" "+(arraySearchByPeople?[indexPath.row].last_name)!
                        } else {
                            cell1.labelPeopleName.text = arraySearchByPeople?[indexPath.row].restaurantName
                        }
                        
                        cell1.labelPeopleDetail.text = arraySearchByPeople?[indexPath.row].email
                        
                        if arraySearchByPeople?[indexPath.row].roleId == UserRoles.producer.rawValue{
                            cell1.labelPeopleDetail.text = "Producer,"//modelData.subjectId?.email?.lowercased()
                            //notificationTableCell.message.isHidden = false
                        }else if arraySearchByPeople?[indexPath.row].roleId == UserRoles.restaurant.rawValue{
                            //cell1.labelPeopleDetail.isHidden = false
                            cell1.labelPeopleDetail.text = "Restaurant,"//modelData.subjectId?.email?.lowercased()
                        }else if arraySearchByPeople?[indexPath.row].roleId == UserRoles.voyagers.rawValue {
                            
                            cell1.labelPeopleDetail.text = "Voyager"//modelData.subjectId?.email?.lowercased()
                            //notificationTableCell.message.isHidden = true
                        }else if arraySearchByPeople?[indexPath.row].roleId == UserRoles.voiceExperts.rawValue{
                            //notificationTableCell.message.isHidden = false
                            cell1.labelPeopleDetail.text = "Voice Of Experts,"//modelData.subjectId?.email?.lowercased()
                        }else if arraySearchByPeople?[indexPath.row].roleId == UserRoles.distributer1.rawValue {
                            //notificationTableCell.message.isHidden = false
                            cell1.labelPeopleDetail.text = "Importer,"//modelData.subjectId?.email?.lowercased()
                        }else if arraySearchByPeople?[indexPath.row].roleId == UserRoles.distributer2.rawValue{
                            //notificationTableCell.message.isHidden = false
                            cell1.labelPeopleDetail.text = "Distributer,"//modelData.subjectId?.email?.lowercased()
                        }else if arraySearchByPeople?[indexPath.row].roleId == UserRoles.distributer3.rawValue{
                            //notificationTableCell.message.isHidden = false
                            cell1.labelPeopleDetail.text = "Importer & Distributer,"//modelData.subjectId?.email?.lowercased()
                        }else if arraySearchByPeople?[indexPath.row].roleId == UserRoles.travelAgencies.rawValue{
                            //notificationTableCell.message.isHidden = false
                            cell1.labelPeopleDetail.text = "Travel Agencies,"//modelData.subjectId?.email?.lowercased()
                        }
                        
                        cell1.followercount.text = ""
                        
                        if self.arraySearchByPeople?[indexPath.row].avatarId?.imageUrl != nil {
                            cell1.peopleImgView.setImage(withString: String.getString((self.arraySearchByPeople?[indexPath.row].avatarId?.baseUrl ?? "")+(self.arraySearchByPeople?[indexPath.row].avatarId?.imageUrl ?? "")), placeholder: UIImage(named: "image_placeholder"))
                        }
                        
                        cell1.peopleImgView.layer.masksToBounds = false
                        cell1.peopleImgView.clipsToBounds = true
                        cell1.peopleImgView.layer.borderWidth = 2
                        cell1.peopleImgView.layer.borderColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
                        cell1.peopleImgView.layer.cornerRadius = cell1.peopleImgView.frame.width/2
                    }
                    return cell1
                case 1:
                    
                    if arraySearchByBolg?.count == 0{
                        cell2.noItemLabel.isHidden = false
                        cell2.mainVw.isHidden = true
                    }
                    else{
                        cell2.noItemLabel.isHidden = true
                        cell2.mainVw.isHidden = false
                        let imgUrl = ((self.arraySearchByBolg?[indexPath.row].attachment?.baseUrl ?? "") + (self.arraySearchByBolg?[indexPath.row].attachment?.attachmentURL ?? ""))
                        cell2.blogImage.setImage(withString: imgUrl)
                        cell2.blogTitle.text = arraySearchByBolg?[indexPath.row].title
                        cell2.blogDescription.text = arraySearchByBolg?[indexPath.row].datumDescription
                        //cell2.dateTimeLabel.text = arraySearchByBolg?[indexPath.row].createdAt
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        let dateFormatterPrint = DateFormatter()
                        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                        
                        let date: Date? = dateFormatterGet.date(from: arraySearchByBolg?[indexPath.row].createdAt ?? "")
                        print("Date",dateFormatterPrint.string(from: date ?? Date())) // Feb 01,2018
                        let datep = dateFormatterPrint.string(from: date ?? Date())
                        cell2.dateTimeLabel.text = datep
                        cell2.readMoreButton.isHidden = false
                        cell2.readMoreButton.tag = indexPath.row
                        let imageUrl = "\(arraySearchByBolg?[indexPath.row].user?.avatarID?.baseUrl ?? "")" + "\(arraySearchByBolg?[indexPath.row].user?.avatarID?.attachmentURL ?? "")"
                        cell2.userImage.setImage(withString: imageUrl)
                        cell2.btnReadMoreCallback = { tag in
                            
                            check = "show"
                            let vc = self.pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateBlogViewController
                            vc.blogtitle = self.arraySearchByBolg?[indexPath.row].title
                            vc.fulldescription = self.arraySearchByBolg?[indexPath.row].datumDescription
                            vc.draft = self.arraySearchByBolg?[indexPath.row].status
                            vc.imgurl = self.arraySearchByBolg?[indexPath.row].attachment?.attachmentURL ?? ""
                            vc.baseUrl = self.arraySearchByBolg?[indexPath.row].attachment?.baseUrl ?? ""
                            vc.typeofpage = "read"
                            
                        }
                    }
                    
                    return cell2
                case 2:
                    
                    if arraySearchByTrips?.count == 0{
                        cell3.noItemLabel.isHidden = false
                        cell3.mainVw.isHidden = true
                    }
                    else{
                        cell3.noItemLabel.isHidden = true
                        cell1.mainVw.isHidden = false
                        let imgUrl = ((self.arraySearchByTrips?[indexPath.row].attachment?.baseUrl ?? "") + (self.arraySearchByTrips?[indexPath.row].attachment?.attachmentURL ?? ""))
                        cell3.tripImage.setImage(withString: imgUrl)
                        cell3.tripTitle.text = arraySearchByTrips?[indexPath.row].tripName
                        cell3.travelTitle.text = arraySearchByTrips?[indexPath.row].travelAgency
                        // cell3.activitiesTitle.text = arraySearchByTrips?[indexPath.row].datumDescription
                        cell3.locationTitle.text = arraySearchByTrips?[indexPath.row].region?.name
                        
                        if arraySearchByTrips?[indexPath.row].currency == "USD" {
                            cell3.priceTitle.text =  "$" + (arraySearchByTrips?[indexPath.row].price ?? "0")
                        } else if arraySearchByTrips?[indexPath.row].currency == "Euro" {
                            cell3.priceTitle.text =  "€" + (arraySearchByTrips?[indexPath.row].price ?? "0")
                        } else {
                            cell3.priceTitle.text =  "$" + (arraySearchByTrips?[indexPath.row].price ?? "0")
                        }
                        
                        let imageUrl = ("\(arraySearchByTrips?[indexPath.row].user?.avatarID?.baseUrl ?? "")" + "\(arraySearchByTrips?[indexPath.row].user?.avatarID?.attachmentURL ?? "")")
                        cell3.userImage.setImage(withString: imageUrl)
                        
                        cell3.configCell(arraySearchByTrips?[indexPath.row] ?? TripDatum(with: [:]))
                        cell3.lblDuration.text = arraySearchByTrips?[indexPath.row].duration
                        if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 1" {
                            
                            cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            cell3.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            cell3.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            
                        } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 2" {
                            
                            cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            cell3.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            
                        } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 3" {
                            
                            cell3.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            
                        } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 4" {
                            
                            cell3.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                            
                        } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 5" {
                            
                            cell3.view5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            cell3.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                            
                        }
                        
                        
                        //                        if arraySearchByTrips?[indexPath.row].duration == "1 Day" {
                        //
                        //                            cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //
                        //                            cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //
                        //                        } else if arraySearchByTrips?[indexPath.row].duration == "2 Days" {
                        //
                        //                            cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //
                        //                        } else if arraySearchByTrips?[indexPath.row].duration == "3 Days" {
                        //
                        //                            cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //
                        //                        } else if arraySearchByTrips?[indexPath.row].duration == "4 Days" {
                        //
                        //                            cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //
                        //                        } else if arraySearchByTrips?[indexPath.row].duration == "5 Days" {
                        //
                        //                            cell3.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //                            cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //
                        //                        } else if arraySearchByTrips?[indexPath.row].duration == "6 Days" {
                        //
                        //                            cell3.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        //
                        //                        } else if arraySearchByTrips?[indexPath.row].duration == "7 Days" {
                        //
                        //                            cell3.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //                            cell3.duview7.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        //
                        //                        }
                        
                    }
                    return cell3
                case 3:
                    
                    if arraySearchByEvents?.count == 0{
                        cell4.noItemLabel.isHidden = false
                        cell4.mainVw.isHidden = true
                        
                    }
                    else{
                        cell4.noItemLabel.isHidden = true
                        cell1.mainVw.isHidden = false
                        let imgUrl = ((self.arraySearchByEvents?[indexPath.row].attachment?.baseUrl ?? "") + (self.arraySearchByEvents?[indexPath.row].attachment?.attachmenturl ?? ""))
                        cell4.morebutton.tag = indexPath.row
                        cell4.lblLikeCount.text = "\(self.arraySearchByEvents?[indexPath.row].like_counts ?? 0)"
                        cell4.eventImage.setImage(withString: imgUrl)
                        cell4.eventTitle.text = arraySearchByEvents?[indexPath.row].eventName
                        cell4.hostTitle.text = arraySearchByEvents?[indexPath.row].hostName
                        cell4.locationTitle.text = arraySearchByEvents?[indexPath.row].datumDescription
                        //cell4.dateTitle.text = arraySearchByEvents?[indexPath.row].date
                        // cell4.timeTitle.text = arraySearchByEvents?[indexPath.row].time
                        let imgUrlUser = ((self.arraySearchByEvents?[indexPath.row].user?.avatarid?.baseUrl ?? "") + (self.arraySearchByEvents?[indexPath.row].user?.avatarid?.attachmenturl ?? ""))
                        cell4.userImage.setImage(withString: imgUrlUser)
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        let dateFormatterPrint = DateFormatter()
                        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                        
                        let date: Date? = dateFormatterGet.date(from: self.arraySearchByEvents?[indexPath.row].user?.avatarid?.createdAt ?? "")
                        print("Date",dateFormatterPrint.string(from: date ?? Date())) // Feb 01,2018
                        let datep = dateFormatterPrint.string(from: date ?? Date())
                        cell4.dateTitle.text = datep
                        
                        cell4.btnInterested.tag = indexPath.row
                        cell4.configCell(arraySearchByEvents?[indexPath.row] ?? EventDatum(with: [:]))
                        if arraySearchByEvents?[indexPath.row].is_event_liked?.count == 0{
                            cell4.btnInterestedWidth.constant = 180
                            cell4.btnInterested.backgroundColor = UIColor.init(hexString: "37A282")
                            cell4.btnInterested.setTitle("Are you Interested?", for: .normal)
                        }else{
                            cell4.btnInterested.backgroundColor = UIColor.red
                            cell4.btnInterested.setTitle("Uninterested", for: .normal)
                        }
                        cell4.callInterestedCallback = { index in
                            
                            let reloadIndexPath = IndexPath(row: index, section: 0)
                            self.getUniversalSearchData(1, self.updatedText,self.indexOfPageToRequest)
                            self.universalSearchTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
                        }
                        cell4.btnMoreCallback = { tag in
                            
                            let baseUrlImg = self.arraySearchByEvents?[tag].user?.avatarid?.baseUrl ?? ""
                            
                            let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
                            vc.hostname = self.arraySearchByEvents?[tag].hostName
                            vc.eventname = self.arraySearchByEvents?[tag].eventName
                            vc.location = self.arraySearchByEvents?[tag].location
                            vc.date = self.arraySearchByEvents?[tag].date
                            vc.time = self.arraySearchByEvents?[tag].time
                            vc.fulldescription = self.arraySearchByEvents?[tag].datumDescription
                            vc.website = self.arraySearchByEvents?[tag].website
                            vc.eventYype = self.arraySearchByEvents?[tag].eventType
                            vc.registrationType = self.arraySearchByEvents?[tag].registrationType
                            vc.imgurl = String.getString(baseUrlImg + (self.arraySearchByEvents?[tag].attachment?.attachmenturl ?? ""))
                            vc.bookingUrl = self.arraySearchByEvents?[tag].url
                            vc.typeofpage = "read"
                            
                        }
                        cell4.callVisitCallback = { index in
                            
                            let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
                            vc.hostname = self.arraySearchByEvents?[indexPath.row].hostName
                            vc.eventname = self.arraySearchByEvents?[indexPath.row].eventName
                            vc.location = self.arraySearchByEvents?[indexPath.row].location
                            vc.date = self.arraySearchByEvents?[indexPath.row].date
                            vc.time = self.arraySearchByEvents?[indexPath.row].time
                            vc.fulldescription = self.arraySearchByEvents?[indexPath.row].datumDescription
                            vc.website = self.arraySearchByEvents?[indexPath.row].website
                            vc.eventYype = self.arraySearchByEvents?[indexPath.row].eventType
                            vc.registrationType = self.arraySearchByEvents?[indexPath.row].registrationType
                            vc.imgurl = self.arraySearchByEvents?[indexPath.row].attachment?.attachmenturl
                            vc.bookingUrl = self.arraySearchByEvents?[indexPath.row].url
                            vc.typeofpage = "read"
                        }
                    }
                    return cell4
                case 4:
                    
                    if arraySearchByPost.count == 0{
                        cell5.noItemLabel.isHidden = false
                        cell5.containerView.isHidden = true
                    }
                    else{
                        cell5.noItemLabel.isHidden = true
                        cell1.contentView.isHidden = false
                        if arraySearchByPost.count  > indexPath.row {
                            cell5.configCell(arraySearchByPost[indexPath.row], indexPath.row)
                            let data = arraySearchByPost[indexPath.row]
                            cell5.relaodSection = indexPath.section
                            
                            
                            cell5.shareCallback = {
                                
                                self.sharePost(data.postID ?? 0)
                                
                            }
                            
                            cell5.likeCallback = { index in
                                
                                cell5.lblPostLikeCount.text = "\(data.likeCount ?? 0)"
                                cell5.likeImage.image = data.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
                                
                                
                                
                            }
                            //                            cell5.reloadCallBack = { tag, section in
                            //                    let data = self.arraySearchByPost[tag ?? -1]
                            
                            //                    if data.isExpand == false{
                            //                        data.isExpand = true
                            //                    }else{
                            //                        data.isExpand = false
                            //                    }
                            //                                self.universalSearchTableView.reloadData()
                            //                                let indexPath = IndexPath(row: tag ?? -1, section: indexPath.section)
                            //                                self.universalSearchTableView.reloadRows(at: [indexPath], with: .automatic)
                            //                                self.universalSearchTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            //
                            //                            }
                            
                            cell5.menuDelegate = self
                            
                            cell5.commentCallback = { postCommentsUserData in
                                let vc = self.pushViewController(withName: PostCommentsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? PostCommentsViewController
                                vc?.postid = data.postID ?? 0
                            }
                        }
                    }
                    return cell5
                default:
                    
                    if arraySearchByAward?.count == 0{
                        cell6.noItemLabel.isHidden = false
                        
                    }
                    else{
                        cell6.noItemLabel.isHidden = true
                        cell6.openUrlCallBack = { url in
                            let compUrl = URL(string: url )
                            let compt = compUrl ?? URL(string: "")
                            if #available(iOS 10.0, *) {
                                if compt == URL(string: ""){
                                    return
                                }
                                UIApplication.shared.open(compt!, options: [:], completionHandler: nil)
                            } else {
                                if compt == URL(string: ""){
                                    return
                                }
                                UIApplication.shared.openURL(compt!)
                            }
                        }
                        cell6.apiCallback = {
                            if self.indexOfPageToRequest >= self.lastpage ?? 0{
                                print("No Data")
                            }else{
                            // increments the number of the page to request
                                self.indexOfPageToRequest += 1

                            // call your API for more data
                                self.getUniversalSearchData(1, self.updatedText, self.indexOfPageToRequest)
                            }
                            self.universalSearchTableView.reloadData()
                            cell6.awardCollectionView.reloadData()

                        }

                        
                    }
                    return cell6
                }
                
            case 1:
                
                if arraySearchByPeople?.count == 0{
                    cell1.noItemLabel.isHidden = false
                    cell1.mainVw.isHidden = true
                }
                else{
                    cell1.noItemLabel.isHidden = true
                    cell1.mainVw.isHidden = false
                    cell1.labelPeopleName.text = arraySearchByPeople?[indexPath.row].name
                    cell1.labelPeopleDetail.text = arraySearchByPeople?[indexPath.row].email
                    let imgUrl = ((self.arraySearchByPeople?[indexPath.row].avatarId?.baseUrl ?? "") + (self.arraySearchByPeople?[indexPath.row].avatarId?.imageUrl ?? ""))
                    cell1.peopleImgView.layer.masksToBounds = false
                    cell1.peopleImgView.clipsToBounds = true
                    cell1.peopleImgView.layer.borderWidth = 2
                    cell1.peopleImgView.layer.borderColor = UIColor.init(red: 75.0/255.0, green: 179.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
                    cell1.peopleImgView.layer.cornerRadius = cell1.peopleImgView.frame.width/2
                    cell1.peopleImgView.setImage(withString: imgUrl)
                    
                }
                return cell1
            case 2:
                
                if arraySearchByBolg?.count == 0{
                    cell2.noItemLabel.isHidden = false
                    cell2.mainVw.isHidden = true
                }
                else{
                    cell2.noItemLabel.isHidden = true
                    cell2.mainVw.isHidden = false
                    let imgUrl = ((self.arraySearchByBolg?[indexPath.row].attachment?.baseUrl ?? "") + (self.arraySearchByBolg?[indexPath.row].attachment?.attachmentURL ?? ""))
                    cell2.blogImage.setImage(withString: imgUrl)
                    cell2.blogTitle.text = arraySearchByBolg?[indexPath.row].title
                    cell2.blogDescription.text = arraySearchByBolg?[indexPath.row].datumDescription
                    //cell2.dateTimeLabel.text = arraySearchByBolg?[indexPath.row].createdAt
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                    
                    let date: Date? = dateFormatterGet.date(from: arraySearchByBolg?[indexPath.row].createdAt ?? "")
                    print("Date",dateFormatterPrint.string(from: date ?? Date())) // Feb 01,2018
                    let datep = dateFormatterPrint.string(from: date ?? Date())
                    cell2.dateTimeLabel.text = datep
                    cell2.readMoreButton.isHidden = false
                    cell2.readMoreButton.tag = indexPath.row
                    let imageUrl = "\(arraySearchByBolg?[indexPath.row].user?.avatarID?.baseUrl ?? "")" + "\(arraySearchByBolg?[indexPath.row].user?.avatarID?.attachmentURL ?? "")"
                    cell2.userImage.setImage(withString: imageUrl)
                    cell2.btnReadMoreCallback = { tag in
                        
                        check = "show"
                        let vc = self.pushViewController(withName: CreateBlogViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateBlogViewController
                        vc.blogtitle = self.arraySearchByBolg?[indexPath.row].title
                        vc.fulldescription = self.arraySearchByBolg?[indexPath.row].datumDescription
                        vc.draft = self.arraySearchByBolg?[indexPath.row].status
                        vc.imgurl = self.arraySearchByBolg?[indexPath.row].attachment?.attachmentURL ?? ""
                        vc.baseUrl = self.arraySearchByBolg?[indexPath.row].attachment?.baseUrl ?? ""
                        vc.typeofpage = "read"
                        
                    }
                }
                return cell2
            case 3:
                
                if arraySearchByTrips?.count == 0{
                    cell3.noItemLabel.isHidden = false
                    cell3.mainVw.isHidden = true
                    
                }
                else{
                    cell3.noItemLabel.isHidden = true
                    cell3.mainVw.isHidden = false
                    
                    let imgUrl = ((self.arraySearchByTrips?[indexPath.row].attachment?.baseUrl ?? "") + (self.arraySearchByTrips?[indexPath.row].attachment?.attachmentURL ?? ""))
                    cell3.tripImage.setImage(withString: imgUrl)
                    cell3.tripTitle.text = arraySearchByTrips?[indexPath.row].tripName
                    cell3.travelTitle.text = arraySearchByTrips?[indexPath.row].travelAgency
                    // cell3.activitiesTitle.text = arraySearchByTrips?[indexPath.row].datumDescription
                    cell3.locationTitle.text = arraySearchByTrips?[indexPath.row].region?.name
                    
                    if arraySearchByTrips?[indexPath.row].currency == "USD" {
                        cell3.priceTitle.text =  "$" + (arraySearchByTrips?[indexPath.row].price ?? "0")
                    } else if arraySearchByTrips?[indexPath.row].currency == "Euro" {
                        cell3.priceTitle.text =  "€" + (arraySearchByTrips?[indexPath.row].price ?? "0")
                    } else {
                        cell3.priceTitle.text =  "$" + (arraySearchByTrips?[indexPath.row].price ?? "0")
                    }
                    
                    cell3.lblDuration.text = arraySearchByTrips?[indexPath.row].duration
                    cell3.configCell(arraySearchByTrips?[indexPath.row] ?? TripDatum(with: [:]))
                    let imageUrl = ("\(arraySearchByTrips?[indexPath.row].user?.avatarID?.baseUrl ?? "")" + "\(arraySearchByTrips?[indexPath.row].user?.avatarID?.attachmentURL ?? "")")
                    cell3.userImage.setImage(withString: imageUrl)
                    if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 1" {
                        
                        cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        cell3.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        cell3.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        
                    } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 2" {
                        
                        cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        cell3.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        
                    } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 3" {
                        
                        cell3.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        
                    } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 4" {
                        
                        cell3.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                        
                    } else if arraySearchByTrips?[indexPath.row].intensity?.intensity == "Level 5" {
                        
                        cell3.view5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        cell3.view4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                        
                    }
                    
                    
                    //                    if arraySearchByTrips?[indexPath.row].duration == "1 Day" {
                    //
                    //                        cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview2.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //
                    //                        cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //
                    //                    } else if arraySearchByTrips?[indexPath.row].duration == "2 Days" {
                    //
                    //                        cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview3.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //
                    //                    } else if arraySearchByTrips?[indexPath.row].duration == "3 Days" {
                    //
                    //                        cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview4.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //
                    //                    } else if arraySearchByTrips?[indexPath.row].duration == "4 Days" {
                    //
                    //                        cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview5.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //
                    //                    } else if arraySearchByTrips?[indexPath.row].duration == "5 Days" {
                    //
                    //                        cell3.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview6.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //                        cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //
                    //                    } else if arraySearchByTrips?[indexPath.row].duration == "6 Days" {
                    //
                    //                        cell3.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview7.layer.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
                    //
                    //                    } else if arraySearchByTrips?[indexPath.row].duration == "7 Days" {
                    //
                    //                        cell3.duview5.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview1.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview2.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview3.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview4.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview6.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                        cell3.duview7.layer.backgroundColor = UIColor.init(red: 75/255, green: 179/255, blue: 253/255, alpha: 1).cgColor
                    //                    }
                }
                
                return cell3
                
            case 4:
                
                if arraySearchByEvents?.count == 0{
                    cell4.noItemLabel.isHidden = false
                    cell4.mainVw.isHidden = true
                    
                }
                else{
                    cell4.noItemLabel.isHidden = true
                    cell4.mainVw.isHidden = false
                    cell4.morebutton.tag = indexPath.row
                    let imgUrl = ((self.arraySearchByEvents?[indexPath.row].attachment?.baseUrl ?? "") + (self.arraySearchByEvents?[indexPath.row].attachment?.attachmenturl ?? ""))
                    cell4.eventImage.setImage(withString: imgUrl)
                    cell4.eventTitle.text = arraySearchByEvents?[indexPath.row].eventName
                    cell4.hostTitle.text = arraySearchByEvents?[indexPath.row].hostName
                    cell4.locationTitle.text = arraySearchByEvents?[indexPath.row].datumDescription
                    //cell4.dateTitle.text = arraySearchByEvents?[indexPath.row].date
                    cell4.lblLikeCount.text = "\(self.arraySearchByEvents?[indexPath.row].like_counts ?? 0)"
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                    
                    let date: Date? = dateFormatterGet.date(from: arraySearchByEvents?[indexPath.row].createdAt ?? "")
                    print("Date",dateFormatterPrint.string(from: date ?? Date())) // Feb 01,2018
                    let datep = dateFormatterPrint.string(from: date ?? Date())
                    cell4.dateTitle.text = datep
                    cell4.timeTitle.text = arraySearchByEvents?[indexPath.row].time
                    let imageUrl = ((arraySearchByEvents?[indexPath.row].user?.avatarid?.baseUrl ?? "") + (arraySearchByEvents?[indexPath.row].user?.avatarid?.attachmenturl ?? ""))
                    cell4.userImage.setImage(withString: imageUrl)
                    cell4.userImage.layer.cornerRadius =  cell4.userImage.frame.height / 2
                    cell4.userImage.layer.masksToBounds = true
                    cell4.btnInterested.tag = indexPath.row
                    
                    cell4.configCell(arraySearchByEvents?[indexPath.row] ?? EventDatum(with: [:]))
                    if arraySearchByEvents?[indexPath.row].is_event_liked?.count == 0{
                        cell4.btnInterestedWidth.constant = 180
                        cell4.btnInterested.backgroundColor = UIColor.init(hexString: "37A282")
                        cell4.btnInterested.setTitle("Are you Interested?", for: .normal)
                    }else{
                        cell4.btnInterested.backgroundColor = UIColor.red
                        cell4.btnInterested.setTitle("Uninterested", for: .normal)
                    }
                    cell4.callInterestedCallback = { index in
                        
                        let reloadIndexPath = IndexPath(row: index, section: 0)
                        self.getUniversalSearchData(1, self.updatedText,self.indexOfPageToRequest)
                        self.universalSearchTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
                    }
                    cell4.btnMoreCallback = { tag in
                        
                        let baseUrlImg = self.arraySearchByEvents?[tag].user?.avatarid?.baseUrl ?? ""
                        
                        let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
                        vc.hostname = self.arraySearchByEvents?[tag].hostName
                        vc.eventname = self.arraySearchByEvents?[tag].eventName
                        vc.location = self.arraySearchByEvents?[tag].location
                        vc.date = self.arraySearchByEvents?[tag].date
                        vc.time = self.arraySearchByEvents?[tag].time
                        vc.fulldescription = self.arraySearchByEvents?[tag].datumDescription
                        vc.website = self.arraySearchByEvents?[tag].website
                        vc.eventYype = self.arraySearchByEvents?[tag].eventType
                        vc.registrationType = self.arraySearchByEvents?[tag].registrationType
                        vc.imgurl = String.getString(baseUrlImg + (self.arraySearchByEvents?[tag].attachment?.attachmenturl ?? ""))
                        vc.bookingUrl = self.arraySearchByEvents?[tag].url
                        vc.typeofpage = "read"
                        
                    }
                    cell4.callVisitCallback = { index in
                        
                        let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
                        vc.hostname = self.arraySearchByEvents?[indexPath.row].hostName
                        vc.eventname = self.arraySearchByEvents?[indexPath.row].eventName
                        vc.location = self.arraySearchByEvents?[indexPath.row].datumDescription
                        vc.date = self.arraySearchByEvents?[indexPath.row].date
                        vc.time = self.arraySearchByEvents?[indexPath.row].time
                        vc.fulldescription = self.arraySearchByEvents?[indexPath.row].datumDescription
                        vc.website = self.arraySearchByEvents?[indexPath.row].website
                        vc.eventYype = self.arraySearchByEvents?[indexPath.row].eventType
                        vc.registrationType = self.arraySearchByEvents?[indexPath.row].registrationType
                        vc.imgurl = self.arraySearchByEvents?[indexPath.row].attachment?.attachmenturl
                        vc.bookingUrl = self.arraySearchByEvents?[indexPath.row].url
                        vc.baseUrl = self.arraySearchByEvents?[indexPath.row].attachment?.baseUrl
                        vc.typeofpage = "read"
                    }
                }
                return cell4
            case 5:
                
                if arraySearchByPost.count == 0{
                    cell5.noItemLabel.isHidden = false
                    cell5.containerView.isHidden = true
                }
                else{
                    cell5.noItemLabel.isHidden = true
                    cell5.containerView.isHidden = false
                    if arraySearchByPost.count  > indexPath.row {
                        cell5.configCell(arraySearchByPost[indexPath.row], indexPath.row)
                        let data = arraySearchByPost[indexPath.row]
                        cell5.relaodSection = indexPath.section
                        
                        cell5.shareCallback = {
                            
                            self.sharePost(data.postID ?? 0)
                            
                        }
                        
                        cell5.likeCallback = { index in
                            
                            cell5.lblPostLikeCount.text = "\(data.likeCount ?? 0)"
                            cell5.likeImage.image = data.likeFlag == 0 ? UIImage(named: "icons8_heart") : UIImage(named: "liked_icon")
                            
                            
                            
                        }
                        //                        cell5.reloadCallBack = { tag, section in
                        //                    let data = self.arraySearchByPost[tag ?? -1]
                        
                        //                    if data.isExpand == false{
                        //                        data.isExpand = true
                        //                    }else{
                        //                        data.isExpand = false
                        //                    }
                        //                            self.universalSearchTableView.reloadData()
                        //                            let indexPath = IndexPath(row: tag ?? -1, section: indexPath.section)
                        //                            self.universalSearchTableView.reloadRows(at: [indexPath], with: .automatic)
                        //                            self.universalSearchTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        //
                        //                        }
                        
                        cell5.menuDelegate = self
                        
                        cell5.commentCallback = { postCommentsUserData in
                            let vc = self.pushViewController(withName: PostCommentsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as? PostCommentsViewController
                            vc?.postid = data.postID ?? 0
                        }
                    }
                }
                return cell5
            default:
                if arraySearchByAward?.count == 0{
                    cell6.noItemLabel.isHidden = false
                }
                else{
                    cell6.noItemLabel.isHidden = true
                    cell6.openUrlCallBack = { url in
                        let compUrl = URL(string: url )
                        let compt = compUrl ?? URL(string: "")
                        if #available(iOS 10.0, *) {
                            if compt == URL(string: ""){
                                return
                            }
                            UIApplication.shared.open(compt!, options: [:], completionHandler: nil)
                        } else {
                            if compt == URL(string: ""){
                                return
                            }
                            UIApplication.shared.openURL(compt!)
                        }
                    }
                    cell6.apiCallback = {
                        if self.indexOfPageToRequest >= self.lastpage ?? 0{
                            print("No Data")
                        }else{
                        // increments the number of the page to request
                            self.indexOfPageToRequest += 1

                        // call your API for more data
                            self.getUniversalSearchData(1, self.updatedText, self.indexOfPageToRequest)
                        }
                        self.universalSearchTableView.reloadData()
                        cell6.awardCollectionView.reloadData()

                    }
                }
                return cell6
            }
        }
        
        return cell6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchTap == true{
            switch searchType{
            case 0:
                switch indexPath.section {
                case 0:
                    
                    if arraySearchByPeople?.count == 0{
                        return 80
                    }
                    else{
                        return 80
                    }
                    
                case 1:
                    if arraySearchByBolg?.count == 0{
                        return 80
                    }
                    else{
                        return UITableView.automaticDimension
                    }
                case 2:
                    if arraySearchByTrips?.count == 0{
                        return 80
                    }
                    else{
                        return UITableView.automaticDimension
                    }
                case 3:
                    if arraySearchByEvents?.count == 0{
                        return 80
                    }
                    else{
                        return UITableView.automaticDimension
                    }
                case 4:
                    if arraySearchByPost.count == 0{
                        return 80
                    }
                    else{
                        return 380
                    }
                case 5:
                    if arraySearchByAward?.count == 0{
                        return 80
                    }
                    else{
                        return 280
                    }
                default:
                    return 150
                }
            case 1:
                return 80
            case 2:
                return UITableView.automaticDimension
            case 3:
                return UITableView.automaticDimension
            case 4:
                return UITableView.automaticDimension
            case 5:
                return 380
            case 6:
                return 280
                
            default:
                break
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchType == 0{
            switch indexPath.section {
            case 0:
                let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
                //controller?.userLevel = .other
                if kSharedUserDefaults.loggedInUserModal.userId == "\(self.arraySearchByPeople?[indexPath.row].userId ?? 0)" {
                    controller?.userLevel = .own
                }else{
                    controller?.userLevel = .other
                }
                controller?.userID = self.arraySearchByPeople?[indexPath.row].userId
            case 1:
                return
            case 2:
                
                tripTab(indexPath: indexPath)
                
                
            case 3:
                print("Event tab")
                // eventTab(indexPath: indexPath)
                
                
            case 4:
                return
            case 5:
                let controller = pushViewController(withName: AddAward.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddAward
                controller?.award_id = arraySearchByAward?[indexPath.row].awardid
            default:
                break
            }
        }
        else if searchType == 1{
            let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
           // controller?.userLevel = .other
            if kSharedUserDefaults.loggedInUserModal.userId == "\(self.arraySearchByPeople?[indexPath.row].userId ?? 0)" {
                controller?.userLevel = .own
            }else{
                controller?.userLevel = .other
            }
            controller?.userID = self.arraySearchByPeople?[indexPath.row].userId
        }
        else if searchType == 2{
            return
        }
        else if searchType == 3{
            tripTab(indexPath: indexPath)
        }
        else if searchType == 4{
            //  eventTab(indexPath: indexPath)
        }
        else if searchType == 5{
            return
        }
        else if searchType == 6{
            return
            
        }
    }
    
}

extension UniversalSearchViewController: EditMenuProtocol {
    
    
    
    func menuBttonTapped(_ postID: Int?, userID: Int) {
        
        guard let postID = postID else {
            return
        }
        let actionSheet = UIAlertController(style: .actionSheet)
        
        let shareAction = UIAlertAction(title: "Share Post", style: .default) { action in
            self.sharePost(postID)
        }
        
        let editPostAction = UIAlertAction(title: "Edit Post", style: .default) { action in
            self.editPost(postID)
        }
        
        let deletePost = UIAlertAction(title: "Delete Post", style: .destructive) { action in
            self.deletePost(postID)
        }
        
        let reportAction = UIAlertAction(title: "Report Action", style: .destructive) { action in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        
        
        if let loggedInUserID = kSharedUserDefaults.loggedInUserModal.userId {
            if Int(loggedInUserID) == userID {
                actionSheet.addAction(shareAction)
                actionSheet.addAction(editPostAction)
                // actionSheet.addAction(changePrivacyAction)
                actionSheet.addAction(deletePost)
            } else {
                actionSheet.addAction(shareAction)
                actionSheet.addAction(reportAction)
            }
        }
        
        actionSheet.addAction(cancelAction)
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func deletePost(_ postID: Int) {
        
        let url = APIUrl.Posts.deletePost
        guard var urlRequest = WebServices.shared.buildURLRequest(url, method: .POST) else {
            return
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let model = Post.delete(postID: postID)
            let body = try JSONEncoder().encode(model)
            
            urlRequest.httpBody = body
            WebServices.shared.request(urlRequest) { data, urlResponse, statusCode, error in
                if (statusCode ?? 0) >= 400 {
                    self.showAlert(withMessage: "Some error occured")
                } else {
                    
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editPost(_ postID: Int) {
        let data = arraySearchByPost.filter({ $0.postID == postID })
        if let editData = data.first {
            let editPostDataModel = EditPost.EditData.edit(attachments: editData.attachments,
                                                           postOwnerDetail: editData.subjectId,
                                                           postDescription: "\(editData.body ?? "")",
                                                           postID: postID)
            self.performSegue(withIdentifier: "seguePostsToEditPost", sender: editPostDataModel)
        }
    }
    
    func sharePost(_ postID: Int) {
        let data = arraySearchByPost.filter({ $0.postID == postID })
        if let searchDataModel = data.first {
            let sharePostDataModel = SharePost.PostData.post(attachments: searchDataModel.attachments,
                                                             postOwnerDetail: searchDataModel.subjectId,
                                                             postDescription: "\(searchDataModel.body ?? "")",
                                                             postID: postID)
            
            self.performSegue(withIdentifier: "seguePostsToSharePost", sender: sharePostDataModel)
        }
    }
    
}

extension UniversalSearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.becomeFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange,
                                                      with: string)
            
            if updateText.count > 0 {
                searchUniversal = true
                searchTap = true
                currentIndex = loadIndex
                updatedText = updateText
                dividerView.isHidden = false
                universalSearchTableView.isHidden = false
                
                getUniversalSearchData(1, updateText,1)
                bubbleCollectionView.reloadData()
            }
            else{
                searchUniversal = false
                searchTap = false
                loadIndex = 0
                dividerView.isHidden = true
                universalSearchTableView.isHidden = true
                universalSearchTableView.reloadData()
                bubbleCollectionView.reloadData()
            }
        }
        
        
        return true
    }
}
extension UniversalSearchViewController{
    
    func tripTab(indexPath: IndexPath){
        let vc = self.pushViewController(withName: CreateTripsViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateTripsViewController
        vc.tripname = self.arraySearchByTrips?[indexPath.row].tripName
        vc.agency = self.arraySearchByTrips?[indexPath.row].travelAgency
        vc.duration = self.arraySearchByTrips?[indexPath.row].duration
        vc.adventure = self.arraySearchByTrips?[indexPath.row].adventure?.adventureType
        vc.trip_id = self.arraySearchByTrips?[indexPath.row].tripID
        vc.intensity = self.arraySearchByTrips?[indexPath.row].intensity?.intensity
        vc.country = self.arraySearchByTrips?[indexPath.row].country?.name
        vc.region = self.arraySearchByTrips?[indexPath.row].region?.name
        vc.website = self.arraySearchByTrips?[indexPath.row].website
        vc.price = self.arraySearchByTrips?[indexPath.row].price
        vc.fulldescription = self.arraySearchByTrips?[indexPath.row].datumDescription
        vc.imgurl = self.arraySearchByTrips?[indexPath.row].attachment?.attachmentURL
        vc.baseURL = self.arraySearchByTrips?[indexPath.row].attachment?.baseUrl
        vc.currency = self.arraySearchByTrips?[indexPath.row].currency
        vc.typeofpage = "read"
    }
    
    func eventTab(indexPath: IndexPath){
        let vc = self.pushViewController(withName: CreateEventViewController.id(), fromStoryboard: StoryBoardConstants.kHome) as! CreateEventViewController
        vc.hostname = self.arraySearchByEvents?[indexPath.row].hostName
        vc.eventname = self.arraySearchByEvents?[indexPath.row].eventName
        vc.location = self.arraySearchByEvents?[indexPath.row].datumDescription
        vc.date = self.arraySearchByEvents?[indexPath.row].date
        vc.time = self.arraySearchByEvents?[indexPath.row].time
        vc.fulldescription = self.arraySearchByEvents?[indexPath.row].datumDescription
        vc.website = self.arraySearchByEvents?[indexPath.row].website
        vc.eventYype = self.arraySearchByEvents?[indexPath.row].eventType
        vc.registrationType = self.arraySearchByEvents?[indexPath.row].registrationType
        vc.imgurl = self.arraySearchByEvents?[indexPath.row].attachment?.attachmenturl
        vc.baseUrl = self.arraySearchByEvents?[indexPath.row].attachment?.baseUrl
        vc.bookingUrl = self.arraySearchByEvents?[indexPath.row].url
        
        vc.typeofpage = "read"
    }
    
    func getUniversalSearchData(_ searchType: Int?, _ keyword: String?,_ pageNo: Int?){
        
        let originalUrl = APIUrl.Posts.searchUniversal + "\(searchType ?? 0)" + "&keyword=" + "\(keyword ?? "")" + "&page=\(pageNo ?? 1)"
        TANetworkManager.sharedInstance.requestApi(withServiceName: originalUrl
                                                   , requestMethod: .GET, requestParameters: [:], withProgressHUD: true){ [self] (dictResponse, error, errorType, statusCode) in
            
            
            let dictResponse = dictResponse as? [String:Any]
            
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.notimodel = NotificationListModel.init(with: dictResponse)
                if let people = data["peoples"] as? [String:Any]{
                    if self.searchType == 1{
                    self.lastpage = people["last_page"] as? Int
                    }
                    if let people2 = people["data"] as? [[String:Any]]{
                        let people1 = people2.map({UserDataModel.init(with: $0)})
                        //arraySearchByPeople = people1
                        if indexOfPageToRequest == 1 {self.arraySearchByPeople?.removeAll()}
                        arraySearchByPeople?.append(contentsOf: people1)
                        print("\(String(describing: arraySearchByPeople?.count))")
                    }
                }
                
                if let posts = data["posts"] as? [String:Any]{
                    if self.searchType == 5{
                    self.lastpage = posts["last_page"] as? Int
                    }
                    if let post1 = posts["data"] as? [[String:Any]]{
                        let post = post1.map({NewFeedSearchDataModel.init(with: $0)})
                        //arraySearchByPost = post
                        if indexOfPageToRequest == 1 {self.arraySearchByPost.removeAll()}
                        arraySearchByPost.append(contentsOf: post)
                        print("\(String(describing: arraySearchByPost.count))")
                    }
                }
                
                if let events = data["events"] as? [String:Any]{
                    if self.searchType == 4{
                    self.lastpage = events["last_page"] as? Int
                    }
                    if let events1 = events["data"] as? [[String:Any]]{
                        let event = events1.map({EventDatum.init(with: $0)})
                      //  arraySearchByEvents = event
                        if indexOfPageToRequest == 1 {self.arraySearchByEvents?.removeAll()}
                        arraySearchByEvents?.append(contentsOf: event)
                        print("\(String(describing: arraySearchByEvents?.count))")
                    }
                }
                
                if let blogs = data["blogs"] as? [String:Any]{
                    if self.searchType == 2{
                    self.lastpage = blogs["last_page"] as? Int
                    }
                    if let blogs1 = blogs["data"] as? [[String:Any]]{
                        let blog = blogs1.map({BlogDatum.init(with: $0)})
                        //arraySearchByBolg = blog
                        if indexOfPageToRequest == 1 {self.arraySearchByBolg?.removeAll()}
                        arraySearchByBolg?.append(contentsOf: blog)
                        print("\(String(describing: arraySearchByBolg?.count))")
                        
                    }
                }
                
                if let trips = data["trips"] as? [String:Any]{
                    if self.searchType == 3{
                    self.lastpage = trips["last_page"] as? Int
                    }
                    if let trips1 = trips["data"] as? [[String:Any]]{
                        let trip = trips1.map({TripDatum.init(with: $0)})
                       // arraySearchByTrips = trip
                        if indexOfPageToRequest == 1 {self.arraySearchByTrips?.removeAll()}
                        arraySearchByTrips?.append(contentsOf: trip)
                        print("\(String(describing: arraySearchByTrips?.count))")
                    }
                }
                
                if let awards = data["awards"] as? [String:Any]{
                    if self.searchType == 6{
                    self.lastpage = awards["last_page"] as? Int
                    }
                    if let award1 = awards["data"] as? [[String:Any]]{
                        let award = award1.map({AwardDatum.init(with: $0)})
                       // arraySearchByAward = award
                        if indexOfPageToRequest == 1 {arraySearchByAward?.removeAll()}
                        arraySearchByAward?.append(contentsOf: award)
                        print("\(String(describing: arraySearchByAward?.count))")
                    }
                }
                
            }
            universalSearchTableView.reloadData()
            
        }
    }
}
