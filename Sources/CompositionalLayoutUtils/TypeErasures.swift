//
//  TypeErasures.swift
//  
//
//  Created by Ugur Bozkurt on 26/11/2022.
//

import Foundation

public extension ItemProviding {
    var eraseToAnyItem: AnyItem { AnyItem(self) }
}

public extension SectionProviding {
    var eraseToAnySection: AnySection { AnySection(self, items: []) }
}
