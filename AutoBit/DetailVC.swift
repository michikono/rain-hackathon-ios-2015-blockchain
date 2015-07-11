//
//  DetailVC.swift
//  AutoBit
//
//  Created by Renu Punjabi on 7/11/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import Foundation
import UIKit
import ChainKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var monthYearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var asset: ChainAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.hidden = true

        if let asset = asset {
            balanceLabel.text = "$\(asset.price)"
            idLabel.text = asset.name
            monthYearLabel.text = "March 2013"
            nameLabel.text  = "Haruki Marakami 2013"
            
            if let stringURL = asset.imageURL, let url = NSURL(string: stringURL) {
                imageView.setImageWithUrl(url)
            }

        }
        
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
            self.searchBar.hidden = false
    }
    
    @IBAction func transferPressed() {
        if let asset = asset {
            ChainAPI.sharedInstance.transferAsset(asset.assetID, outputBucketID: "d4840e4e-4768-41db-9e57-1fe13098fb4f", inputBucketID: "aecbc268-2ed2-4143-b69c-da89c1bb9a99") { success in
                
                print("Eric! Success? \(success)")
            }
        }
    }
}
