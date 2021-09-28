//
//  MembersWalkthroughViewC.swift
//  Alysie
//
//  Created by CodeAegis on 02/02/21.
//

import UIKit

class MembersWalkthroughViewC: AlysieBaseViewC {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewWalkthrough: UICollectionView!
  
  //MARK: - Properties -
  
  var getRoleDataModel: [GetRoleDataModel]!
  var getWalkThroughViewModel: GetWalkThroughViewModel!
 
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  }
  
  //MARK: - Private Methods -
  
  private func getWalkThroughCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let walkthroughCollectionCell = collectionViewWalkthrough.dequeueReusableCell(withReuseIdentifier: MemberWalkthroughCollectionCell.identifier(), for: indexPath) as! MemberWalkthroughCollectionCell
    walkthroughCollectionCell.paging.numberOfPages = self.getWalkThroughViewModel.arrWalkThroughs.count
    walkthroughCollectionCell.configureData(withGetWalkThroughDataModel: self.getWalkThroughViewModel.arrWalkThroughs[indexPath.item], indexPath: indexPath, viewModel: self.getWalkThroughViewModel)
    walkthroughCollectionCell.delegate = self
    return walkthroughCollectionCell
  }
  
  //MARK: - WebService Methods -
  
  private func postRequestToGetRegistrationFields(_ currentButton: UIButton) -> Void{
    
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetRegistrationFields +  String.getString(self.getRoleDataModel?.first?.roleId), method: .GET, controller: self, type: 0, param: [:],btnTapped: currentButton)
  }
  
  private func postRequestToGetCountries() -> Void{
    
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetCountries + String.getString(self.getRoleDataModel.first?.roleId), method: .GET, controller: self, type: 1, param: [:],btnTapped: UIButton())
  }
}

//MARK: - CollectionView Methods -

extension MembersWalkthroughViewC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.getWalkThroughViewModel?.arrWalkThroughs.count ?? 0
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getWalkThroughCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: kScreenWidth, height:kScreenHeight)
  }
}

extension MembersWalkthroughViewC: NextButtonDelegate{
  
  func tapNext(_ cell: MemberWalkthroughCollectionCell, currentModel: GetWalkThroughDataModel, btn: UIButton) {
    
    if btn == cell.btnNext{
      
      let walkthroughArray = self.getWalkThroughViewModel.arrWalkThroughs.count
      let currentIndexPath = collectionViewWalkthrough.indexPath(for: cell)!
   
      if currentIndexPath.item < walkthroughArray - 1{
        
        cell.btnSkip.isHidden = false
        let indexPath = IndexPath(item: currentIndexPath.item+1, section: 0)
        self.collectionViewWalkthrough.scrollToItem(at: indexPath, at: .right, animated: true)
//
//        print("index",indexPath.item)
//        print("array",walkthroughArray)
//        print("indexByAdding1",indexPath.item+1)
//        if indexPath.item+1 == walkthroughArray{
//          cell.btnSkip.isHidden = true
//        }
        self.collectionViewWalkthrough.reloadItems(at: [indexPath])
      }
      else{
        cell.btnNext.isUserInteractionEnabled = false
        self.postRequestToGetRegistrationFields(cell.btnNext)
      }
    }
    else if btn == cell.btnSkip{
      cell.btnSkip.isUserInteractionEnabled = false
      self.postRequestToGetRegistrationFields(cell.btnSkip)
    }
  }
}


extension MembersWalkthroughViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let dicResponse = kSharedInstance.getDictionary(result)
    let dicData = kSharedInstance.getDictionary(dicResponse[APIConstants.kData])
    switch type {
    case 0:
      kSharedInstance.signUpViewModel = SignUpViewModel(dicData, roleId: self.getRoleDataModel)
      self.postRequestToGetCountries()
    case 1:
      let filterCountry = kSharedInstance.signUpViewModel.arrSignUpStepOne.filter({$0.name == APIConstants.kCountry})
      if let array = dicResponse[APIConstants.kData] as? ArrayOfDictionary{
        filterCountry.first?.arrOptions = array.map({SignUpOptionsDataModel(withDictionary: $0)})
      }
     let controller = pushViewController(withName: SignUpViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SignUpViewC
      controller?.getRoleDataModel = self.getRoleDataModel
    default:
      break
    }
  }
}
