//
//  PostModel.swift
//  Alysei
//
//  Created by Janu Gandhi on 10/08/21.
//

import Foundation

enum Post {
    struct delete: Codable {
        var postID: Int

        private enum CodingKeys: String, CodingKey {
            case postID = "post_id"
        }
    }
}
