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
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var monthYearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceLabel.text = "$28"
        idLabel.text = "IQ84"
        monthYearLabel.text = "March 2013"
        nameLabel.text  = "Haruki Marakami 2013"
    }
    
    
    @IBAction func tansferAssetButtonClicked(sender: AnyObject) {
    }
    
    
}
