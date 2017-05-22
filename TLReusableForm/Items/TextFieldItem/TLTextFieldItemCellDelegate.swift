//
//  TLTextFieldItemCellDelegate.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/22/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public protocol TLTextFieldItemCellDelegate: class {
    func tlTextFieldItemCellDidChangeText(text: String?)
}
