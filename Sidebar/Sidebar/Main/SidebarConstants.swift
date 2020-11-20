//
//  SidebarItemHeaderCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

enum SidebarConstants {
    /// Values from Human Interface Guidelines for macOS Catalina
    enum Mac {
        enum Header {
            static let height = CGFloat(25.0).upscaled()
            static let textSize = CGFloat(12.0).upscaled()
            
            enum Offset {
                static let leading = CGFloat(12).upscaled()
                static let bottom = CGFloat(0).upscaled()
            }
        }
        enum Row {
            static let height = CGFloat(24.0).upscaled()
            static let glyphSize = CGFloat(18.0).upscaled()
            static let textSize = CGFloat(13.0).upscaled()
            
            enum Offset {
                static let leading = CGFloat(20).upscaled()
                static let text = CGFloat(6).upscaled()
            }
        }
        enum Spacing {
            static let horizontal = CGFloat(3.0).upscaled()
            static let vertical = CGFloat(2.0).upscaled()
        }
    }
    
    /// Values from measurements of iPadOS 14
    enum Pad {
        enum Header {
            static let height: CGFloat = 21.0
            static let textSize: CGFloat = 20.0
            
            enum Offset {
                static let leading: CGFloat = 8
                static let trailing: CGFloat = 8
            }
            
            enum Glyph {
                static let width: CGFloat = 13
                static let height: CGFloat = 23
            }
        }
        enum Row {
            static let height: CGFloat = 44.0
            static let glyphSize: CGFloat = 24.0
            static let textSize: CGFloat = 17.0
            
            enum Offset {
                static let leading: CGFloat = 8
                static let trailing: CGFloat = 8
                static let text: CGFloat = 12
            }
        }
        enum Spacing {
            static let horizontal: CGFloat = 3.0
            static let vertical: CGFloat = 2.0
        }
    }
    
    /// Values from measurements of iOS 14
    enum Phone {
        enum Header {
            static let textSize: CGFloat = 20.0
            
            enum Offset {
                static let leading: CGFloat = 20
                static let trailing: CGFloat = 20
            }
            
            enum Glyph {
                static let width: CGFloat = 13
                static let height: CGFloat = 23
            }
        }
        enum Row {
            static let height: CGFloat = 46.0
            static let glyphSize: CGFloat = 24.0
            static let textSize: CGFloat = 17.0
            
            enum Offset {
                static let leading: CGFloat = 0
                static let trailing: CGFloat = 0
                static let imageViewLeading: CGFloat = 20
                static let text: CGFloat = 10
            }
        }
    }
}
