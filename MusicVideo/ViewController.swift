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
    
    func didLoadData(_ result: String){
        //print(result)
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            // do something here if you want
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}

