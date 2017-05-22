//
//  TLTextFieldItemDelegate.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/22/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

protocol TLTextFieldItemDelegate {
    func textFieldItem(textFieldItem: TLTextFieldItemCell, didSetText text: String?)
    func textFieldItem(textFieldItem: TLTextFieldItemCell, currentText text: String?) -> String?
}
