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
        
        title = "Settings"
        
        touchID!.isOn = UserDefaults.standard.bool(forKey: "SecSetting")
        
        //Get slider value to the text
        if(UserDefaults.standard.object(forKey: "APICNT") != nil){
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            APICnt.text = ("\(theValue)")
            sliderCnt.value = Float(theValue)
        }else{
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }
      
    }
    
    @IBAction func valueChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
        
    }
    
    @IBAction func touchIdSec(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if touchID.isOn {
            defaults.set(touchID!.isOn, forKey: "SecSetting")
        }else{
            defaults.set(false, forKey: "SecSetting")
        }
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
