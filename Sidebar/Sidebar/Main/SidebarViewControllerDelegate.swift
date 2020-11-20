//
//  SidebarViewControllerDelegate.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import Foundation

@objc
protocol SidebarViewControllerDelegate: class {
    
    /// Called when a new view is selected by the user (but not programatically)
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didSelect item: SidebarItem)
    
}
