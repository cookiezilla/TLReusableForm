//
//  TLTextFieldItemCellModel.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/22/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public struct TLTextFieldItemCellModel {
    
    public init(title: String?, placeholder: String?, inputText: String?) {
        self.titleText = title
        self.placeholder = placeholder
        self.inputText = inputText
    }
    
    var titleText: String?
    var placeholder: String?
    var inputText: String?
    
    public var didChangeText: ((String?) -> ())?
}
