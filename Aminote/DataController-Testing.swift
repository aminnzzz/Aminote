//
//  DataController-Testing.swift
//  Aminote
//
//  Created by amin nazemzadeh on 3/14/25.
//

import SwiftUI

extension DataController {
    func checkForTestEnvironment() {
        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            self.deleteAll()
            #if os(iOS)
            UIView.setAnimationsEnabled(false)
            #endif
        }
        #endif
    }
}
