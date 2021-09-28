//
//  ContactViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit

protocol ContactViewEditProtocol {
    func editContactDetail()
}

class ContactViewC: AlysieBaseViewC {

    var delegate: ContactViewEditProtocol!
    var tableData = [ContactDetail.view.tableCellModel]() {
        didSet {
            self.tblViewContactUs?.reloadData()
        }
    }
  
  //MARK: - IBOutlet -
  
    @IBOutlet weak var tblViewContactUs: UITableView!
    @IBOutlet var editContactDetailButton: UIButtonExtended!

  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
     
    super.viewDidLoad()

    self.tblViewContactUs.showsHorizontalScrollIndicator = false
    self.tblViewContactUs.showsVerticalScrollIndicator = false
    
    self.view.isUserInteractionEnabled = true
    self.editContactDetailButton.isUserInteractionEnabled = true
    self.tblViewContactUs.isUserInteractionEnabled = true

    self.tblViewContactUs.allowsSelection = false

    let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureMethod(_:)))
    self.view.addGestureRecognizer(tap)
    self.tblViewContactUs.addGestureRecognizer(tap)
    

  }

    @objc func tapGestureMethod(_ sender: UITapGestureRecognizer) {
        self.delegate?.editContactDetail()
    }

  //MARK: - IBAction -
  
  @IBAction func tapEdit(_ sender: UIButton) {

    self.delegate?.editContactDetail()
    
  }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = touches.first?.view {
            print(view.debugDescription)
        }
    }


  //MARK: - Private Methods -
    
  private func getContactTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    guard let contactTableCell = tblViewContactUs.dequeueReusableCell(withIdentifier: ContactTableCell.identifier(), for: indexPath) as? ContactTableCell else {
        return UITableViewCell()
    }
    contactTableCell.updateDisplay(tableData[indexPath.row])
    return contactTableCell
  }
}

//MARK: - TableView Methods -

extension ContactViewC: UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableData.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     return self.getContactTableCell(indexPath)
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 2{
        return 100
    }else{
    return 60
    }
  }
}
