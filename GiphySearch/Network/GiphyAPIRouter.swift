//
//  GiphyAPIRouter.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import Foundation

enum GiphyAPIRouter {
    
    private static let baseURL = "http://api.giphy.com"
    private static let APIKey = "dc6zaTOxFJmzC" // This is a public trial key.
    
    // Trending GIFs (default returns 25)
    //    limit (optional) # of results
    //    rating - (y,g, pg, pg-13 or r).
    //    fmt - (optional) html or json
    // http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC
    case Trending
    
    // Search for a word or phrase. Punctuation ignored.
    //    q - search query term or phrase (Use plus or url encode for phrases.)
    //    limit - (optional) number of results, maximum 100. Default 25.
    //    offset - (optional) results offset, defaults to 0.
    //    rating - limit results to those rated (y,g, pg, pg-13 or r).
    //    fmt - (optional) html or json format
    // http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC
    case Search(String)
    
    private var method:String {
        
        switch self {
        case .Trending:
            return "GET"
        case .Search:
            return "GET"
        }
    }
    
    private var relativePath:String? {
        switch self {
        case .Trending:
            return "/v1/gifs/trending"
        case .Search:
            return "/v1/gifs/search"
        }
    }
    
    private var parameters:String? {
        switch self {
        case .Trending:
            return nil
        case .Search(let query):
            // TODO: add plus for phrases
            return "/\(query)"
        }
    }
    
    // Construct full URL String, return URL
    private var url:URL {
        var newURL = GiphyAPIRouter.baseURL
        if let relativePath = self.relativePath {
            newURL = newURL + relativePath
        }
        if let parameters = self.parameters {
            newURL = newURL + parameters + "&api_key=\(GiphyAPIRouter.APIKey)"
        } else {
            newURL = newURL +  "?api_key=\(GiphyAPIRouter.APIKey)"
        }
        return URL(string:newURL)!
    }
    
    var URLRequest:NSMutableURLRequest {
        
        // TODO: Why doesn't URLRequest(url:) work?
        let request = NSMutableURLRequest(url: self.url)
        request.httpMethod = self.method
        return request
    }
}
