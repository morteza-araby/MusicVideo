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
        musicTitle.text = video?.title
        rank.text = ("\(video!.vRank)")
        musicImag.image = UIImage(named: "imageNotAvailable")
    }

}
