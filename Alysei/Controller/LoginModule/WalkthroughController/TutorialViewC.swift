
import UIKit
import Kingfisher

class TutorialViewC: AlysieBaseViewC{

  //MARK: - IBOutlet -
    
  @IBOutlet weak var collectionViewTutorial: UICollectionView!
    var walkthroughModel = [GetWalkThroughDataModel]()
  //MARK: - ViewLifeCycle Methods -
    var image: UIImageView!
    var imageArray = [UIImage]()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.callTutorialApi()
  }
  
  //MARK: - Private Methods -
    
    @objc private func pageControlHandle(sender: UIPageControl){
        //print(sender.currentPage)
        
//        let indexPath = IndexPath(item: sender.currentPage, section: 0)
//        sender.currentPage = indexPath.item
//        collectionViewTutorial.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        
        let lindexPath = IndexPath(row: sender.currentPage, section: 0)
        let cell = collectionViewTutorial.cellForItem(at: lindexPath) as? TutorialCollectionCell
        print(sender.currentPage)
       
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        sender.currentPage = indexPath.item
        cell?.pageControl.currentPage = sender.currentPage
        collectionViewTutorial.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
       // configure(indexpath,self.walkthroughModel[sender.currentPage], modelData: walkthroughModel)
    }
  
  private func getTutorialCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let tutorialCollectionCell = collectionViewTutorial.dequeueReusableCell(withReuseIdentifier: TutorialCollectionCell.identifier(), for: indexPath) as! TutorialCollectionCell
      tutorialCollectionCell.pageControl.currentPage = indexPath.item
      
      //tutorialCollectionCell.imgViewTutorial.setImage(withString: imageArray[indexPath.row], placeholder: UIImage(named: "image_placeholder"), nil)
      let data = walkthroughModel[indexPath.row]
    
      if let strUrl = "\(data.attachment?.baseUrl ?? "")\(data.attachment?.attachmentURL  ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
         
          DispatchQueue.main.async {
            
              tutorialCollectionCell.imgViewTutorial.setImage(withString: strUrl, placeholder: UIImage(named: "image_placeholder"), nil)
          }
         
          }
    
      
      tutorialCollectionCell.configure(indexPath,self.walkthroughModel[indexPath.row], modelData: walkthroughModel)
      tutorialCollectionCell.pageControl.addTarget(self, action: #selector(pageControlHandle), for: .valueChanged)
    tutorialCollectionCell.delegate = self
    return tutorialCollectionCell
  }
}
   
//MARK: - CollectionView Methods -

extension TutorialViewC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //return StaticArrayData.kTutorialDict.count
    return walkthroughModel.count
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getTutorialCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: kScreenWidth, height:kScreenHeight)
  }
}

extension TutorialViewC: GetStartedDelegate{
  
  
  func tapGetStarted(_ btn: UIButton, cell: TutorialCollectionCell) {
    
    if btn == cell.btnGetStarted{
      
      //let walkthroughArray = self.getWalkThroughViewModel.arrWalkThroughs.count
      let currentIndexPath = collectionViewTutorial.indexPath(for: cell)!
      if currentIndexPath.item < walkthroughModel.count - 1{
        
        let indexPath = IndexPath(item: currentIndexPath.item+1, section: 0)
        self.collectionViewTutorial.scrollToItem(at: indexPath, at: .right, animated: true)
        self.collectionViewTutorial.reloadItems(at: [indexPath])
      }
      else{
        _ = pushViewController(withName: LoginAccountViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
      }
    }
    else if btn == cell.btnSkip{
      _ = pushViewController(withName: LoginAccountViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
    }
  }

}

extension TutorialViewC {
    func callTutorialApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kWalkthroughScreenStart, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statuscode) in
            let dictResponse = dictResponse as? [String:Any]
            if let data = dictResponse?["data"] as? [[String:Any]]{
                self.walkthroughModel = data.map({GetWalkThroughDataModel.init(withDictionary: $0)})
              

            }
             self.collectionViewTutorial.reloadData()
        }
        
    }
    
}



