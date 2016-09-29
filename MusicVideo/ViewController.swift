//
//  ViewController.swift
//  MusicVideo
//
//  Created by Morteza Araby on 12/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",
                     completion: didLoadData)
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
//            (result: String) in
//            print(result)
//        }

        
    }
    
    func didLoadData(_ videos: [Video]){
        for video in videos {
            print("Artist = \(video.artist)")
        }
        
        for (index, item) in videos.enumerated() {
            print( "\(index) name \(item.artist)")
        }
        
        
        
    }

}

