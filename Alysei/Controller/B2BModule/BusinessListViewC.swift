//
//  BusinessListViewC.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessListViewC: AlysieBaseViewC {
  
  //MARK:  - IBOutlet -
  
  @IBOutlet weak var tblViewBusinessList: UITableView!
  
  //MARK:  - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tblViewBusinessList.tableFooterView = UIView()
  }
  
  //MARK:  - Private Methods -
  
  private func getBusinessListTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let businessListTableCell = tblViewBusinessList.dequeueReusableCell(withIdentifier: BusinessListTableCell.identifier()) as! BusinessListTableCell
    return businessListTableCell
  }
  
}

//MARK:  - UITableViewMethods -

extension BusinessListViewC: UITableViewDataSource, UITableViewDelegate{
        
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 10
  }
        
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return self.getBusinessListTableCell(indexPath)

  }
        
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 66.0
  }
        
}
