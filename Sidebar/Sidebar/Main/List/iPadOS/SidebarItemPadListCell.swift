//
//  SidebarItemPadListCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

class SidebarItemPadListCell: UICollectionViewCell, SidebarItemListCell {
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
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
        view.font = UIFont.systemFont(ofSize: SidebarConstants.Pad.Row.textSize, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
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
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SidebarConstants.Pad.Row.Offset.leading),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: SidebarConstants.Pad.Row.glyphSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: SidebarConstants.Pad.Row.Offset.text),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        contentView.layer.cornerRadius = 10.0
    }
    
    func updateState() {
        textLabel.textColor = isSelected ? .white : nil
        imageView.tintColor = isSelected ? .white : nil
        contentView.backgroundColor = isSelected ? Color.accent : nil
    }
}

