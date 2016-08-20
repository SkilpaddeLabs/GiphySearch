//
//  ImageVM.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/18/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import UIKit
import LBGIFImage

class ImageVM:NSObject {
    
    var imageItems = [ImageItem]()
    
    func refreshTrending(_ collection:UICollectionView?) {
        
        NetworkManager.getTrending { imageList in
            
            self.imageItems = imageList
            collection?.reloadData()
        }
    }
    
    func search(_ query:String, collection:UICollectionView?) {
        
        // Replace spaces with +'s
        let combinedQuery = query.replacingOccurrences(of: " ", with: "+")
        
        NetworkManager.search(combinedQuery) { imageList in
            
            self.imageItems = imageList
            collection?.reloadData()
            
            // TODO: show no items returned.
        }
    }
}

extension ImageVM: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageVC.CellReuseID, for: indexPath)
        
        if let cell = cell as? ImageCell {
    
            let imageItem = imageItems[indexPath.row]
            updateCell(cell, imageItem: imageItem)
        }
        return cell
    }
    
    func updateCell(_ cell:ImageCell, imageItem:ImageItem) {
        
        // Set cell properties.
        cell.titleLabel.text = imageItem.rating
        cell.imageLink = imageItem.mainLink.url
        cell.imageView.image = nil
        
        // Get image from network.
        NetworkManager.getImage(imageItem.mainLink.url) { (data, url) in
            
            // Make sure the network returned the url we asked for.
            guard cell.imageLink == url.absoluteString else { return }
            
            if let anImage = UIImage.animatedGIF(with: data) {
                cell.imageView.image = anImage
            }
        }
    }
}
