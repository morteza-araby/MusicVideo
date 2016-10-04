//
//  ViewController.swift
//  MusicVideo
//
//  Created by Morteza Araby on 12/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit
//import ReachabilitySwift

class ViewController: UITableViewController {
   
    
   // @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    var limit = 10
    var oldLimit = 0

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
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
        title = ("The iTunes Top \(limit) Music Videos")
        
        oldLimit = limit
        
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
    
   
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        fetchData()
        
    }
    func getAPICount(){
        if(UserDefaults.standard.object(forKey: "APICNT") != nil){
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            limit = theValue
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.string(from: NSDate() as Date)
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    func fetchData() -> Void {
        /*
        if videos.count > 0  && limit != oldLimit { // if we already have fetched data no need to do it again
            return
        }*/
        getAPICount()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json",
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
        static let segueIdentifier = "musicDetail"
    }
    
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }// Default is 1 if not implemented
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier) as! MusicVideoTableViewCell
        
        cell.video = videos[indexPath.row]
        
        return cell
        
    }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == storyboard.segueIdentifier{
            
            let viewController: MusicVideoDetailVC = segue.destination as! MusicVideoDetailVC
            let indexPath = self.tableView.indexPathForSelectedRow
            let video = videos[(indexPath! as NSIndexPath).row]
            
            viewController.video = video
            
            
            /*
            if let indexPath = tableView.indexPathForSelectedRow {
                let video = videos[indexPath.row]
                let dvc = segue.destination as! MusicVideoDetailVC
                dvc.video = video
            }*/
        }
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

