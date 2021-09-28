//
//  PreferencesDataModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 22/09/21.
//

import Foundation

class PreferencesDataModel{
    var preference: Int?
    var id: [Int]?
    
    init(id: [Int]?,preference: Int?){
        self.preference = preference
        self.id = id
    }
}
