//
//  APIManager.swift
//  MusicVideo
//
//  Created by Morteza Araby on 12/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(_ urlString:String, completion: @escaping (_ videos:[Video]) -> Void) {
        
        //Configuration to disable the caching, this is preferd way, otherwise we can use the NSURLCache.setSharedURLCache
        // in AppDelegate
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        //let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)
        
        
        let task = session.dataTask(with: url!, completionHandler: {
            (data, response, error) -> Void in
            
            if error != nil{
               print(error!.localizedDescription)
            } else{
                //Added for JSONSerialization
                //print(data)
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary.
                     Any type of string or value
                     NSJSONSerialization requires the Do / Try / Catch
                     Converts the NSDATA into a JSON Object and cast it to a Dictionary
                     */
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        as? JSONDictionary,
                        let feed = json["feed"] as? JSONDictionary,
                        let entries = feed["entry"] as? JSONArray{
                   
                        var videos = [Video]()
                        for (index,entry) in entries.enumerated() {
                            let entry = Video(data: entry as! JSONDictionary)
                            entry.vRank = index + 1
                            videos.append(entry)
                        }
                        let i = videos.count
                        print ("iTunesApiManager -- total count --> \(i)")
                        print (" ")
                        
                        DispatchQueue.main.async {
                                completion(videos)
                            }
                   
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        print("error in NSJSONSerialization")
                    }
                }
            }
        })
     
        //Start the task, task by default is suspended
        task.resume()
    }
}
