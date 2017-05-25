//
//  TLSimpleFormCollectionViewLayout.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/17/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import UIKit

class TLFormCollectionViewLayout: UICollectionViewLayout {
    
    var itemBuilders: [[TLFormItemBuilder]]
    var sectionSetup: TLFormSectionSetup
    
    var verticalValue: CGFloat = 0
    
    init(itemBuilders: [[TLFormItemBuilder]], sectionSetup: TLFormSectionSetup) {
        self.itemBuilders = itemBuilders
        self.sectionSetup = sectionSetup
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cachedAttributes: [[UICollectionViewLayoutAttributes]] = [[]]
    
    override func prepare() {
        
        verticalValue = 0
        
        let sections = sectionSetup.getInsets(for: itemBuilders)
        
        for (sectionIndex, sectionItemsBuilders) in itemBuilders.enumerated() {
            
            let sectionInset = sections[sectionIndex]
            
            verticalValue += sectionInset.top
            
            var cachedSectionAttributes = [UICollectionViewLayoutAttributes]()
            
            for (itemIndex, itemBuilder) in sectionItemsBuilders.enumerated() {
                
                verticalValue += itemBuilder.itemInset.top
                
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                let itemWidth: CGFloat
                
                if let collectionView = collectionView {
                    itemWidth = itemBuilder.automaticWidth ? collectionView.frame.width : itemBuilder.itemSize.width
                } else {
                    itemWidth = itemBuilder.automaticWidth ? 10 : itemBuilder.itemSize.width
                }
                
                let height = itemBuilder.itemSize.height
                let width = itemWidth - itemBuilder.itemInset.right - sectionInset.right - itemBuilder.itemInset.left - sectionInset.left
                let originX = sectionInset.left + itemBuilder.itemInset.left
                let originY = verticalValue
                
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = CGRect(x: originX, y: originY, width: width, height: height)
                cachedSectionAttributes.append(attribute)
                
                verticalValue += height + itemBuilder.itemInset.bottom
            }
            
            cachedAttributes.append(cachedSectionAttributes)
            verticalValue += sectionInset.bottom
        }
    }
    
    override var collectionViewContentSize: CGSize {
        let width = collectionView?.frame.size.width ?? 10
        return CGSize(width: width, height: verticalValue)
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
