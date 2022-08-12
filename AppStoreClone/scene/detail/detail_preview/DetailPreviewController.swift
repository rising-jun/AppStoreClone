//
//  DetailPreviewController.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import UIKit

final class DetailPreviewController: UIViewController {
    
    let viewModel = DetailPreviewModel()
    private let dataSource = PreviewCollectionDataSource()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        guard let compositionalLayout = CompositionalLayoutFactory.makeDetailPreviewCompositionalLayout() else { return UICollectionView() }
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.id)
        return collectionView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        layout()
        attribute()
    }
}
extension DetailPreviewController {
    private func attribute() {
        view.backgroundColor = .black
        collectionView.dataSource = dataSource
        dataSource.setPreviewState(viewModel.state)
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubviews(completeButton, collectionView)
        NSLayoutConstraint.activate( [completeButton.topAnchor.constraint(equalTo: view.topAnchor),
                                      completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                      completeButton.widthAnchor.constraint(equalToConstant: 100),
                                      completeButton.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate( [collectionView.topAnchor.constraint(equalTo: completeButton.bottomAnchor),
                                      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func bind() {
        viewModel.scrollCollectionItem = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath(item: self.viewModel.state?.itemIndex ?? 0, section: 0), at: [], animated: false)
            }
        }
        
        viewModel.dismissPreviewController = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc func completeButtonTapped(sender: Any) {
        viewModel.completeButtonTapped()
    }
}
