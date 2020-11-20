//
//  SidebarViewController.swift
//  Sidebar
//
//  Created by Dmitriy Zharov on 21.11.2020.
//

import UIKit

private enum Const {
    enum StackView {
        static let axis: NSLayoutConstraint.Axis = .vertical
        static let distribution: UIStackView.Distribution = .fill
        static let alignment: UIStackView.Alignment = .fill
    }
}

@objc
final class SidebarViewController: UIViewController {
    enum ReuseIdentifiers {
        static let Header = "Header"
        static let Cell = "Cell"
    }
    
    // MARK: - Public Properties
    @objc private(set) var sections: [SidebarSection]?
    @objc var sectionsProvider: (() -> [SidebarSection]?)? {
        didSet {
            reloadSections()
        }
    }
    
    @objc func reloadSections() {
        sections = sectionsProvider?()
        updateData()
    }
    
    /// Default value: nil
    @objc var selectedItem: SidebarItem?
    
    @objc lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.hidesNavigationBarDuringPresentation = false
        view.obscuresBackgroundDuringPresentation = false
        
        return view
    }()
    
    @objc weak var delegate: SidebarViewControllerDelegate?
    
    // MARK: - Private Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = Const.StackView.axis
        stackView.alignment = Const.StackView.alignment
        stackView.distribution = Const.StackView.distribution
        
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.alwaysBounceVertical = true
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    @objc weak var supplementaryView: UIView? {
        didSet {
            if let oldView = oldValue {
                oldView.removeFromSuperview()
                stackView.removeArrangedSubview(oldView)
            }
            if let view = supplementaryView {
                stackView.addArrangedSubview(view)
            }
        }
    }
    
    @available(iOS 13, *)
    private lazy var dataSource: UICollectionViewDiffableDataSource<SidebarSection, SidebarItem>? = nil

    // MARK: - ViewController's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserInterfaceIdiom() != .mac {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            title = nil
        }
        
        switch UserInterfaceIdiom() {
        case .mac:
            view.backgroundColor = nil
        case .pad:
            view.backgroundColor = Color.groupedBackground
        case .phone:
            view.backgroundColor = Color.background
        }
        
        setupSubviews()
        setupConstraints()
        
        configureCollectionViewLayout()
        if #available(iOS 14, *) {
            configureDataSource()
        }
        
        updateData()
        
        if let selectedItem = selectedItem, let indexPathForSelectedItem = self.indexPath(for: selectedItem) {
            if UserInterfaceIdiom() != .phone {
                collectionView.selectItem(at: indexPathForSelectedItem, animated: true, scrollPosition: .top)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserInterfaceIdiom() == .mac {
            navigationItem.searchController = searchController
        }
        
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.sizeToFit()
        }
    }

    @objc
    private func beginSearching(with command: UIKeyCommand) -> Bool {
        self.searchController.searchBar.becomeFirstResponder()
        return true
    }
}

// MARK: - Update
extension SidebarViewController {
    private func updateData(animated: Bool = true) {
        if #available(iOS 14, *) {
            let sectionSnapshots = dataSourceSectionSnapshots()
            sectionSnapshots.forEach { sidebarSection, snapshot in
                dataSource?.apply(snapshot, to: sidebarSection, animatingDifferences: animated)
            }
        } else {
            collectionView.reloadData()
        }
    }
}

// MARK: - Private Functions
extension SidebarViewController {
    private func setupSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(collectionView)
        if let view = supplementaryView {
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureCollectionViewLayout() {
        var collectionViewLayout: UICollectionViewLayout?
        if #available(iOS 14, *) {
            collectionViewLayout = generateUniversalLayout()
        } else {
            switch UserInterfaceIdiom() {
            case .mac:
                if #available(iOS 13, *) {
                    collectionViewLayout = generateMacLayout()
                } else {
                    fatalError()
                }
            case .pad:
                collectionViewLayout = generatePadLayout()
            case .phone:
                collectionViewLayout = generatePhoneLayout()
            }        }
        collectionView.collectionViewLayout = collectionViewLayout!
    }
    
    @available(iOS 14, *)
    private func configureDataSource() {
        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SidebarItem> { cell, indexPath, item in
            var contentConfiguration = UIListContentConfiguration.sidebarHeader()
            contentConfiguration.text = item.title
                
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [.outlineDisclosure()]
        }
            
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SidebarItem> { cell, indexPath, item in
            var contentConfiguration = UIListContentConfiguration.sidebarCell()
            contentConfiguration.text = item.title
            contentConfiguration.image = item.image
                
            cell.contentConfiguration = contentConfiguration
            cell.accessories = []
        }
            
        dataSource = UICollectionViewDiffableDataSource<SidebarSection, SidebarItem>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
    }
    
    private func configuredReusableCell(forItem sidebarItem: SidebarItem, at indexPath:IndexPath) -> UICollectionViewCell? {
        if let sidebarSection = sidebarItem as? SidebarSection {
            guard var cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SidebarViewController.ReuseIdentifiers.Header,
                    for: indexPath) as? SidebarItemHeaderCell else {
                return nil
            }

            cell.text = sidebarSection.title

            return cell as? UICollectionViewCell
        } else {
            guard var cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SidebarViewController.ReuseIdentifiers.Cell,
                    for: indexPath) as? SidebarItemListCell else {
                return nil
            }

            cell.text = sidebarItem.title
            cell.image = sidebarItem.image

            return cell as? UICollectionViewCell
        }
    }
    
    @available(iOS 14.0, *)
    private func dataSourceSectionSnapshots() -> [(SidebarSection, NSDiffableDataSourceSectionSnapshot<SidebarItem>)] {
        guard let sections = sections ?? sectionsProvider?() else {
            fatalError()
        }
        
        var sectionsSnapshot = [(SidebarSection, NSDiffableDataSourceSectionSnapshot<SidebarItem>)]()
        sections.forEach { section in
            var snapshot = NSDiffableDataSourceSectionSnapshot<SidebarItem>()
            snapshot.append([section]) /* Section item before plain items. Thanks, Apple */
            snapshot.expand([section])
            snapshot.append(section.subitems ?? [], to: section)
            
            sectionsSnapshot.append((section, snapshot))
        }
        
        return sectionsSnapshot
    }
    
    @available(iOS 13, *)
    private func dataSourceSnapshot() -> NSDiffableDataSourceSnapshot<SidebarSection, SidebarItem> {
        guard let sections = sections ?? sectionsProvider?() else {
            fatalError()
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SidebarSection, SidebarItem>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems([section], toSection: section) /* Секция среди элементов */
            snapshot.appendItems(section.subitems ?? [], toSection: section)
        }
        
        return snapshot
    }
}

