//
//  TLTextFieldItemCellModel.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/22/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public class TLTextFieldItemCellModel {
    
    public init(inputText: String?) {
        self.inputText = inputText
    }
    
    public var inputText: String?

    static func createNew<Model>(item: TLFormReusableItem, model: Model) -> TLFormReusableItem? {
        
        guard let model = model as? TLTextFieldItemCellModel else { return nil }
        
        switch item {
        case .textfield(let setup, _ ):
            return TLFormReusableItem.textfield(setup, model)
        default: return nil
        }
        
    }
}
