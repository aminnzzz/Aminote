//
//  InlineNavigationBar.swift
//  Aminote
//
//  Created by amin nazemzadeh on 3/6/25.
//

import SwiftUI

extension View {
    func inlineNavigationBar() -> some View {
        #if os(macOS)
        self
        #else
        self.navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
