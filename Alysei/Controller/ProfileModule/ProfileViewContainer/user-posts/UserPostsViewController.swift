//
//  UserPostsViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/3/21.
//

import UIKit

class UserPostsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var userPost: UITableView!
    @IBOutlet weak var vwBlank: UIView!

    var pageNumber = 1

    //TODO: pagination is pending
    var count = 100

    var postData = [PostList.innerData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.fetchPostWithPhotsFromServer(pageNumber)

        self.userPost.rowHeight = UITableView.automaticDimension
        self.userPost.tableFooterView = UIView()
    }

    func setUI(){
        if postData.count == 0{
            vwBlank.isHidden = false
        }else{
            vwBlank.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func updatePostList() {
        self.userPost.reloadData()
    }

}

extension UserPostsViewController {
    func fetchPostWithPhotsFromServer(_ page: Int, count: Int = 30) {
        let urlString = APIUrl.Profile.postList + "?page=\(page)&per_page=\(count)"

        guard let request = WebServices.shared.buildURLRequest(urlString, method: .GET) else {
            return
        }
        WebServices.shared.request(request) { data, URLResponse, statusCode, error in
            print("some")

            guard statusCode == 200 else { return }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(PostList.request.self, from: data)
                print(response)

                let postData = response.data.data
                if self.pageNumber == 1 {
                    self.postData = postData
                } else {
                    self.postData.append(contentsOf: postData)
                }
                self.setUI()
                self.updatePostList()

            } catch {
                print(error.localizedDescription)
            }

        }
    }
}

extension UserPostsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userPost.dequeueReusableCell(withIdentifier: "PostDescTableViewCell", for: indexPath) as? PostDescTableViewCell else { return UITableViewCell() }

        let data = self.postData[indexPath.row]
//        cell.lblPostDesc?.text = data.body
        cell.configCell(NewFeedSearchDataModel(data), indexPath.row)
        cell.sizeToFit()
        return cell
    }


//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}




enum PostList {
    struct request: Codable {
        var data: outerData
        var success: Int
    }

    struct outerData: Codable {
        var data: [innerData]
    }

    struct innerData: Codable {
//        var attachments: [attachments]
        var subjectData: SubjectData
        var body: String?
        var attachmentCount: Int
        var attachments: [Attachments]?

        private enum CodingKeys: String, CodingKey {
//            case attachments
            case subjectData = "subject_id"
            case body
            case attachmentCount = "attachment_count"
            case attachments
        }
    }

    struct subject_id: Codable {
        var user_id: Int
        var role_id: Int
        var company_name: String
        var name: String
        var email: String
    }
    
    struct attachments: Codable {
        var attachment_link: attachment_link
    }

    struct attachment_link: Codable {
        var attachment_url: String
    }
}
