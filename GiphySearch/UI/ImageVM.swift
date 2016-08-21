//
//  ImageVM.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/18/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import UIKit

protocol ImageItemDisplay {
    func refresh()
}

class ImageVM:NSObject {
    
    var imageItemDisplay:ImageItemDisplay? = nil
    var imageItems = [ImageItem]()
    var filteredImageItems = [ImageItem]()
    var ratingFilterString:String? = nil {
        
        didSet {
            filterImageItems()
        }
    }
    
    func refreshTrending() {
        
        NetworkManager.getTrending { imageList in
            
            self.imageItems = imageList
            self.filterImageItems()
        }
    }
    
    func search(_ query:String) {
        
        // Replace spaces with +'s
        let combinedQuery = query.replacingOccurrences(of: " ", with: "+")
        
        NetworkManager.search(combinedQuery) { imageList in
            
            self.imageItems = imageList
            self.filterImageItems()
        }
    }
    
    func filterImageItems() {
        
        if ratingFilterString == nil {
            
            filteredImageItems = imageItems
            
        } else {
            
            filteredImageItems = imageItems.filter {
                $0.rating == ratingFilterString
            }
        }
        imageItemDisplay?.refresh()
    }
}

extension ImageVM: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageVC.CellReuseID, for: indexPath)
        
        if let cell = cell as? ImageCell {
    
            let imageItem = filteredImageItems[indexPath.row]
            updateCell(cell, imageItem: imageItem)
        }
        return cell
    }
    
    func updateCell(_ cell:ImageCell, imageItem:ImageItem) {
        
        // Set cell properties.
        cell.titleLabel.text = imageItem.rating.uppercased()
        cell.imageLink = imageItem.mainLink.url
        cell.imageSize = CGSize(width: imageItem.mainLink.width,
                               height: imageItem.mainLink.height)
        cell.imageView.image = nil
        
        // Get image from network.
        NetworkManager.getImage(imageItem.mainLink.url) { (image, url) in
            
            // Make sure the network returned the url we asked for.
            guard cell.imageLink == url.absoluteString else { return }
            cell.imageView.image = image
        }
    }
}