// MARK: - Generate Layout
extension SidebarViewController {
    @available(iOS 14, *)
    private func generateUniversalLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let appearance: UICollectionLayoutListConfiguration.Appearance = UserInterfaceIdiom() == .phone ? .plain : .sidebar
            var configuration = UICollectionLayoutListConfiguration(appearance: appearance)
            configuration.showsSeparators = UserInterfaceIdiom() == .phone ? true : false
            configuration.headerMode = UserInterfaceIdiom() == .phone ? .none : .firstItemInSection
            configuration.backgroundColor = self.view.backgroundColor
            
            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    @available(iOS 13, *)
    private func generateMacLayout() -> UICollectionViewLayout {
        collectionView.register(
            SidebarItemMacHeaderCell.self,
            forCellWithReuseIdentifier: SidebarViewController.ReuseIdentifiers.Header
        )
        collectionView.register(
            SidebarItemMacListCell.self,
            forCellWithReuseIdentifier: SidebarViewController.ReuseIdentifiers.Cell
        )
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
             
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(SidebarConstants.Mac.Row.height))
            
            let spacing = SidebarConstants.Mac.Spacing.vertical
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func generatePadLayout() -> UICollectionViewLayout {
        collectionView.register(
            SidebarItemPadHeaderCell.self,
            forCellWithReuseIdentifier: SidebarViewController.ReuseIdentifiers.Header
        )
        collectionView.register(
            SidebarItemPadListCell.self,
            forCellWithReuseIdentifier: SidebarViewController.ReuseIdentifiers.Cell
        )
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.minimumLineSpacing = 0.0
            
        return layout
    }
    
    private func generatePhoneLayout() -> UICollectionViewLayout {
        collectionView.register(
            SidebarItemPhoneHeaderCell.self,
            forCellWithReuseIdentifier: SidebarViewController.ReuseIdentifiers.Header
        )
        collectionView.register(
            SidebarItemPhoneListCell.self,
            forCellWithReuseIdentifier: SidebarViewController.ReuseIdentifiers.Cell
        )
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        layout.minimumLineSpacing = 0.0
        
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension SidebarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = sections?[section], let items = section.subitems else {
            return 0
        }
        return items.count > 0 ? 1 /* Sectrion item before plain items */ + items.count : 0 /* Don't show section items */
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = item(for: indexPath) else {
            fatalError()
        }
        return self.configuredReusableCell(forItem: item, at: indexPath) ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension SidebarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if #available(iOS 14, *) {
            return true
        } else {
            // MARK: Блокируем нажатия на заголовки
            return item(for: indexPath) as? SidebarSection == nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return item(for: indexPath) as? SidebarSection == nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sidebarItem = item(for: indexPath) else { return }
        selectedItem = sidebarItem
        
        self.delegate?.sidebarViewController(self, didSelect: sidebarItem)

        if case .phone = UserInterfaceIdiom() {
            self.collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SidebarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leadingInset = UserInterfaceIdiom() == .phone ? SidebarConstants.Phone.Row.Offset.leading : SidebarConstants.Pad.Row.Offset.leading
        let trailingInset = UserInterfaceIdiom() == .phone ? SidebarConstants.Phone.Row.Offset.trailing : SidebarConstants.Pad.Row.Offset.trailing
        let height = UserInterfaceIdiom() == .phone ? SidebarConstants.Phone.Row.height : SidebarConstants.Pad.Row.height
        
        return CGSize(width: self.view.bounds.width - leadingInset - trailingInset, height: height)
    }
}

// MARK: - Convinience Methods
extension SidebarViewController {
    func indexPath(for item: SidebarItem) -> IndexPath? {
        if #available(iOS 14, *) {
            return dataSource?.indexPath(for: item)
        } else {
            return nil
        }
    }
    
    func item(for indexPath: IndexPath) -> SidebarItem? {
        if #available(iOS 14, *) {
            return dataSource?.itemIdentifier(for: indexPath)
        } else {
            guard let section = sections?[indexPath.section] else {
                return nil
            }
            if indexPath.item == 0 {
                return section
            } else {
                return section.subitems?[indexPath.item - 1 /* Section item before plain items */]
            }
        }
    }
}
