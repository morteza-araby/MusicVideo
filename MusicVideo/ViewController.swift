//
//  ViewController.swift
//  MusicVideo
//
//  Created by Morteza Araby on 12/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit
//import ReachabilitySwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
     
        
        // let connect = connectedToNetwork()
       // print("The device is :\(connect)")
        
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json",
                     completion: didLoadData)
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
//            (result: String) in
//            print(result)
//        }

        
    }
    
    func didLoadData(_ videos: [Video]){
     //   for video in videos {
     //       print("Artist = \(video.artist)")
       // }
        
        self.videos = videos
        
        for (index, item) in videos.enumerated() {
            print( "\(index) name \(item.artist)")
        }
        
        tableView.reloadData()
        
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.orange
            displayLabel.text = NOACCESS
        case WIFI:
            view.backgroundColor = UIColor.green
            displayLabel.text = WIFI
        case WWAN:
            view.backgroundColor = UIColor.yellow
            displayLabel.text = WWAN
        default:
            return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }// Default is 1 if not implemented
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let video = videos[indexPath.row]
        cell?.textLabel?.text = ("\(indexPath.row + 1)")
        cell?.detailTextLabel?.text = video.title
        
        return cell!
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
  */
    // is called just as the object is about to be deallocated
    // removes the observer
 }

