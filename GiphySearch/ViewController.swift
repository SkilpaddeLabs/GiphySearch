//
//  ViewController.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import UIKit

private let cellReuseID = "ImageCell"

class ViewController: UIViewController {
    
    var imageItems = [ImageItem]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBox: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Register cell xib
        let nib = UINib(nibName: "ImageCVCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellReuseID)
        setupCollectionView()
        
        NetworkManager.getTrending { imageList in
            
            print("ss: \(imageList)")
            self.imageItems = imageList
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    func setupCollectionView() {
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50.0
        layout.minimumInteritemSpacing = 20.0
        layout.itemSize = CGSize(width: 300.0, height: 200.0)
        
        collectionView.contentInset.top = 50.0
        collectionView.contentInset.bottom = 50.0
        collectionView.contentInset.left = 50.0
        collectionView.contentInset.right = 50.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath)
        
        if let cell = cell as? ImageCVCell {
            
            let imageItem = imageItems[indexPath.row]
            cell.titleLabel.text = imageItem.rating
            
            NetworkManager.getImage(imageItem.mainLink.url) { (data, url) in
                
                if let anImage = UIImage(data: data) {
                    cell.imageView.image = anImage
                }
            }
            
        }
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    //}
    
    //func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    //}
}
