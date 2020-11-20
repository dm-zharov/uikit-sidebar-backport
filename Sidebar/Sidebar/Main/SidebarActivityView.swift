//
//  SidebarActivityView.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

@available(iOS 13, *)
private enum Const {
    enum Toolbar {
        static let estimatedFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)
    }
    
    enum Title {
        static let font: UIFont = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        static let textColor: UIColor = .label
        static let numberOfLines: Int = 1
    }
    
    enum ActivityIndicator {
        static let style: UIActivityIndicatorView.Style = .medium
    }
}

@available(iOS 13, *)
@objc
final class SidebarLoadingView: UIView {
    // MARK: - Private Properties
    private let toolbar: UIToolbar = UIToolbar(frame: Const.Toolbar.estimatedFrame)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Const.Title.font
        label.textColor = Const.Title.textColor
        label.numberOfLines = Const.Title.numberOfLines
        return label
    }()
    
    private let activityIndicatorView = UIActivityIndicatorView(style: Const.ActivityIndicator.style)
    
    // MARK: - Public Properties
    @objc
    var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    @objc
    var isLoading: Bool {
        get {
            activityIndicatorView.isAnimating
        }
        set {
            if newValue {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // MARK: - Initializers
    @objc
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Private Functions
@available(iOS 13, *)
extension SidebarLoadingView {
    private func setupUI() {
        backgroundColor = .clear
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(toolbar)
        
        toolbar.items = [
            UIBarButtonItem(customView: self.titleLabel),
            UIBarButtonItem(customView: self.activityIndicatorView)
        ]
    }
    
    private func setupConstraints() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: bottomAnchor),
            toolbar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
