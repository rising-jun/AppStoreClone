//
//  CollectionViewDataSource.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class CollectionViewDataSource: NSObject {
    private var detailEntity: DetailEntityUsable?
    private var previewItemCount = 0
}
extension CollectionViewDataSource {
    func setDetailEntity(_ detailEntity: DetailEntityUsable?) {
        self.detailEntity = detailEntity
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
        case .description:
            return UICollectionReusableView()
        case .info:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeader.id, for: indexPath) as? InfoHeader else { return UICollectionReusableView() }
            return header
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
        case .description:
            return DescriptionCell.cellCount
        case .info:
            return InfoCell.cellCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = DetailSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .title:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.id, for: indexPath) as? TitleCell else { return UICollectionViewCell() }
            guard let titleEntity = self.detailEntity?.getTitleEntityUsable() else { return UICollectionViewCell() }
            cell.configuration(with: titleEntity)
            guard let imageData = titleEntity.getTitleImage() else { return cell }
            cell.configuration(imageData: imageData)
            return cell
        case .newFeature:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFeatureCell.id, for: indexPath) as? NewFeatureCell else { return UICollectionViewCell() }
            guard let newFeatureEntity = detailEntity?.getNewFeatureEntityUsable() else { return UICollectionViewCell() }
            cell.configuration(with: newFeatureEntity)
            return cell
        case .preview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.id, for: indexPath) as? PreviewCell else { return UICollectionViewCell() }
            guard let previewEntity = detailEntity?.getPreviewEntityUsable() else { return UICollectionViewCell() }
            let data = previewEntity.getImageData()
            cell.setImage(data: data[indexPath.item])
            return cell
        case .description:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCell.id, for: indexPath) as? DescriptionCell else { return UICollectionViewCell() }
            guard let descriptionEntity = detailEntity?.getDescriptionEntityUsable() else { return UICollectionViewCell() }
            cell.configuration(with: descriptionEntity)
            return cell
        case .info:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.id, for: indexPath) as? InfoCell else { return UICollectionViewCell() }
            guard let infoEntity = detailEntity?.getInfoEntityUsable() else { return cell }
            guard let infoSeq = InfoSequence(rawValue: indexPath.item) else { return UICollectionViewCell() }
            switch infoSeq {
            case .provider:
                cell.configuration(title: infoSeq.title, contents: infoEntity.getArtistName())
            case .reviewRating:
                cell.configuration(title: infoSeq.title, contents: infoEntity.getProcessedReviewRating())
            case .appSize:
                cell.configuration(title: infoSeq.title, contents: infoEntity.getProcessedAppSize())
            case .category:
                cell.configuration(title: infoSeq.title, contents: infoEntity.getCategory())
            case .surpportDevice:
                cell.configuration(title: infoSeq.title, contents: infoEntity.getAllDevice(),expend:  infoEntity.isExpendSupportDevice(), expendAction: infoEntity.getMoreSupportDeviceAction())
            }
            return cell
        }
    }
}

enum DetailSection: Int {
    case title
    case newFeature
    case preview
    case description
    case info
}
extension DetailSection {
    var value: Int {
        return rawValue
    }
    static let numberOfSection: Int = 5
}
