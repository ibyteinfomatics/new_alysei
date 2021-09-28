//
//  AboutViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit




class AboutViewC: UIViewController {


    enum TableViewCellType: String {
        case cellWithCollection = "checkbox"
        case cellWithText = "text"
        case cellWithTextAndSwitch = "radio"
    }

    @IBOutlet var aboutCollectionView: UICollectionView!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var subDetailLabel: UILabel!

    @IBOutlet var listTitleLabel: UILabel!
    @IBOutlet var aboutStaticLabel: UILabel!
    @IBOutlet var subDetailStaticLabel: UILabel!


    @IBOutlet var secondaryCollectionView: UICollectionView!
    @IBOutlet var secondaryListTitle: UILabel!


    @IBOutlet var tableView: UITableView!

    var viewModel: AboutView.viewModel!
    var aboutTabModel = [UserProfile.aboutTab]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        
        self.aboutCollectionView.delegate = self
        self.aboutCollectionView.dataSource = self

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.tableFooterView = UIView()

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.resetAllAlpha()

        self.tableView.reloadData()
        
        if (self.viewModel?.rows?.count ?? 0) > 0 {
            self.listTitleLabel.text = "\(viewModel.listTitle ?? "")"
            self.aboutCollectionView.reloadData()
            self.aboutCollectionView.alpha = 1.0
            self.listTitleLabel.alpha = 1.0
        } else {
            self.aboutCollectionView.alpha = 0.0
            self.listTitleLabel.alpha = 0.0
        }

        if let detail = self.viewModel?.detail {
            self.aboutStaticLabel.text = "\(viewModel?.staticDetail ?? "")"
            self.aboutLabel.text = "\(detail)"
            self.aboutStaticLabel.alpha = 1.0
            self.aboutLabel.alpha = 1.0
        } else {
            self.aboutStaticLabel.alpha = 0.0
            self.aboutLabel.alpha = 0.0
        }

        if let subDetail = self.viewModel?.subDetail {
            self.subDetailStaticLabel.text = "\(viewModel?.staticSubdetail ?? "")"
            self.subDetailLabel.text = "\(subDetail)"
            self.subDetailStaticLabel.alpha = 1.0
            self.subDetailLabel.alpha = 1.0
        } else {
            self.subDetailStaticLabel.alpha = 0.0
            self.subDetailLabel.alpha = 0.0
        }


        self.secondaryListTitle.text = "\(viewModel?.secondListTitle ?? "")"

        if (self.viewModel?.secondList?.count ?? 0) > 0 {
            self.secondaryCollectionView.reloadData()
            self.secondaryCollectionView.alpha = 1.0
            self.secondaryListTitle.alpha = 1.0
        } else {
            self.secondaryCollectionView.alpha = 0.0
            self.secondaryListTitle.alpha = 0.0
        }
    }

    func resetAllAlpha() {
        self.aboutCollectionView.alpha = 1.0
        self.listTitleLabel.alpha = 1.0

        self.aboutStaticLabel.alpha = 1.0
        self.aboutLabel.alpha = 1.0

        self.subDetailStaticLabel.alpha = 1.0
        self.subDetailLabel.alpha = 1.0
    }

    func loadPage() {
        self.tableView.reloadData()
    }

}

extension AboutViewC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aboutTabModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDetail = self.aboutTabModel[indexPath.row]
        let cellType = TableViewCellType(rawValue: cellDetail.type) ?? .cellWithText
        switch cellType {

        case .cellWithCollection:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithCollectionView") as? AboutViewTableCellWithCollection {
                var model = AboutViewCModels.collectionViewCellData()
                model.title = cellDetail.title
                model.products = cellDetail.value.components(separatedBy: ",")
                cell.seutp(model)
                return cell
            }
        case .cellWithText:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithText") as? AboutViewTableCellWithText {
                cell.titleLabel.text = cellDetail.title.capitalized
                cell.descriptionLabel.text = cellDetail.value.capitalized
                return cell
            }
        case .cellWithTextAndSwitch:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithTextAndSwitch") as? AboutViewTableCellWithTextAndSwitch {
                cell.titleLabel.text = cellDetail.title.capitalized
                let detail = cellDetail.value.capitalized
                if detail.count > 0 {
                    cell.descriptionLabel.text = detail
                } else {
                    cell.descriptionLabel.text = "No"
                }
                cell.valueSwitch.isHidden = true
                return cell
            }
        }
        return UITableViewCell()
    }
}



extension AboutViewC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
        return self.viewModel?.rows?.count ?? 0
        } else {
            return self.viewModel.secondList?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutSubviewCollectionViewCell", for: indexPath) as? AboutViewCollectionViewCell else {
            return UICollectionViewCell()
        }

        let title = (indexPath.section == 0) ? (self.viewModel?.rows?[indexPath.row] ?? "") : (self.viewModel?.secondList?[indexPath.row] ?? "")
        cell.titleLabel.text = "\(title)"
        cell.contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 5.0
        cell.titleLabel.sizeToFit()
        cell.contentView.sizeToFit()
        cell.sizeToFit()
        return cell
    }


}


class AboutViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
}
