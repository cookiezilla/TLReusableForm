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

    var reusableItems: [[TLFormReusableItem]]
    
    init(items: [[TLFormReusableItem]]) {
        self.reusableItems = items
        super.init()
    }
    
    weak var customItemDataSource: TLFormCustomItemDataSource?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return reusableItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reusableItems[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("dequeue for indexPath: \(indexPath.section) \(indexPath.item)")
        
        let item = reusableItems[indexPath.section][indexPath.item]
        let identifier = item.itemBuilder.itemIdentifier
        
        switch item {
        case .testing:
            return createTestingItem(from: collectionView, for: indexPath, identifier: identifier)
        case .textfield(let setup, var model):
            return TLTextFieldItemCell.createItem(from: collectionView, for: indexPath, identifier: identifier, itemSetup: setup, model: model)
        case .custom(_):
            
            if let dataSource = customItemDataSource {
                
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                let newItem = dataSource.setItem(item: item, for: indexPath, with: identifier)
                return newItem
                
            } else {
                let builder = TLTestingItemBuilder()
                return createErrorItem(from: collectionView, for: indexPath, identifier: builder.itemIdentifier, withMessage: "Couldn't create the item, no custom dataSource detected")
            }
        }
    }
    
    func update(item: TLFormReusableItem, at indexPath: IndexPath) {
        reusableItems[indexPath.section][indexPath.item] = item
    }
    
    func getItem(at indexPath: IndexPath) -> TLFormReusableItem {
        return reusableItems[indexPath.section][indexPath.item]
    }
    
    func getAllItems() -> [[TLFormReusableItem]] {
        return reusableItems
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
