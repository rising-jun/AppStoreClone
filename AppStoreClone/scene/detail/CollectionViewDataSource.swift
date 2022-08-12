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
}
extension CollectionViewDataSource: UICollectionViewDataSource {
    func setTitleEntity(_ titleEntity: TitleEntity?) {
        self.titleEntity = titleEntity
    }
    
    func setNewFeatureEntity(_ newFeatureEntity: NewFeatureEntity?) {
        self.newFeatureEntity = newFeatureEntity
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        DetailSection.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = DetailSection(rawValue: section) else { return 0 }
        switch section {
        case .title:
            return TitleCell.cellCount
        case .newFeature:
            return NewFeatureCell.cellCount
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
        }
    }
}

enum DetailSection: Int {
    case title
    case newFeature
}
extension DetailSection {
    var value: Int {
        return rawValue
    }
    
    static let numberOfSection: Int = {
        return 2
    }()
}
