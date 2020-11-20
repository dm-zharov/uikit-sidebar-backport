//
//  AppCoordinator.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

enum Item: Int {
    case allShortcuts
    case shareSheet
    case appleWatch
    case club
    case macStories
    
    var title: String {
        switch self {
        case .allShortcuts:
            return "All Shortcuts"
        case .shareSheet:
            return "Share Sheet"
        case .appleWatch:
            return "Apple Watch"
        case .club:
            return "Club"
        case .macStories:
            return "Mac Stories"
        }
    }
    
    var symbol: String {
        switch self {
        case .allShortcuts:
            return "square.grid.2x2"
        case .shareSheet:
            return "square.and.arrow.up"
        case .appleWatch:
            return "applewatch"
        case .club:
            return "star"
        case .macStories:
            return "network"
        }
    }
}

extension Item {
    var sidebarItem: SidebarItem {
        if #available(iOS 14.0, *) {
            return SidebarItem(title: title, image: UIImage(systemName: symbol), tag: rawValue)
        } else {
            fatalError("Not implemented")
        }
    }
}

enum Section: Int {
    case myShortcuts
    case folders
    
    var title: String {
        switch self {
        case .myShortcuts:
            return "My Shortcuts"
        case .folders:
            return "Folders"
        }
    }
    
    var symbol: String {
        switch self {
        case .myShortcuts:
            return "My Shortcuts"
        case .folders:
            return "Folders"
        }
    }
}

extension Section {
    var sidebarSection: SidebarSection {
        if #available(iOS 13.0, *) {
            return SidebarSection(title: title, image: UIImage(systemName: symbol), tag: rawValue)
        } else {
            fatalError("Not implemented")
        }
    }
}

class SceneRouter {
    // MARK: - Private Properties
    private lazy var splitViewController: SplitViewController = {
        let splitViewController: SplitViewController
        if #available(iOS 14.0, *) {
            splitViewController = SplitViewController(style: .doubleColumn)
            splitViewController.preferredPrimaryColumnWidth = 300.0
        } else {
            splitViewController = SplitViewController()
            splitViewController.minimumPrimaryColumnWidth = 200.0
            splitViewController.maximumPrimaryColumnWidth = 300.0
        }
        splitViewController.preferredDisplayMode = .oneBesideSecondary
        if #available(iOS 13.0, macCatalyst 13.0, *) {
            splitViewController.primaryBackgroundStyle = .sidebar
        }
        
        return splitViewController
    }()
    
    private lazy var regularSidebarViewController: SidebarViewController = {
        instantiateSidebarViewController()
    }()
    
    private lazy var compactSidebarViewController: SidebarViewController = {
        instantiateSidebarViewController()
    }()
    
    private lazy var tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = Color.accent
        
        return tabBarController
    }()
    
    // MARK: - Public
    func rootViewController() -> UIViewController {
        let primaryNavigationController = UINavigationController(rootViewController: regularSidebarViewController)
        splitViewController.setPrimaryViewController(primaryNavigationController)
        
        let secondaryNavigationController = UINavigationController()
        splitViewController.setSecondaryViewController(secondaryNavigationController)
        
        let compactViewController: UIViewController = self.instantiateCompactViewController()
        splitViewController.setCompactViewController(compactViewController)
        
        return splitViewController;
    }
    
    func showInitialViewController() {
        splitViewController.show(ViewController(), animated: true)
    }
    
    // MARK: - Private
    func instantiateSidebarViewController() -> SidebarViewController {
        let sidebarViewController = SidebarViewController()
        sidebarViewController.title = "Shortcuts"
        sidebarViewController.delegate = self
        sidebarViewController.sectionsProvider = sidebarSections
        
        return sidebarViewController
    }
    
    func instantiateCompactViewController() -> UIViewController {
        let sidebarNavigationController = UINavigationController(rootViewController: compactSidebarViewController)
        let secondNavigationController = UINavigationController(rootViewController: ViewController())
        let thirdNavigationController = UINavigationController(rootViewController: ViewController())
        
        tabBarController.viewControllers = [sidebarNavigationController, secondNavigationController, thirdNavigationController]
        
        return tabBarController
    }
    
    func sidebarSections() -> [SidebarSection] {
        let shortcutsSection = Section.myShortcuts.sidebarSection
        shortcutsSection.subitems = [
            Item.allShortcuts.sidebarItem,
            Item.shareSheet.sidebarItem,
            Item.appleWatch.sidebarItem
        ]
        
        let foldersSections = Section.folders.sidebarSection
        foldersSections.subitems = [
            Item.club.sidebarItem,
            Item.macStories.sidebarItem
        ]
        
        return [shortcutsSection, foldersSections]
    }
}

extension SceneRouter: SidebarViewControllerDelegate {
    func sidebarViewController(_ sidebarViewController: SidebarViewController, didSelect item: SidebarItem) {
        
    }
}
