//
//  SidebarSection.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import Foundation

@objc
class SidebarSection: SidebarItem {
    @objc var subitems: [SidebarItem]? {
        didSet {
            subitems?.forEach { subitem in
                subitem.parent = self
            }
        }
    }
}
