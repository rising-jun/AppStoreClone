//
//  DetailViewController.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class DetailViewController: UIViewController {
    let viewModel = DetailViewModel()
    private let dataSource = CollectionViewDataSource()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var collectionView: UICollectionView = {
        guard let compositionalLayout = CompositionalLayoutFactory.makeCompositionalLayout() else { return UICollectionView() }
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.id)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
}
extension DetailViewController {
    private func layout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate( [collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                      collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)])
    }
    
    private func attribute() {
        collectionView.dataSource = dataSource
        dataSource.setDetailDTO(viewModel.titleEntity)
    }
    
    private func bind() {
        viewModel.titleImageFetched = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(item: 0, section: DetailSection.title.value)])
            }
        }
    }
}

enum CompositionalLayoutFactory {
    static func makeCompositionalLayout() -> UICollectionViewCompositionalLayout? {
        return UICollectionViewCompositionalLayout { (section, environ) -> NSCollectionLayoutSection? in
            guard let section = DetailSection(rawValue: section) else { return nil }
            switch section {
            case .title:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .none
                return section
            }
            
        }
    }
}
