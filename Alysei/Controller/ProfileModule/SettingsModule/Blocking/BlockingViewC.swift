//
//  BlockingViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 20/01/21.
//

import UIKit

class BlockingViewC: AlysieBaseViewC {

  //MARK: - Properties -
    
  let data = [(image: "select_role1", name: "Joshua Rawson", status: "Blocked. Tap to Unblock")]
    
  //MARK: - IBOutlet -
    
  @IBOutlet weak var tblViewBlocking: UITableView!
  @IBOutlet weak var viewShadow: UIView!
  
  //MARK:  - ViewLifeCycle Methods -
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tblViewBlocking.tableFooterView = UIView()
  }
  
  override func viewDidLayoutSubviews(){
    
    super.viewDidLayoutSubviews()
    self.viewShadow.drawBottomShadow()
  }
  
  //MARK:  - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  //MARK:  - Private Methods -
  
  private func getBlockingTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let blockingTableCell = tblViewBlocking.dequeueReusableCell(withIdentifier: BlockingTableCell.identifier()) as! BlockingTableCell
    blockingTableCell.configure(img: data[indexPath.row].image, lblName: data[indexPath.item].name, lblStatus: data[indexPath.item].status)
    return blockingTableCell
  }
}

//MARK:  - TableViewMethods -

extension BlockingViewC: UITableViewDataSource, UITableViewDelegate{
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   data.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return self.getBlockingTableCell(indexPath)
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
    
}

