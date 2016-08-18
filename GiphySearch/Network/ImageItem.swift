//
//  ImageItem.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import Foundation

struct ImageItem {
    
    let type:String
    let rating:String
    let trendingDate:String
    
    init(json:[String:AnyObject]) {
        
        type = json["type"] as? String ?? ""
        rating = json["rating"] as? String ?? ""
        trendingDate = json["trending_datetime"] as? String ?? ""
    }
}

