//
//  TLItemSetup.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/19/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public protocol TLItemSetup {
    
    var backgroundColor: UIColor { get }
    
    var drawSeparator: Bool { get }
    var separatorColor: UIColor? { get }
    var separatorWidth: CGFloat? { get }
    
}
