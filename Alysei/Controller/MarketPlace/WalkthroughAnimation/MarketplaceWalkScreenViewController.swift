//
//  MarketplaceWalkScreenViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 10/27/21.
//

import UIKit

class MarketplaceWalkScreenViewController: AlysieBaseViewC {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(MarketplaceWalkScreenViewController.panGesture))
//            view.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            let frame = self?.view.frame
//            let yComponent = UIScreen.main.bounds.height - 500
//            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
//        }
//    }
//    func prepareBackgroundView(){
//        let blurEffect = UIBlurEffect.init(style: .dark)
//        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
//        let bluredView = UIVisualEffectView.init(effect: blurEffect)
//        bluredView.contentView.addSubview(visualEffect)
//
//        visualEffect.frame = UIScreen.main.bounds
//        bluredView.frame = UIScreen.main.bounds
//
//        view.insertSubview(bluredView, at: 0)
//    }
//    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: self.view)
//        let y = self.view.frame.minY
//        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
//        recognizer.setTranslation(.zero, in: self.view)
//    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//          let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
//          let direction = gesture.velocity(in: view).y
//
//          let y = view.frame.minY
//          if (y == fullView && tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
//              tableView.isScrollEnabled = false
//          } else {
//            tableView.isScrollEnabled = true
//          }
//
//          return false
//      }
}
