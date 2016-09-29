//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Morteza Araby on 12/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import Foundation

class Video {
    // Data Encapsulation
    let NO_STRING_FOUND = "-none-"
    
    private var _title:      String
    private var _rights:     String
    private var _price:      String
    private var _imageURL:   String
    private var _artist:     String
    private var _videoURL:   String
    private var _mId:        String
    private var _genre:      String
    private var _iTunesURL:  String
    private var _releaseDate:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    

    
    // Getters...
    
    var title:      String { return _title }
    var rights:     String { return _rights }
    var price:      String { return _price }
    var imageURL:   String { return _imageURL }
    var artist:     String { return _artist }
    var videoURL:   String { return _videoURL }
    var mId:        String { return _mId }
    var genre:      String { return _genre }
    var iTunesURL:  String { return _iTunesURL }
    var releaseDate:String { return _releaseDate }
    
    init(data: JSONDictionary){
        
        
        if let imName = data["im:name"] as? JSONDictionary,
            let label = imName["label"] as? String {
            _title = label
        } else {
            _title = NO_STRING_FOUND
        }
        
        if let rights = data["rights"] as? JSONDictionary,
            let label = rights["label"] as? String {
            _rights = label
        } else {
            _rights = NO_STRING_FOUND
        }
        
        if let imPrice = data["im:price"] as? JSONDictionary,
            let label = imPrice["label"] as? String {
            _price = label
        } else {
            _price = NO_STRING_FOUND
        }
        
        if let imImage = data["im:image"] as? JSONArray,
            let image = imImage[2] as? JSONDictionary,
            let image2 = image["label"] as? String {
            _imageURL = image2.replacingOccurrences(of: "100x100", with: "600x600")
        } else {
            _imageURL = NO_STRING_FOUND
        }
        
        if let imArtist = data["im:artist"] as? JSONDictionary,
            let label = imArtist["label"] as? String {
            _artist = label
        } else {
            _artist = NO_STRING_FOUND
        }
        
        if let link = data["link"] as? JSONArray,
            let url = link[1] as? JSONDictionary,
            let attributes = url["attributes"] as? JSONDictionary,
            let href = attributes["href"] as? String {
            _videoURL = href
        } else {
            _videoURL = NO_STRING_FOUND
        }
        
        if let imid = data["id"] as? JSONDictionary,
            let attributes = imid["attributes"] as? JSONDictionary,
            let label = attributes["im:id"] as? String {
            _mId = label
        } else {
            _mId = NO_STRING_FOUND
        }
        
        if let category = data["category"] as? JSONDictionary,
            let attributes = category["attributes"] as? JSONDictionary,
            let term = attributes["term"] as? String {
            _genre = term
        } else {
            _genre = NO_STRING_FOUND
        }
        
        if let mid = data["id"] as? JSONDictionary,
            let label = mid["label"] as? String {
            _iTunesURL = label
        } else {
            _iTunesURL = NO_STRING_FOUND
        }
        
        if let category = data["im:releaseDate"] as? JSONDictionary,
            let attributes = category["attributes"] as? JSONDictionary,
            let label = attributes["label"] as? String {
            _releaseDate = label
        } else {
            _releaseDate = NO_STRING_FOUND
        }
        
    }
    
}
        
