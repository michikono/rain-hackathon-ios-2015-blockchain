//
//  DetailVC.swift
//  AutoBit
//
//  Created by Renu Punjabi on 7/11/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var monthYearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.hidden = true

        balanceLabel.text = "$28"
        idLabel.text = "IQ84"
        monthYearLabel.text = "March 2013"
        nameLabel.text  = "Haruki Marakami 2013"
       
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        leftButton.setImage(UIImage(named: "back_arrow_360"), forState: UIControlState.Normal)
//        leftButton.setImage(UIImage(named: "back_arrow_360"), forState: UIControlState.Selected)
//        leftButton.addTarget(self, action: "backButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        let leftBarButton = UIBarButtonItem()
//        leftBarButton.customView = leftButton
//        self.navigationItem.leftBarButtonItem = leftBarButton
        
        var barButton = UIBarButtonItem()
        barButton.customView = searchButton
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func backButtonClicked() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func searchButtonClicked(sender: AnyObject) {
        
        UIView.animateWithDuration(2.5, delay: 0.0, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
            self.searchBar.hidden = false

        }, completion: nil)
       
    }
    
    
}
