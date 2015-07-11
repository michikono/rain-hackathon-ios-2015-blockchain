//
//  ListHeaderViewController.swift
//  AutoBit
//
//  Created by Eric Cerney on 7/11/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import UIKit
import ChainKit

class ListHeaderViewController: UIViewController {

    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var valueLabel: UILabel!
    
    var buckets: [[ChainAsset]] = [] {
        didSet {
            buckets.append([])
            
            var total = 0
            for bucket in buckets {
                for asset in bucket {
                    total += asset.price
                }
            }
            
            valueLabel.text = "$\(total)"
            typeCollectionView.reloadData()
            labelContainer.alpha = 0.0
            labelContainer.hidden = false
            
            UIView.animateWithDuration(0.3) {
                self.labelContainer.alpha = 1.0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelContainer.hidden = true
    }
}

extension ListHeaderViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buckets.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TypeCell", forIndexPath: indexPath) as! TypeCollectionViewCell
        
        switch indexPath.item {
        case 0:
            cell.typeLabel.text = "Music".uppercaseString
            cell.priceChangeLabel.text = "+$43"
            cell.backgroundColor = UIColor(red: 18/255.0, green: 115/255.0, blue: 186/255.0, alpha: 1.0)
        case 1:
            cell.typeLabel.text = "Games".uppercaseString
            cell.priceChangeLabel.text = "-$16"
            cell.backgroundColor = UIColor(red: 53/255.0, green: 172/255.0, blue: 225/255.0, alpha: 1.0)
        case 2:
            cell.typeLabel.text = "Movies".uppercaseString
            cell.priceChangeLabel.text = "+$27"
            cell.backgroundColor = UIColor(red: 27/255.0, green: 167/255.0, blue: 157/255.0, alpha: 1.0)
        case 3:
            cell.typeLabel.text = "Books".uppercaseString
            cell.priceChangeLabel.text = "+$5"
            cell.backgroundColor = UIColor(red: 46/255.0, green: 180/255.0, blue: 118/255.0, alpha: 1.0)
        case 4:
            cell.typeLabel.text = "Software".uppercaseString
            cell.priceChangeLabel.text = "-$142"
            cell.backgroundColor = UIColor(red: 13/255.0, green: 103/255.0, blue: 57/255.0, alpha: 1.0)
        default:
            cell.typeLabel.text = "Unknown".uppercaseString
            cell.priceChangeLabel.text = "+$13"
            let red = CGFloat(arc4random() % 255)
            let green = CGFloat(arc4random() % 255)
            let blue = CGFloat(arc4random() % 255)
            
            cell.backgroundColor = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        }
        
        var total = 0
        for asset in buckets[indexPath.item] {
            total += asset.price
        }
        
        cell.priceLabel.text = "$\(total)"
        
        return cell
    }
}
