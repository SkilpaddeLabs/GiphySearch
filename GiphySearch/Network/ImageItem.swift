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
    let hasTrended:Bool 
    let mainLink:ImageLink
    
    init(json:[String:AnyObject]) {
        
        type = json["type"] as? String ?? ""
        rating = json["rating"] as? String ?? ""
        let trendingDate = json["trending_datetime"] as? String ?? ""
        hasTrended = trendingDate == "1970-01-01 00:00:00" ? false : true
        
        let images = json["images"] as? [String:AnyObject] ?? [String:AnyObject]()
        let link = images["fixed_height"] as? [String:AnyObject] ?? [String:AnyObject]()
        mainLink = ImageLink(json: link)
    }
}

