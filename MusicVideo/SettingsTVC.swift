//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Morteza Araby on 04/10/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

   
    @IBOutlet weak var aboutDisplay: UILabel!
        
    @IBOutlet weak var feedBackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dynamicall load the font in app if the system font changes.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.preferredFontChanged), name: NSNotification.Name(rawValue: "UIContentSizeCategoryDidChangeNotification"), object: nil)
        
        tableView.alwaysBounceVertical = false // don't allow scrolling vertically
    }
    
    func preferredFontChanged(){
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        feedBackDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        securityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }
    
    deinit {
        
        //Remove font observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIContentSizeCategoryDidChangeNotification"), object: nil)
        
    }
    


   
}
