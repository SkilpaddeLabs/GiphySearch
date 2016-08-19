//
//  NetworkManager.swift
//  GiphySearch
//
//  Created by Tim Bolstad on 8/17/16.
//  Copyright © 2016 Skilpadde Labs. All rights reserved.
//

import Foundation

class NetworkManager {
    
    class func getImage(_ urlString:String, completion:@escaping (Data, URL)->()) {
        
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
                
                if let data = data,
              let returnUrl = response?.url {
                    DispatchQueue.main.async {
                        completion(data, returnUrl)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    class func getTrending(completion: @escaping ([ImageItem])->()) {
        
        let request = GiphyAPIRouter.Trending.URLRequest
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard let jsonData = data else { return }
            
            let json:Any?
            
            do {
                json = try JSONSerialization.jsonObject(with: jsonData,
                                                     options: .allowFragments)

            } catch {
                json = nil
                print("Error deserializing json")
            }
            
            if let jsonDict = json as? [String:AnyObject],
               let imageArray = jsonDict["data"] as? [[String:AnyObject]] {
                OperationQueue.main.addOperation {
                    
                    let imageList = imageArray.map {
                        ImageItem(json: $0)
                    }
                    completion(imageList)
                }
            }
            
        }
        dataTask.resume()
    }
}
