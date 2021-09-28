//
//  SettingsViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class SettingsViewC: AlysieBaseViewC {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var tblViewSettings: UITableView!
  @IBOutlet weak var viewShadow: UIView!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.tblViewSettings.tableFooterView = UIView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.viewShadow.drawBottomShadow()
  }
   
  //MARK: - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapLogout(_ sender: UIButton) {

    kSharedUserDefaults.clearAllData()
  }
  
  //MARK: - Private Methods -
    
  private func getSettingTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let settingsTableCell = tblViewSettings.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier(), for: indexPath) as! SettingsTableCell
        settingsTableCell.configureCell(indexPath)
    return settingsTableCell
  }
}

//MARK: - TableView Methods -

extension SettingsViewC: UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    StaticArrayData.kSettingScreenDict.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     return self.getSettingTableCell(indexPath)
   }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch indexPath.row {
    case 0:
      _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
    case 1:
      _ = pushViewController(withName: CompanyViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    case 3:
      _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    case 4:
      _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    case 5:
      _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    case 7:
      _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    default:
      break
    }
  }
}
