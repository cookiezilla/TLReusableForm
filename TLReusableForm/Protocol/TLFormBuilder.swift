//
//  TLFormBuilder.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/22/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public protocol TLFormBuilder {
    
    var itemList: [[TLFormItem]] { get set }
    var formSetup: TLSectionSetup? { get }
    var reusableItemList: [[TLFormReusableItems]] { get }
}
