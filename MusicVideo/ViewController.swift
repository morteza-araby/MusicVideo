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
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        //dynamicall load the font in app if the system font changes.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.preferredFontChanged), name: NSNotification.Name(rawValue: "UIContentSizeCategoryDidChangeNotification"), object: nil)

        
        reachabilityStatusChanged()
     
        
        // let connect = connectedToNetwork()
       // print("The device is :\(connect)")
        

        //fetchData()
        
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
            //view.backgroundColor = UIColor.orange
            
            DispatchQueue.main.async {
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                action ->() in
                print("Cancel")
            })
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                action -> () in
                print("Delete")
            })
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                action -> Void in
                print("OK")
                
                // do something if you want here
                //alert.dismissViewControllerAnimated(true, completion: nil)
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
         
            self.present(alert, animated: true, completion: nil)
            }
        default:
            //view.backgroundColor = UIColor.green
            fetchData()
        }
        
    }
    
    func fetchData() -> Void {
        
        if videos.count > 0 { // if we already have fetched data no need to do it again
            return
        }
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json",
                     completion: didLoadData)
        //        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
        //            (result: String) in
        //            print(result)
        //        }
        

    }
    
    func preferredFontChanged(){
        print("The preferred Font Changed")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        //Remove font observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIContentSizeCategoryDidChangeNotification"), object: nil)
        
    }
    
    
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }// Default is 1 if not implemented
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier) as! MusicVideoTableViewCell
        
        cell.video = videos[indexPath.row]
        
        return cell
        
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

