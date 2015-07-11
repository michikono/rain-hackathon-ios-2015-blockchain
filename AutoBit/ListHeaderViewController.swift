//
//  ListHeaderViewController.swift
//  AutoBit
//
//  Created by Eric Cerney on 7/11/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import UIKit

class ListHeaderViewController: UIViewController {

    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ListHeaderViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TypeCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let red = CGFloat(arc4random() % 255)
        let green = CGFloat(arc4random() % 255)
        let blue = CGFloat(arc4random() % 255)
        
        cell.backgroundColor = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        
        return cell
    }
}
