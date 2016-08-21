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
    @IBOutlet weak var trendedBadge: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    var imageLink = ""
    var imageSize:CGSize = CGSize.zero {
        didSet {
            adjustImageSize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        backgroundColor = Theme.imageCell
        imageView.backgroundColor = UIColor.clear
        trendedBadge.tintColor = Theme.background
        titleLabel.textColor = Theme.background
        trendedBadge.isHidden = false
    }
    
    // Resize imageView so that GIF corners get rounded.
    func adjustImageSize() {
        
        let ratio:CGFloat
        
        if imageSize.width > imageSize.height {
            ratio = imageSize.width / imageSize.height
        } else {
            ratio = imageSize.height / imageSize.width
        }
        let newWidth = min(imageView.frame.size.height * ratio, self.frame.size.width - 20.0)
        imageWidthConstraint.constant = newWidth
        setNeedsLayout()
    }
}
