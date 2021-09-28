//
//  MarketPlaceWalkThroughDescVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/1/21.
//

import UIKit

class MarketPlaceWalkThroughDescVC: UIViewController {

    //MARK: - IBOutlet -
    
    @IBOutlet weak var collectionViewWalkthrough: UICollectionView!
    
    var walkthroughModel : [GetWalkThroughDataModel]?
    var identifyTab:String?
    //var getWalkThroughViewModel: GetWalkThroughViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callWalkthroughApi()
        // Do any additional setup after loading the view.
    }
    

    private func getWalkThroughCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let walkthroughCollectionCell = collectionViewWalkthrough.dequeueReusableCell(withReuseIdentifier: MemberWalkthroughCollectionCell.identifier(), for: indexPath) as? MemberWalkthroughCollectionCell else {return UICollectionViewCell()}
      // walkthroughCollectionCell.paging.currentPage = indexPath.row
        let IntTab = Int(self.identifyTab ?? "0") ?? 0
        let data = self.walkthroughModel?[IntTab]
        walkthroughCollectionCell.configureData(withGetWalkThroughDataModel: data, indexPath: indexPath, viewModel: GetWalkThroughViewModel([:]))
        walkthroughCollectionCell.delegate = self
        return walkthroughCollectionCell
      }
      
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - CollectionView Methods -

extension MarketPlaceWalkThroughDescVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getWalkThroughCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: kScreenWidth, height:kScreenHeight+20)
  }
}


extension MarketPlaceWalkThroughDescVC: NextButtonDelegate{
  
  func tapNext(_ cell: MemberWalkthroughCollectionCell, currentModel: GetWalkThroughDataModel, btn: UIButton) {
    
    if btn == cell.btnNext{
      
        let walkthroughArray =  self.walkthroughModel?.count ?? 0
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
      }
    }
    else if btn == cell.btnSkip{
      cell.btnSkip.isUserInteractionEnabled = false
    }
  }
}

extension MarketPlaceWalkThroughDescVC {
    func callWalkthroughApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetMarketPlaceWalkthrough, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            if let data = response?["data"] as? [[String:Any]]{
                self.walkthroughModel = data.map({GetWalkThroughDataModel.init(withDictionary: $0)})
                
            }
            self.collectionViewWalkthrough.reloadData()
        }
       
    }
}
