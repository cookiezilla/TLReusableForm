//
//  TLTestingItem.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/18/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import UIKit

class TLTestingItemCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "The cell couldn't be loaded"
        return label
    }()
    
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        backgroundColor = UIColor(red: 236/255, green: 100/255, blue: 75/255, alpha: 1)
        addSubview(titleLabel)
        
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct TLTestingItemBuilder: TLFormItemBuilder {
    
    var cellClass: AnyClass? {
        return TLTestingItemCell.self
    }
    
    var nib: UINib? {
        return nil
    }
    
    var automaticWidth: Bool {
        return true
    }
    
    var itemIdentifier: String {
        return "TLTestingItem"
    }
    
    var itemSize: CGSize {
        return CGSize(width: 300, height: 70)
    }
    
    var itemInset: UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
