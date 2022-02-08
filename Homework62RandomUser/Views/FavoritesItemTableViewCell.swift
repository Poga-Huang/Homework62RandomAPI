//
//  FavoritesItemTableViewCell.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/8.
//

import UIKit


class FavoritesItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
