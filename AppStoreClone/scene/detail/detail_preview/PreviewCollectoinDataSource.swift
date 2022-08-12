//
//  PreviewCollectoinDataSource.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import UIKit

final class PreviewCollectionDataSource: NSObject {
    private var state: DetailPreviewState?
}
extension PreviewCollectionDataSource {
    func setPreviewState(_ state: DetailPreviewState?) {
        self.state = state
    }
}
extension PreviewCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        state?.imageData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.id, for: indexPath) as? PreviewCell else { return UICollectionViewCell() }
        guard let imageData = state?.imageData?[indexPath.item] else { return cell }
        cell.setImage(data: imageData)
        return cell
    }
}
