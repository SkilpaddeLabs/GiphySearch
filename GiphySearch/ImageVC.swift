//
//  ImageVC.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {
    
    static let CellReuseID = "ImageCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var trendingButton: UIButton!
    @IBOutlet weak var ratingFilterControl: UISegmentedControl!
    
    let imageVM = ImageVM()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imageVM.imageItemDisplay = self
        
        setupCollectionView()
        imageVM.refreshTrending()
    }
    
    func setupCollectionView() {
        
        // Register cell xib
        let nib = UINib(nibName: "ImageCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ImageVC.CellReuseID)
        // Set delegate
        collectionView.dataSource = imageVM
        collectionView.delegate = imageVM
        
        // Setup layout.
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
    
    // MARK: - IBActions
    @IBAction func trendingButton(_ sender: UIButton) {
        imageVM.refreshTrending()
    }
    
    @IBAction func ratingFilterControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            imageVM.ratingFilterString = "g"
        case 2:
            imageVM.ratingFilterString = "pg"
        case 3:
            imageVM.ratingFilterString = "r"
        default:
            imageVM.ratingFilterString = nil
        }
    }
    
}

extension ImageVC: ImageItemDisplay {
    
    func refresh() {
         collectionView.reloadData()
    }
}

extension ImageVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let queryText = searchBar.text {
            imageVM.search(queryText)
        }
        searchBox.resignFirstResponder()
    }
}

