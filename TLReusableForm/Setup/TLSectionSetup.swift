//
//  TLSectionSetup.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/19/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public struct TLFormSectionSetup {
    
    public init(sectionsInset: [UIEdgeInsets]) {
        self.sectionsInset = sectionsInset
    }
    
    public init() {
        sectionsInset = [.zero]
    }
    
    var sectionsInset: [UIEdgeInsets]
    
    func getInsets(for itemBuilders: [[TLFormItemBuilder]]) -> [UIEdgeInsets] {
        
        if itemBuilders.count == sectionsInset.count {
            return sectionsInset
        } else {
            
            var sections = [UIEdgeInsets]()
            
            for _ in itemBuilders {
                sections.append(.zero)
            }
            return sections
        }
    }
}
