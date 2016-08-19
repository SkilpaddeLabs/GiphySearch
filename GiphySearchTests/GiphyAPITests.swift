//
//  GiphySearchTests.swift
//  GiphySearchTests
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import XCTest
@testable import GiphySearch

class GiphySearchTests: XCTestCase {
    
    func testTrendingURL() {
        
        let correctURL = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC"
        let request = GiphyAPIRouter.Trending.URLRequest as URLRequest
        XCTAssertEqual(correctURL, request.url!.absoluteString)
    }
    
    func testSearchURL() {
        
        let correctURL = "http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"
        let request = GiphyAPIRouter.Search("funny+cat").URLRequest as URLRequest
        XCTAssertEqual(correctURL, request.url!.absoluteString)
    }
}
