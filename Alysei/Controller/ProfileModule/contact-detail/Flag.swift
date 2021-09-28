//
//  Flag.swift
//  Alysei
//
//  Created by Janu Gandhi on 18/06/21.
//

import UIKit


class FlagView: UIView {

    @IBOutlet var button: UIButton!
    @IBOutlet var flag: UIImageView!
    @IBOutlet var countrtyCode: UILabel!

    override func awakeFromNib() {
        self.button.frame = self.frame
    }
}
