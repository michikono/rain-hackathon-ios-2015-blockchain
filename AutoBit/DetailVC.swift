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
        
        var searchButton:UIButton = UIButton.buttonWithType(.Custom) as! UIButton
        searchButton.addTarget(self, action: "searchButtonClicked:", forControlEvents: .TouchUpInside)
        searchButton.setImage(UIImage(named: "search (1)"), forState: .Normal)
        searchButton.sizeToFit()
        var searchButtonItem:UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem  = searchButtonItem
        
        var backButton:UIButton = UIButton.buttonWithType(.Custom) as! UIButton
        backButton.addTarget(self, action: "backButtonItemClicked:", forControlEvents: .TouchUpInside)
        backButton.setImage(UIImage(named: "back_arrow_360"), forState: .Normal)
        backButton.sizeToFit()
        var backButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = backButtonItem
        
    }
    
    func backButtonItemClicked(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func searchButtonClicked(sender: AnyObject) {
        
        UIView.animateWithDuration(2.5, delay: 0.0, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
            self.searchBar.hidden = false

        }, completion: nil)
       
    }
    
    
}
