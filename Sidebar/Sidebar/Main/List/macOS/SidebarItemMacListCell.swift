//
//  SidebarItemMacListCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

@available(iOS 13, *)
class SidebarItemMacListCell: UICollectionViewCell, SidebarItemListCell {
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
        view.font = UIFont.systemFont(ofSize: SidebarConstants.Mac.Row.textSize, weight: .regular)
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
        addSubview(imageView)
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SidebarConstants.Mac.Row.Offset.leading),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: SidebarConstants.Mac.Row.glyphSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: SidebarConstants.Mac.Row.Offset.text),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func updateState() {
        textLabel.textColor = isSelected ? .white : nil
        imageView.tintColor = isSelected ? .white : nil
        backgroundColor = isSelected ? Color.accent : nil
    }
}

