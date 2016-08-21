//
//  NetworkManager.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import UIKit
import LBGIFImage

class NetworkManager {
    
    // Get a single image from a URL.
    class func getImage(_ urlString:String, completion:@escaping (UIImage, URL)->()) {
        
        guard let url = URL(string: urlString) else { return }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: url) {
            (data, response, error) in
            
            // If no error, and data recieved,
            // dispatch completion on main queue.
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                // Turn returned data into a UIImage.
                if let data = data,
              let returnUrl = response?.url,
                    let image = UIImage.animatedGIF(with: data) {
                    
                    // Send image back on main queue.
                    DispatchQueue.main.async {
                        completion(image, returnUrl)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    // Search giphy.
    class func search(_ query:String, completion: @escaping ([ImageItem])->()) {
        
        let request = GiphyAPIRouter.Search(query).URLRequest
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            // Make sure there is data.
            guard let jsonData = data else { return }
            
            // Attempt to decode json.
            let json:Any?
            do {
                json = try JSONSerialization.jsonObject(with: jsonData,
                                                     options: .allowFragments)
            } catch {
                json = nil
                print("Error deserializing json")
            }
            
            // Convert json to an array of ImageItem.
            if let jsonDict = json as? [String:AnyObject],
             let imageArray = jsonDict["data"] as? [[String:AnyObject]] {
                
                let imageList = imageArray.map {
                    ImageItem(json: $0)
                }
                // Send [ImageItem] back on main queue.
                OperationQueue.main.addOperation {
                    completion(imageList)
                }
            }
        }
        dataTask.resume()
    }
    
    // Get currently trending GIFs.
    class func getTrending(completion: @escaping ([ImageItem])->()) {
        
        let request = GiphyAPIRouter.Trending.URLRequest
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            // Make sure there is data.
            guard let jsonData = data else { return }
            
            // Attempt to decode json.
            let json:Any?
            do {
                json = try JSONSerialization.jsonObject(with: jsonData,
                                                     options: .allowFragments)
            } catch {
                json = nil
                print("Error deserializing json")
            }
            
            // Convert json to an array of ImageItem.
            if let jsonDict = json as? [String:AnyObject],
             let imageArray = jsonDict["data"] as? [[String:AnyObject]] {
                
                let imageList = imageArray.map {
                    ImageItem(json: $0)
                }
                // Send [ImageItem] back on main queue.
                OperationQueue.main.addOperation {
                    completion(imageList)
                }
            }
        }
        dataTask.resume()
    }
}
