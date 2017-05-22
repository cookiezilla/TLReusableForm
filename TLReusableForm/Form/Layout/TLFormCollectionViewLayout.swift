//
//  TLSimpleFormCollectionViewLayout.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/17/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import UIKit

class TLFormCollectionViewLayout: UICollectionViewLayout {
    
    var itemList: [[TLFormReusableItems]]
    var sectionConfiguration: TLSectionSetup
    
    var verticalValue: CGFloat = 0
    
    init(itemList: [[TLFormReusableItems]], sectionConfiguration: TLSectionSetup) {
        self.itemList = itemList
        self.sectionConfiguration = sectionConfiguration
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cachedAttributes: [[UICollectionViewLayoutAttributes]] = [[]]
    
    override func prepare() {
        
        verticalValue = 0
        
        let sections = sectionConfiguration.getInsets(for: itemList)
        
        for (sectionIndex, sectionItems) in itemList.enumerated() {
            
            let sectionInset = sections[sectionIndex]
            
            verticalValue += sectionInset.top
            
            var cachedSectionAttributes = [UICollectionViewLayoutAttributes]()
            
            for (itemIndex, item) in sectionItems.enumerated() {
                
                verticalValue += item.itemBuilder.itemInset.top
                
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                let itemWidth: CGFloat
                
                if let collectionView = collectionView {
                    itemWidth = item.itemBuilder.automaticWidth ? collectionView.frame.width : item.itemBuilder.itemSize.width
                } else {
                    itemWidth = item.itemBuilder.automaticWidth ? 0 : item.itemBuilder.itemSize.width
                }
                
                let height = item.itemBuilder.itemSize.height
                let width = itemWidth - item.itemBuilder.itemInset.right - sectionInset.right - item.itemBuilder.itemInset.left - sectionInset.left
                let originX = sectionInset.left + item.itemBuilder.itemInset.left
                let originY = verticalValue
                
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = CGRect(x: originX, y: originY, width: width, height: height)
                cachedSectionAttributes.append(attribute)
                
                verticalValue += height + item.itemBuilder.itemInset.bottom
            }
            
            cachedAttributes.append(cachedSectionAttributes)
            verticalValue += sectionInset.bottom
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.frame.size.width, height: verticalValue)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var newAttributes = [UICollectionViewLayoutAttributes]()
        
        for cachedAttributesSection in cachedAttributes {
            for attribute in cachedAttributesSection {
                
                if attribute.frame.intersects(rect) {
                    newAttributes.append(attribute)
                }
                
            }
        }
        
        return newAttributes
    }

}
