//
//  RoleViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 13/01/21.
//

import UIKit


class RoleViewC: AlysieBaseViewC {

  //MARK:  - IBOutlet -
  
  @IBOutlet weak var collectionViewRole: UICollectionView!
  @IBOutlet weak var btnGetStarted: UIButtonExtended!
  
  //MARK:  - Properties -
  
  var getRoleViewModel: GetRoleViewModel!
    
  //MARK:  - ViewLifeCycle Methods -
    
    //MARK:- Variable
    var timer = Timer()
    var counter = 0
    var cellCount = 0
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    self.collectionViewRole.allowsSelection = true
    
    //MARK:- AnimationTimer
    self.timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(addCellToCollectionView), userInfo: nil, repeats: true)
  }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.timer.invalidate()
        
    }
  
  //MARK:  - IBAction -
  
  @IBAction func tapGetStarted(_ sender: UIButton) {
    
    let model = self.getRoleViewModel.arrRoles.filter({$0.isSelected == true})
    let selectedRoleId = model.first?.roleId
    
    if selectedRoleId == nil{
      self.showAlert(withMessage: AlertMessage.kRoleSelection)
    }
    else{
      self.btnGetStarted.isUserInteractionEnabled = false
      self.postRequestToGetWalkthorughScreens(String.getString(selectedRoleId))
    }
  }
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  //MARK:  - Private Methods -
  
  private func getRoleCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let roleCollectionCell = self.collectionViewRole.dequeueReusableCell(withReuseIdentifier: RoleCollectionCell.identifier(), for: indexPath) as! RoleCollectionCell
    roleCollectionCell.configureData(withGetRoleDataModel: self.getRoleViewModel.arrRoles[indexPath.item], indexPath.item)
    return roleCollectionCell
  }
    
    //MARK: - Timer Selector -
    @objc func addCellToCollectionView(){
        self.counter += 1
        
        if counter <= self.getRoleViewModel.arrRoles.count{
            self.cellCount += 1
          
            let indexPath = IndexPath(item: cellCount-1, section: 0)
            self.collectionViewRole.insertItems(at: [indexPath])
        }else{
            
            self.timer.invalidate()
        }
    }
  //MARK: - WebService Methods -
  
  private func postRequestToGetWalkthorughScreens(_ selectedRoleId: String) -> Void{
    
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetWalkthroughScreens + selectedRoleId, method: .GET, controller: self, type: 0, param: [:],btnTapped: self.btnGetStarted)
  }
}

//MARK:  - UICollectionViewMethods -

extension RoleViewC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   // return self.getRoleViewModel?.arrRoles.count ?? 0
    return cellCount
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    self.getRoleCollectionCell(indexPath)
  }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let width = (kScreenWidth - 100.0) / 3
    return CGSize(width: width,height: width+40.0)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    for i in 0...self.getRoleViewModel.arrRoles.count - 1{
      
      self.getRoleViewModel.arrRoles[i].isSelected = false
    }
    
    let model = self.getRoleViewModel.arrRoles[indexPath.item]
    model.isSelected = true
     DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.collectionViewRole.reloadData()

    }
    
//    switch indexPath.item {
//    case 0,1:
//      for i in 0...self.getRoleViewModel.arrRoles.count - 1{
//
//        self.getRoleViewModel.arrRoles[i].isSelected = false
//      }
//
//      let model = self.getRoleViewModel.arrRoles[indexPath.item]
//      model.isSelected = true
//      self.collectionViewRole.reloadData()
//    default:
//      showAlert(withMessage: "Under Development")
//    }
  }
    
    //MARK:- Animation
    private func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.animate(withDuration: 0.6, animations: {
            cell.alpha = 1
        })
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = self.collectionViewRole.cellForItem(at: indexPath) as? RoleCollectionCell {
                cell.imgRole.transform = .init(scaleX: 2, y: 2)
                //cell.contentView.backgroundColor = UIColor.white
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = self.collectionViewRole.cellForItem(at: indexPath) as? RoleCollectionCell {
                cell.imgRole.transform = .identity
            }
        }
    }
}

extension RoleViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let dicResponse = kSharedInstance.getDictionary(result)
    switch type {
    case 0:
      let model = self.getRoleViewModel.arrRoles.filter({$0.isSelected == true})
     // let controller = pushViewController(withName: MembersWalkthroughViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? MembersWalkthroughViewC
     // controller?.getRoleDataModel = model
     // controller?.getWalkThroughViewModel = GetWalkThroughViewModel(dicResponse)
        
        //MARK:- TESTING Change

        let roleId = String.getString(model.first?.roleId)
        let nextVC = CountryListVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
        nextVC.roleId = roleId
    default:
      break
    }
  }
}

