//
//  CompositionalLaoutFactory.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import UIKit

final class CompositionalLayoutFactory {
    private(set) var descriptionHeight: NSCollectionLayoutDimension
    private(set) var supportDeviceHeight: CGFloat
    
    init() {
        descriptionHeight = .estimated(230)
        supportDeviceHeight = 40
    }
    
    func setMoreDescriptionHeight(textCount: Int) {
        descriptionHeight = .estimated(CGFloat(textCount) * 40)
    }
    
    func setSupportDeviceHeight(textCount: Int) {
        supportDeviceHeight = CGFloat((textCount * 30))
    }
    
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout? {
        return UICollectionViewCompositionalLayout { [weak self] (section, environ) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            guard let section = DetailSection(rawValue: section) else { return nil }
            switch section {
            case .title:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .none
                return section
            case .newFeature:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .none
                return section
            case .preview:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(0.6)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .groupPaging
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)]
                return section
            case .description:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: self.descriptionHeight))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: self.descriptionHeight), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .none
                return section
            case .info:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)))
                let expendItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(self.supportDeviceHeight)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                expendItem.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let itemGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitem: item, count: 4)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)), subitems: [itemGroup, expendItem])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                return section
            }
        }
    }
    
    func makeDetailPreviewCompositionalLayout() -> UICollectionViewCompositionalLayout? {
        return UICollectionViewCompositionalLayout { (section, environ) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.9)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
    }
}
