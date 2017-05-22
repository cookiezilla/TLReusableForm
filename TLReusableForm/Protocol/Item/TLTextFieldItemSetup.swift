//
//  TLTextFieldItemSetup.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/19/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public protocol TLTextFieldItemSetup: TLItemSetup {
    
    var titleFont: UIFont? { get }
    var titleColor: UIColor? { get }
    
    var inputFont: UIFont? { get }
    var inputColor: UIColor? { get }
}
