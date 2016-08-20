//
//  ImageCVCell.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/18/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageLink = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        self.backgroundColor = Theme.imageCell
        imageView.backgroundColor = UIColor.clear
        titleLabel.textColor = Theme.background
    }
}
