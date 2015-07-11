//
//  ListViewController.swift
//  AutoBit
//
//  Created by Eric Cerney on 7/11/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import UIKit
import ChainKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var assets: [[ChainAsset]] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ChainAPI.sharedInstance.getBucketBalances("aecbc268-2ed2-4143-b69c-da89c1bb9a99") { chainAssets in
            println("Completion!: \(chainAssets)")
            self.assets = [chainAssets]
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return assets.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ListTableViewCell
        cell.setCollectionViewDataSourceDelegate(self, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // Can set cells collectionview datasource to self
    }
}

extension ListViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collectionView = collectionView as? IndexedCollectionView {
//            return assets[collectionView.indexPath.item].count
            
            return 12
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AssetCell", forIndexPath: indexPath) as! UICollectionViewCell
                
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    
}
