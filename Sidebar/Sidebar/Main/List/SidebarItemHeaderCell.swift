//
//  SidebarItemHeaderCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import Foundation

protocol SidebarItemHeaderCell {
    var text: String? { get set }
    var isExpanded: Bool { get set }
}
