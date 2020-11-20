//
//  SidebarItem.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

@objc
class SidebarItem: UIBarItem {
    @objc var parent: SidebarItem?
    
    private var _title: String?
    private var _image: UIImage?
    private var _tag: Int?
    
    override var title: String? {
        set {
            _title = newValue
        }
        get {
            _title
        }
    }
    
    override var image: UIImage? {
        set {
            _image = newValue
        }
        get {
            _image
        }
    }
    
    override var tag: Int {
        set {
            _tag = newValue
        }
        get {
            _tag ?? 0
        }
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(self.title)
        hasher.combine(self.tag)
        
        return hasher.finalize()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? SidebarItem else {
            return false
        }
        return self.title == object.title && self.tag == object.tag
    }
    
    @objc init(title: String?, image: UIImage?, tag: Int) {
        super.init()
        self.title = title
        self.image = image
        self.tag = tag
    }
    
    @objc convenience init(barItem: UIBarItem) {
        self.init(title: barItem.title, image: barItem.image, tag: barItem.tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
