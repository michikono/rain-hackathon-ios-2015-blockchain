//
//  ListTableViewCell.swift
//  AutoBit
//
//  Created by Eric Cerney on 7/11/15.
//  Copyright (c) 2015 Eric Cerney. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: IndexedCollectionView!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCollectionViewDataSourceDelegate<T: UIViewController where T: UICollectionViewDataSource, T: UICollectionViewDelegate>(source: T, indexPath: NSIndexPath) {
        collectionView.dataSource = source
        collectionView.delegate = source
        collectionView.indexPath = indexPath
        
        collectionView.reloadData()
    }
}
