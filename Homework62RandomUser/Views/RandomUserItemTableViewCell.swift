//
//  RandomUserItemTableViewCell.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/6.
//

import UIKit

class RandomUserItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
