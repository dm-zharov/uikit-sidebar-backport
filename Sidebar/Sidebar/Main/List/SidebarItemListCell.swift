//
//  SidebarItemListCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

protocol SidebarItemListCell {
    var text: String? { get set }
    var image: UIImage? { get set }
    var isSelected: Bool { get set }
}
