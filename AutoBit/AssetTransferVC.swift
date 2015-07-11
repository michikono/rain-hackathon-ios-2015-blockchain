//
//  AssetTransferVC.swift
//  AutoBit
//
//  Created by Renu Punjabi on 7/11/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class AssetTransferVC: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var grayArrow: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.hidden = true
        
        var searchButton:UIButton = UIButton.buttonWithType(.Custom) as! UIButton
        searchButton.addTarget(self, action: "searchButtonClicked:", forControlEvents: .TouchUpInside)
        searchButton.setImage(UIImage(named: "search_sm_360"), forState: .Normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        var searchButtonItem:UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem  = searchButtonItem
        
        var backButton:UIButton = UIButton.buttonWithType(.Custom) as! UIButton
        backButton.addTarget(self, action: "backButtonItemClicked:", forControlEvents: .TouchUpInside)
        backButton.setImage(UIImage(named: "back_arrow_360"), forState: .Normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 33, height: 34)
        var backButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = backButtonItem

    }
    
    func searchButtonClicked(sender: AnyObject) {
        self.searchBar.hidden = false
    }
    
    func backButtonItemClicked(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        leftImageView.alpha = 1.0
        self.rightImageView.alpha = 0.2

        UIView.animateWithDuration(2.0, delay: 0, options: UIViewAnimationOptions.Repeat, animations: { () -> Void in
            self.grayArrow.center = CGPointMake(CGRectGetMinX(self.rightLabel.frame), CGRectGetMidY(self.rightLabel.frame))
            }) { (Bool) -> Void in
                UIView.animateWithDuration(2.0, delay: 0, options: UIViewAnimationOptions.Repeat, animations: { () -> Void in
                    self.grayArrow.center = CGPointMake(CGRectGetMaxX(self.leftLabel.bounds) + 15, CGRectGetMidY(self.leftLabel.frame))
                    
                    }, completion: nil)
        }
        
        UIView.animateWithDuration(8.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.leftImageView.alpha = 0.2
            self.rightImageView.alpha = 1.0
            }) { (Bool) -> Void in
                self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
}
