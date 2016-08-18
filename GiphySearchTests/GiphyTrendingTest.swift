//
//  GiphyTrendingTest.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import XCTest

class GiphyTrendingTest: XCTestCase {
    
    var json:[String:AnyObject]?
    
    override func setUp() {
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "GiphyResponseTrending", ofType: "json")
        let data = try! NSData(contentsOfFile: path!) as Data
        
        json = try! JSONSerialization.jsonObject(with: data,
                                              options: .allowFragments) as! [String:AnyObject]
    }
    
    func testTrendingJSON() {
        
        let imageEntries = json!["data"] as! [[String:AnyObject]]
        let imageList = imageEntries.map {
            ImageItem(json: $0)
        }
        let anItem = imageList[1]
        XCTAssertEqual(anItem.type, "gif")
        XCTAssertEqual(anItem.rating, "pg")
        XCTAssertEqual(anItem.trendingDate, "2016-08-17 23:30:01")
        
        XCTAssertEqual(anItem.mainLink.url, "http://media2.giphy.com/media/kvX00yPxZYFZ6/200.gif")
        XCTAssertEqual(anItem.mainLink.width, 302)
        XCTAssertEqual(anItem.mainLink.height, 200)
    }
}
