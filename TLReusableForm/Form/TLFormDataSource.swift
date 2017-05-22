//
//  TLSimpleFormDataSource.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/18/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import UIKit

public protocol TLFormCustomItemDataSource: class {
    func setItem(item: UICollectionViewCell, for indexPath: IndexPath, with identifier: String) -> UICollectionViewCell
}

class TLFormDataSource: NSObject, UICollectionViewDataSource {

    var itemList: [[TLFormReusableItems]]
    
    init(itemList: [[TLFormReusableItems]]) {
        self.itemList = itemList
        super.init()
    }
    
    weak var customItemDataSource: TLFormCustomItemDataSource?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = itemList[indexPath.section][indexPath.item]
        let identifier = item.itemBuilder.itemIdentifier
        
        switch item {
        case .testing:
            return createTestingItem(from: collectionView, for: indexPath, identifier: identifier)
        case .textfield(let setup):
            return TLTextFieldItem.createItem(from: collectionView, for: indexPath, identifier: identifier, itemSetup: setup)
        case .custom(_):
            
            if let dataSource = customItemDataSource {
                
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                let newItem = dataSource.setItem(item: item, for: indexPath, with: identifier)
                return newItem
                
            } else {
                return createErrorItem(from: collectionView, for: indexPath, identifier: identifier, withMessage: "Couldn't create the item")
            }
        }
        
    }
    
}


extension TLFormDataSource {
    
    func createTestingItem(from collectionView: UICollectionView, for indexPath: IndexPath, identifier: String) -> TLTestingItemCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TLTestingItemCell
        cell.title = "\(indexPath.section) -- \(indexPath.item)"
        return cell
    }
    
    func createErrorItem(from collectionView: UICollectionView, for indexPath: IndexPath, identifier: String, withMessage message: String) -> TLTestingItemCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TLTestingItemCell
        cell.title = message
        return cell
    }
    
}
