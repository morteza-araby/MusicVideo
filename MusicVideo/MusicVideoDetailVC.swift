//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Morteza Araby on 03/10/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {
    
    var video: Video!

   // var sec: Bool = false
    @IBOutlet weak var vTitle: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

         //sec = UserDefaults.standard.bool(forKey: "secSetting")
        
        title = video.artist
        vTitle.text = video.title
        vPrice.text = video.price
        vRights.text = video.rights
        vGenre.text = video.genre
        
        if video.vImageData != nil {
            videoImage.image = UIImage(data: video.vImageData as! Data)
        }else{
            videoImage.image = UIImage(named: "imageNotAvailable")
        }

    }
 
    
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        let url = NSURL(string: video.videoURL)!
        let player = AVPlayer(url: url as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }

    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        shareMedia()
    }
    
    func shareMedia() -> Void {
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = ("\(video.title) by \(video.artist)")
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = video.iTunesURL
        let activity5 = "(Shared with the Music Video App)"
        
        
        //activityViewController.excludedActivityTypes =  [UIActivityTypeMail]
        
        
        
        //        activityViewController.excludedActivityTypes =  [
        //            UIActivityTypePostToTwitter,
        //            UIActivityTypePostToFacebook,
        //            UIActivityTypePostToWeibo,
        //            UIActivityTypeMessage,
        //            UIActivityTypeMail,
        //            UIActivityTypePrint,
        //            UIActivityTypeCopyToPasteboard,
        //            UIActivityTypeAssignToContact,
        //            UIActivityTypeSaveToCameraRoll,
        //            UIActivityTypeAddToReadingList,
        //            UIActivityTypePostToFlickr,
        //            UIActivityTypePostToVimeo,
        //            UIActivityTypePostToTencentWeibo
        //        ]

        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2,activity3, activity4, activity5], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if activity == UIActivityType.mail {
                print("email selected")
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
