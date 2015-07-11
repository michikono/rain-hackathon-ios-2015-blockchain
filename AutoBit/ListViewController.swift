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
    
    private var assets: [ChainAsset] = [] {
        didSet {
            var musicArray: [ChainAsset] = []
            var gameArray: [ChainAsset] = []
            var bookArray: [ChainAsset] = []
            var movieArray: [ChainAsset] = []
            
            for asset in assets {
                switch asset.assetID {
                case "AJHuxdPxR7sTGp8RHbMPTu1u9kQam6Xova",
                     "ALtB1Ko9YrjftEGpb6ErmTKG6YqZTvDbr3",
                     "AJF2DU9WbA1rB695v1KDzy9Kz9SVSQfHpJ":
                    musicArray.append(asset)
                case "AXhsBSJNYzThQTsb5VAkCNbwrqQgFNSfk9",
                     "ALrCM2WUrP3tr87ACVnL9qthE5JdUMKcdg",
                     "AMQ6fYsEz1qvcMt8hdHJVhYWFCNYhD4iBM":
                    gameArray.append(asset)
                case "ATMQCPQB2jAkwUuM5iFo2NgbRK6cWq4GiT",
                     "AVPJbGSjRQGsD2HrvsyPhJZt3V7VvRAnGT",
                     "AWNxBxr8EnUD6dstjKuG3NL9yCsF2XS3N5":
                    bookArray.append(asset)
                case "AWw79HsBzCQGbTyDNhUAXpmr4eAX9tgm7n",
                     "Ab1EXsyxCymEGkBDDVsrR12caAupYXvVkr",
                     "AK5KtXKE57aGi5FhyGTu6aBXN9WdjxoN6a":
                    movieArray.append(asset)
                default:
                    println("Default")
                }
            }
            
            buckets.append(musicArray)
            buckets.append(gameArray)
            buckets.append(movieArray)
            buckets.append(bookArray)
            
            headerVC?.buckets = buckets
            
            tableView.reloadData()
        }
    }
    
    var buckets: [[ChainAsset]] = []
    
    private var headerVC: ListHeaderViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ChainAPI.sharedInstance.getBucketBalances("aecbc268-2ed2-4143-b69c-da89c1bb9a99") { chainAssets in
            println("Completion!: \(chainAssets)")
            self.assets = chainAssets
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let headerVC = segue.destinationViewController as? ListHeaderViewController {
            self.headerVC = headerVC
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return buckets.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ListTableViewCell
        cell.setCollectionViewDataSourceDelegate(self, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 20))
        headerView.backgroundColor = UIColor.clearColor()
        
        let label = UILabel(frame: CGRect(x: 12, y: 18, width: headerView.bounds.width - 24, height: headerView.bounds.height-18))
        label.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        label.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        headerView.addSubview(label)
        // 16 semibold
        
        switch section {
        case 0:
            label.text = "Music".uppercaseString
        case 1:
            label.text = "Games".uppercaseString
        case 2:
            label.text = "Movies".uppercaseString
        case 3:
            label.text = "Books".uppercaseString
        case 4:
            label.text = "Software".uppercaseString
        default:
            label.text = ""
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
            return buckets[collectionView.indexPath.section].count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AssetCell", forIndexPath: indexPath) as! AssetCollectionViewCell
        let cv = collectionView as! IndexedCollectionView
        
        let asset = buckets[cv.indexPath.section][indexPath.item]
        
        cell.nameLabel.text = asset.name
        cell.priceLabel.text = "$\(asset.price)"
        
        if let stringURL = asset.imageURL, let url = NSURL(string: stringURL) {
            cell.imageView.setImageWithUrl(url)
        }
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Need to push now
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
}
