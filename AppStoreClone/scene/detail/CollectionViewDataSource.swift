//
//  CollectionViewDataSource.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class CollectionViewDataSource: NSObject {
    private var titleEntity: TitleEntity?
}
extension CollectionViewDataSource: UICollectionViewDataSource {
    func setDetailDTO(_ titleEntity: TitleEntity?) {
        self.titleEntity = titleEntity
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = DetailSection(rawValue: section) else { return 0 }
        switch section {
        case .title:
            return TitleCell.cellCount
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
        }
    }
}

enum DetailSection: Int {
    case title
}
extension DetailSection {
    var value: Int {
        return rawValue
    }
}
