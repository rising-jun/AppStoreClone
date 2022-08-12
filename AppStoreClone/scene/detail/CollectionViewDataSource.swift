//
//  CollectionViewDataSource.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class CollectionViewDataSource: NSObject {
    private var titleEntity: TitleEntity?
    private var newFeatureEntity: NewFeatureEntity?
    private var previewEntity: PreviewEntity?
    private var previewItemCount = 0
}
extension CollectionViewDataSource {
    func setTitleEntity(_ titleEntity: TitleEntity?) {
        self.titleEntity = titleEntity
    }
    
    func setNewFeatureEntity(_ newFeatureEntity: NewFeatureEntity?) {
        self.newFeatureEntity = newFeatureEntity
    }
    
    func setPreviewEntity(_ previewEntity: PreviewEntity?) {
        self.previewEntity = previewEntity
    }
    
    func increasePreviewCount() {
        previewItemCount += 1
    }
}
extension CollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        DetailSection.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = DetailSection(rawValue: indexPath.section) else { return UICollectionReusableView() }
        switch section {
        case .title:
            return UICollectionReusableView()
        case .newFeature:
            return UICollectionReusableView()
        case .preview:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PreviewHeader.id, for: indexPath) as? PreviewHeader else { return UICollectionReusableView() }
                return header
            }
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PreviewFooter.id, for: indexPath) as? PreviewFooter else { return UICollectionReusableView() }
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = DetailSection(rawValue: section) else { return 0 }
        switch section {
        case .title:
            return TitleCell.cellCount
        case .newFeature:
            return NewFeatureCell.cellCount
        case .preview:
            return previewItemCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = DetailSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        guard let titleEntity = self.titleEntity else { return UICollectionViewCell() }
        switch section {
        case .title:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.id, for: indexPath) as? TitleCell else { return UICollectionViewCell() }
            cell.configuration(with: titleEntity)
            guard let imageData = titleEntity.imageData else { return cell }
            cell.configuration(imageData: imageData)
            return cell
        case .newFeature:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFeatureCell.id, for: indexPath) as? NewFeatureCell else { return UICollectionViewCell() }
            cell.configuration(with: newFeatureEntity)
            return cell
        case .preview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.id, for: indexPath) as? PreviewCell else { return UICollectionViewCell() }
            if let data = previewEntity?.imageData[indexPath.item] {
                cell.setImage(data: data)
            }
            return cell
        }
    }
}

enum DetailSection: Int {
    case title
    case newFeature
    case preview
}
extension DetailSection {
    var value: Int {
        return rawValue
    }
    static let numberOfSection: Int = 3
}
