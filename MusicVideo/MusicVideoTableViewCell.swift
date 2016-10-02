//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Morteza Araby on 01/10/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    var video: Video? {
        didSet{
            updateCell()
        }
    }

    @IBOutlet weak var musicImag: UIImageView!
    @IBOutlet weak var rank: UILabel!
   
    @IBOutlet weak var musicTitle: UILabel!

    func updateCell() -> Void {
        //using preferred fonts instead of system font
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        
        musicTitle.text = video?.title
        rank.text = ("\(video!.vRank)")
        
        //musicImag.image = UIImage(named: "imageNotAvailable")
        if video!.vImageData != nil {
            //print("Get data from array ...")
            musicImag.image = UIImage(data: video!.vImageData! as Data)
        }else{
            GetVideoImage(video: video!, imageView: musicImag)
        }
        
        
    }

    func GetVideoImage(video: Video, imageView: UIImageView) -> Void {
        // Background thread
        //DISPATCH_QUEUE_PRIORITY_HIGH Items dispatched to the queue will run at high
        // priority, i.e. the queue will be scheduled for execution before any default
        // priority or low priority queue.
        
        // Move to a background thread to do some long running work
            DispatchQueue.global(qos: .userInitiated).async {
            let data = NSData(contentsOf: NSURL(string: video.imageURL)! as URL)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data! as Data)
            }
            
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}


