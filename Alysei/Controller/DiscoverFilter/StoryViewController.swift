//
//  ViewController.swift
//  Stories
//
//   Created by Jai on 29/03/22.
//

import UIKit

class StoryViewController: AlysieBaseViewC {

    @IBOutlet weak var outerCollection: UICollectionView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var rowIndex:Int = 0
    var arrUser = [StoryHandler]()
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var imageCollection: [[String]] = [[]]
    
    var tapGest: UITapGestureRecognizer!
    var longPressGest: UILongPressGestureRecognizer!
    var panGest: UIPanGestureRecognizer!

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        cancelBtn.addTarget(self, action: #selector(cancelBtnTouched), for: .touchUpInside)
        //self.tabBarController?.tabBar.isHidden = true
        
        newsRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let storyBar = getCurrentStory() {
            storyBar.startAnimation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func cancelBtnTouched() {
        //self.dismiss(animated: false, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func newsRequest() -> Void{
      
      disableWindowInteraction()
    
      TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kNewsStatus, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
          
          let dictResponse = dictResponse as? [String:Any]
          
          if let data = dictResponse?["data"] as? [[String:Any]]{
              
              for i in 0..<data.count{
                  
                  let att = data[i] as? [String:Any]
                  let attachment = att?["attachment"] as? [String:Any]
                  
                  print("hello ",attachment?["attachment_url"] ?? "")
                   
                  //self.imageCollection[0].append(contentsOf: attachment?["attachment_url"] as! [String])
                  self.imageCollection[0].append((attachment?["base_url"] as! String)+""+(attachment?["attachment_url"] as! String))
              }
              
              self.setupModel()
              self.addGesture()
              
          }
          
        
      }
      
    }
  
}

// MARK:- Helper Methods
extension StoryViewController {
    
    func setupModel() {
        for collection in imageCollection {
            //arrUser.append(StoryHandler(imgs: ["https://alysei.s3.us-west-1.amazonaws.com/uploads/2022/03/15231541648535101.jpeg"]))
            arrUser.append(StoryHandler(imgs: collection))
        }
        
        StoryHandler.userIndex = rowIndex
        outerCollection.reloadData()
        outerCollection.scrollToItem(at: IndexPath(item: StoryHandler.userIndex, section: 0),
                                     at: .centeredHorizontally, animated: false)
    }
    
    func currentStoryIndexChanged(index: Int) {
        arrUser[StoryHandler.userIndex].storyIndex = index
    }
    
    func showNextUserStory() {
        let newUserIndex = StoryHandler.userIndex + 1
        if newUserIndex < arrUser.count {
            StoryHandler.userIndex = newUserIndex
            showUpcomingUserStory()
        } else {
            cancelBtnTouched()
        }
    }
    
    func showPreviousUserStory() {
        let newIndex = StoryHandler.userIndex - 1
        if newIndex >= 0 {
            StoryHandler.userIndex = newIndex
            showUpcomingUserStory()
        } else {
            cancelBtnTouched()
        }
    }
    
    func showUpcomingUserStory() {
        removeGestures()
        let indexPath = IndexPath(item: StoryHandler.userIndex, section: 0)
        outerCollection.reloadItems(at: [indexPath])
        outerCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            if let storyBar = self.getCurrentStory() {
                storyBar.animate(animationIndex: self.arrUser[StoryHandler.userIndex].storyIndex)
                self.addGesture()
            }
        }
    }
    
    func getCurrentStory() -> StoryBar? {
        if let cell = outerCollection.cellForItem(at: IndexPath(item: StoryHandler.userIndex, section: 0)) as? OuterCell {
            return cell.storyBar
        }
        return nil
    }
}

// MARK:- Gestures
extension StoryViewController {
    
    func addGesture() {
        
        // for previous and next navigation
        tapGest = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGest)
        
        longPressGest = UILongPressGestureRecognizer(target: self,
                                                         action: #selector(panGestureRecognizerHandler))
        longPressGest.minimumPressDuration = 0.2
        self.view.addGestureRecognizer(longPressGest)
        
        /*
         swipe down to dismiss
         NOTE: Self's presentation style should be "Over Current Context"
         */
        panGest = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        self.view.addGestureRecognizer(panGest)
    }
    
    func removeGestures() {
        self.view.removeGestureRecognizer(tapGest)
        self.view.removeGestureRecognizer(longPressGest)
        self.view.removeGestureRecognizer(panGest)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchLocation: CGPoint = gesture.location(in: gesture.view)
        let maxLeftSide = ((view.bounds.maxX * 40) / 100) // Get 40% of Left side
        if let storyBar = getCurrentStory() {
            if touchLocation.x < maxLeftSide {
                storyBar.previous()
            } else {
                storyBar.next()
            }
        }
    }
    
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        guard let storyBar = getCurrentStory() else { return }

        let touchPoint = sender.location(in: self.view?.window)
        if sender.state == .began {
            storyBar.pause()
            initialTouchPoint = touchPoint
        } else if sender.state == .changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: max(0, touchPoint.y - initialTouchPoint.y),
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height)
            }
        } else if sender.state == .ended || sender.state == .cancelled {
            if touchPoint.y - initialTouchPoint.y > 200 {
                dismiss(animated: true, completion: nil)
            } else {
                storyBar.resume()
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
        }
    }
}

// MARK:- Collection View Data Source and Delegate
extension StoryViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! OuterCell
        cell.weakParent = self
        cell.setStory(story: arrUser[indexPath.row])
        return cell
    }
}

// MARK:- Scroll View Delegate
extension StoryViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let storyBar = getCurrentStory() {
            storyBar.pause()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let lastIndex = StoryHandler.userIndex
        let pageWidth = outerCollection.frame.size.width
        let pageNo = Int(floor(((outerCollection.contentOffset.x + pageWidth / 2) / pageWidth)))

        if lastIndex != pageNo {
            StoryHandler.userIndex = pageNo
            showUpcomingUserStory()
        } else {
            if let storyBar = getCurrentStory() {
                self.addGesture()
                storyBar.resume()
            }
        }
    }
}
