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
    
    private let compositionalLayoutFactory = CompositionalLayoutFactory()
    private lazy var collectionView: UICollectionView = {
        guard let compositionalLayout = compositionalLayoutFactory.makeCompositionalLayout() else { return UICollectionView() }
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.id)
        collectionView.register(NewFeatureCell.self, forCellWithReuseIdentifier: NewFeatureCell.id)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.id)
        collectionView.register(PreviewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PreviewHeader.id)
        collectionView.register(PreviewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PreviewFooter.id)
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: DescriptionCell.id)
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
        NSLayoutConstraint.activate( [collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func attribute() {
        collectionView.dataSource = dataSource
        dataSource.setDetailEntity(viewModel.detailEntity)
        collectionView.delegate = self
    }
    
    private func bind() {
        viewModel.titleImageFetched = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(item: 0, section: DetailSection.title.value)])
            }
        }
        
        viewModel.previewImageUpdated = { [weak self] item in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dataSource.increasePreviewCount()
                self.collectionView.insertItems(at: [IndexPath(item: item, section: DetailSection.preview.value)])
            }
        }
        
        viewModel.tappedPreviewImage = { [weak self] item in
            guard let self = self else { return }
            let detailPreviewController = DetailPreviewController()
            detailPreviewController.viewModel.setPreviewState(DetailPreviewState(imageData: self.viewModel.previewEntity?.getImageData(), itemIndex: item))
            detailPreviewController.modalPresentationStyle = .popover
            DispatchQueue.main.async {
                self.present(detailPreviewController, animated: true)
            }
        }
        
        viewModel.tappedDescriptioinMore = { [weak self] numberOfLines in
            guard let self = self else { return }
            self.compositionalLayoutFactory.setMoreDescriptionHeight(textCount: numberOfLines)
            self.collectionView.reloadItems(at: [IndexPath(item: 0, section: DetailSection.description.value)])
        }
    }
}
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionCellTapped(index: indexPath)
    }
}
