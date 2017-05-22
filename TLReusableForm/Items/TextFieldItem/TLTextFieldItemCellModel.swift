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
    
    public var inputText: String? {
        didSet {
            didChangeText?(inputText)
        }
    }

    var didChangeText: ((String?) -> ())?
}
