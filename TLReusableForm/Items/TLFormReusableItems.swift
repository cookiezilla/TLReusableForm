//
//  TLReusableItems.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/18/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public enum TLFormReusableItem {
    
    case testing
    case textfield(TLTextFieldItemSetup, TLTextFieldItemCellModel)
    case custom(TLFormItemBuilder)
    
    var itemBuilder: TLFormItemBuilder {
        switch self {
        case .testing: return TLTestingItemBuilder()
        case .textfield: return TLTextFieldItemBuilder()
        case .custom(let builder): return builder
        }
    }
    
}
