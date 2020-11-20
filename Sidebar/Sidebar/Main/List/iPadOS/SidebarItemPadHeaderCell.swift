//
//  SidebarItemPadCell.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

class SidebarItemPadHeaderCell: UICollectionViewCell, SidebarItemHeaderCell {
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
        view.font = UIFont.systemFont(ofSize: SidebarConstants.Pad.Header.textSize, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13, *) {
            let chevronImage = UIImage(systemName: "chevron.right")
            view.image = chevronImage
        }
        
        // TODO: Collapse
        view.isHidden = true
        
        view.tintColor = Color.accent
        view.contentMode = .scaleAspectFit
        
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
        contentView.addSubview(textLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SidebarConstants.Pad.Header.Offset.leading),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SidebarConstants.Pad.Header.Offset.trailing),
            imageView.heightAnchor.constraint(equalToConstant: SidebarConstants.Pad.Header.Glyph.height),
            imageView.widthAnchor.constraint(equalToConstant: SidebarConstants.Pad.Header.Glyph.width)
        ])
    }
    
    func updateState() {
        let rotationTransform = isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi / 2) : CGAffineTransform.identity
        UIView.animate(withDuration: 0.3) {
            self.imageView.transform = rotationTransform
        }
    }
}

