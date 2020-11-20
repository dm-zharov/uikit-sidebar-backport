//
//  SidebarMacItemHeaderCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

@available(iOS 13, *)
class SidebarItemMacHeaderCell: UICollectionViewCell, SidebarItemHeaderCell {
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    var isExpanded: Bool = false {
        didSet {
            updateState()
        }
    }
    
    var isGroup: Bool = false {
        didSet {
            updateState()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateState()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateState()
        }
    }
    
    private let textLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: SidebarConstants.Mac.Header.textSize, weight: .medium)
        view.textColor = Color.secondaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        updateState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SidebarConstants.Mac.Header.Offset.leading),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -SidebarConstants.Mac.Header.Offset.bottom),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func updateState() {}
}

