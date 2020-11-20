//
//  SidebarItemPhoneListCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

class SidebarItemPhoneListCell: UICollectionViewCell, SidebarItemListCell {
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
        view.font = UIFont.systemFont(ofSize: SidebarConstants.Phone.Row.textSize, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = Color.gray5
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
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
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SidebarConstants.Phone.Row.Offset.imageViewLeading),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: SidebarConstants.Phone.Row.glyphSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: SidebarConstants.Phone.Row.Offset.text),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            separator.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.topAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        contentView.backgroundColor = Color.background
    }
    
    func updateState() {
        contentView.backgroundColor = isSelected || isHighlighted ? Color.gray4 : nil
    }
}
