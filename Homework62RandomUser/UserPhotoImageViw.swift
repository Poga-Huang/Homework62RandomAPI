//
//  UserPhotoImageViw.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/6.
//

import UIKit

class UserPhotoImageViw: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width/2
    }

}
