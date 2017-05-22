//
//  TLTextFieldItemBuilder.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/19/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

struct TLTextFieldItemBuilder: TLFormItemBuilder {
    
    var cellClass: AnyClass? {
        return TLTextFieldItemCell.self
    }
    
    var nib: UINib? {
        return nil
    }
    
    var automaticWidth: Bool {
        return true
    }
    var itemIdentifier: String {
        return "TLTextFieldItem"
    }
    var itemSize: CGSize {
        return CGSize(width: 0, height: 65)
    }
    
    var itemInset: UIEdgeInsets {
        return .zero
    }
}
