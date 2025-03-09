//
//  NumberBadge.swift
//  Aminote
//
//  Created by amin nazemzadeh on 3/9/25.
//

import SwiftUI

extension View {
    func numberBadge(_ number: Int) -> some View {
        #if os(watchOS)
        self
        #else
        self.badge(number)
        #endif
    }
}
