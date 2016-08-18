//
//  ImageItem.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import Foundation


struct ImageLink {
    let url:String
    let width:Int
    let height:Int
    
    init(json:[String:AnyObject]) {
        url = json["url"] as? String ?? ""
        width = Int(json["width"] as? String ?? "") ?? 0
        height = Int(json["height"] as? String ?? "") ?? 0
    }
}

struct ImageItem {
    
    let type:String
    let rating:String
    let trendingDate:String
    let mainLink:ImageLink
    
    init(json:[String:AnyObject]) {
        
        type = json["type"] as? String ?? ""
        rating = json["rating"] as? String ?? ""
        trendingDate = json["trending_datetime"] as? String ?? ""
        
        let images = json["images"] as? [String:AnyObject] ?? [String:AnyObject]()
        let link = images["fixed_height"] as? [String:AnyObject] ?? [String:AnyObject]()
        mainLink = ImageLink(json: link)
    }
}

