//
//  macCatalyst.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

@available(macCatalyst 13.0, *)
enum MacCatalyst {
    static let isScalingOn = true
}

@available(macCatalyst 13.0, *)
extension Double {
    func upscaled() -> Double {
        MacCatalyst.isScalingOn ? self / 0.77 : self
    }
}

@available(macCatalyst 13.0, *)
extension CGFloat {
    func upscaled() -> CGFloat {
        MacCatalyst.isScalingOn ? self / 0.77 : self
    }
}
