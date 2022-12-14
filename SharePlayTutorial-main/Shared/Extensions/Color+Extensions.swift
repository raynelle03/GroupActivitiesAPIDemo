//
//  Color+Extensions.swift
//  SharePlayTutorial (iOS)
//
//

import SwiftUI

// Needed for native dark-mode support
public extension Color {

    #if os(macOS)
    static let background = Color(NSColor.windowBackgroundColor)
    #else
    static let background = Color(UIColor.systemBackground)
    #endif
}
