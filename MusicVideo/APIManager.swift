//
//  APIManager.swift
//  MusicVideo
//
//  Created by Morteza Araby on 12/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: (result:String) -> Void) {
        
        //Configuration to disable the caching, this is preferd way, otherwise we can use the NSURLCache.setSharedURLCache
        // in AppDelegate
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        //let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(url!){
            (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(result: (error!.localizedDescription))
                } else {
                    completion(result: "NSURLSession successful")
                    print(data)
                }
            }
        }
        //Start the task, task by default is suspended
        task.resume()
    }
}