//
//  Color.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

@objc
class Color: NSObject {
    @objc(accentColor)
    static var accent: UIColor {
        if #available(iOS 13.0, *) {
            return .lightText
        } else {
            return .blue
        }
    }
    
    @objc(backgroundColor)
    static var background: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    @objc(secondaryBackgroundColor)
    static var secondaryBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .secondarySystemBackground
        } else {
            return UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        }
    }
    
    @objc(tertiaryBackgroundColor)
    static var tertiaryBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiarySystemBackground
        } else {
            fatalError()
        }
    }
    
    @objc(groupedBackgroundColor)
    static var groupedBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGroupedBackground
        } else {
            return UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        }
    }
    
    @objc(secondaryGroupedBackgroundColor)
    static var secondaryGroupedBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .secondarySystemGroupedBackground
        } else {
            fatalError()
        }
    }
    
    @objc(tertiaryGroupedBackgroundColor)
    static var tertiaryGroupedBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiarySystemBackground
        } else {
            return UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        }
    }
    
    @objc(labelColor)
    static var label: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    
    @objc(secondaryLabelColor)
    static var secondaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    @objc(tertiaryLabelColor)
    static var tertiaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiaryLabel
        } else {
            return UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    @objc(quaternaryLabelColor)
    static var quaternaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return .quaternaryLabel
        } else {
            return UIColor.black.withAlphaComponent(0.2)
        }
    }
    
    @objc(fillColor)
    static var fill: UIColor {
        if #available(iOS 13.0, *) {
            return .systemFill
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 120, green: 120, blue: 128, alpha: 0.2)
        }
    }
    
    @objc(secondaryFillColor)
    static var secondaryFill: UIColor {
        // MARK: Apple's Semantic Color
        if #available(iOS 13.0, *) {
            return .secondarySystemFill
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 120, green: 120, blue: 128, alpha: 0.16)
        }
    }
    
    @objc(tertiaryFillColor)
    static var tertiaryFill: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiarySystemFill
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 118, green: 118, blue: 128, alpha: 0.12)
        }
    }
    
    @objc(quaternaryFillColor)
    static var quaternaryFill: UIColor {
        if #available(iOS 13.0, *) {
            return .quaternarySystemFill
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 116, green: 116, blue: 128, alpha: 0.08)
        }
    }
    
    /// Оттенки серого, из которой формируются семантические цвета в темной теме
    @objc(grayColor)
    static var gray: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 142, green: 142, blue: 147, alpha: 1)
        }
    }
    
    @objc(gray2Color)
    static var gray2: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray2
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 174, green: 174, blue: 178, alpha: 1)
        }
    }
    
    @objc(gray3Color)
    static var gray3: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray3
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 190, green: 193, blue: 200, alpha: 1)
        }
    }
    
    @objc(gray4Color)
    static var gray4: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray4
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 209, green: 209, blue: 214, alpha: 1)
        }
    }
    
    @objc(gray5Color)
    static var gray5: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray5
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 229, green: 229, blue: 234, alpha: 1)
        }
    }
    
    @objc(gray6Color)
    static var gray6: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray6
        } else {
            // MARK: Apple's Semantic Color
            return UIColor(red: 242, green: 242, blue: 247, alpha: 1)
        }
    }
    
    @objc(linkColor)
    static var link: UIColor {
        if #available(iOS 13.0, *) {
            return .link
        } else {
            return .blue
        }
    }
    
    @objc(placeholderTextColor)
    static var placeholderText: UIColor {
        if #available(iOS 13.0, *) {
            return .placeholderText
        } else {
            return .gray
        }
    }
    
    @objc(separatorColor)
    static var separator: UIColor {
        if #available(iOS 13.0, *) {
            return .separator
        } else {
            return UIColor(red: 216, green: 216, blue: 216, alpha: 1.0)
        }
    }
}
