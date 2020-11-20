//
//  UserInterfaceIdiom.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

enum UserInterfaceIdiom: Int {
    case phone = 0 // iPhone and iPod touch style UI
    case pad = 1 // iPad style UI
    case mac = 2 // Optimized and Non-optimized Mac UI
    
    init() {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            #if targetEnvironment(macCatalyst)
            self = .mac
            #else
            self = .pad
            #endif
        case .mac:
            self = .mac
        case .phone:
            fallthrough
        default:
            self = .phone
        }
    }
}
