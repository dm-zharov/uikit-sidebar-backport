//
//  SplitViewController.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

@objc
final class SplitViewController: UISplitViewController {
    public enum Column : Int {
        case primary = 0
        case secondary = 1
        case compact = 2
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
}

extension SplitViewController {
    func setViewController(_ vc: UIViewController?, for column: SplitViewController.Column) {
        switch column {
            case .primary:
                if let primaryViewController = vc {
                    viewControllers = [primaryViewController]
                } else {
                    viewControllers = []
                }
            case .secondary:
                guard let primaryViewController = self.viewControllers.first else {
                    fatalError()
                }
                if let secondaryViewController = vc {
                    viewControllers = [primaryViewController, secondaryViewController]
                } else {
                    viewControllers = [primaryViewController]
                }
            case .compact:
                if let compactViewController = vc, UserInterfaceIdiom() == .phone {
                    viewControllers = [compactViewController]
                }
        }
    }
}

extension SplitViewController {
    @objc(showViewController:animated:)
    func show(_ vc: UIViewController, animated: Bool) {
        if let tabBarController = viewControllers.first as? UITabBarController {
            guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {
                return
            }
            navigationController.pushViewController(vc, animated: animated)
        } else {
            guard let navigationController = viewControllers.last as? UINavigationController else {
                return
            }
            
            if navigationController.viewControllers.first === vc {
                navigationController.popToRootViewController(animated: animated)
            } else {
                vc.navigationItem.leftBarButtonItem = displayModeButtonItem
                navigationController.setViewControllers([vc], animated: false)
            }
        }
    }
}

// MARK: Bridging to Objective-C
@objc extension SplitViewController {
    func setPrimaryViewController(_ vc: UIViewController?) {
        if #available(iOS 14.0, *) {
            if self.style != .unspecified {
                super.setViewController(vc, for: UISplitViewController.Column.primary)
            }
        } else {
            setViewController(vc, for: .primary)
        }
    }
    
    func setSecondaryViewController(_ vc: UIViewController?) {
        if #available(iOS 14.0, *) {
            if self.style != .unspecified {
                super.setViewController(vc, for: UISplitViewController.Column.secondary)
            }
        } else {
            setViewController(vc, for: .secondary)
        }
    }
    
    func setCompactViewController(_ vc: UIViewController?) {
        if #available(iOS 14.0, *) {
            if self.style != .unspecified {
                super.setViewController(vc, for: UISplitViewController.Column.compact)
            }
        } else {
            setViewController(vc, for: .compact)
        }
    }
}
