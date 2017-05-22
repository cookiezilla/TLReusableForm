//
//  TLSimpleFormItemBuilder.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/18/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public protocol TLFormItemBuilder {
    
    var cellClass: AnyClass? { get }
    var nib: UINib? { get }
    
    var automaticWidth: Bool { get }
    var itemIdentifier: String { get }
    var itemSize: CGSize { get }
    var itemInset: UIEdgeInsets { get }
}
