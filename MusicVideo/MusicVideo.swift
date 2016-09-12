//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Morteza Araby on 12/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import Foundation

class Videos {
    // Data Encapsulation
    
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    
    // Make a getter
    var vName: String{
        return _vName
    }
    
    var vImageUrl: String{
        return _vImageUrl
    }

    var vVideoUrl: String{
        return _vVideoUrl
    }
    
    init(data: JSONDictionary){
        //If we do not initialize all properties we will get error message
        //Return from initializer without initializing all stored properties
        
        //Video name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
        } else {
            //You may not always get data back from the JSON - you may want to display message
            //element in the JSON is unexpected
            
            _vName = ""
        }
        
        //Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
            self._vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600") // change the resolution to 600x600
        } else {
            //You may not always get data back from the JSON - you may want to display message
            //element in the JSON is unexpected
            
            _vImageUrl = ""
        }
        
        //Video Url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String{
            self._vVideoUrl = vVideoUrl
        } else {
            //You may not always get data back from the JSON - you may want to display message
            //element in the JSON is unexpected
            
            _vVideoUrl = ""
        }
    }

    
}