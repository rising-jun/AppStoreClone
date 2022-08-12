//
//  DetailViewModel.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation
import OSLog

final class DetailViewModel {
    private let imageManager = ImageManager()
    private let dateManager = DateManager()
    private let serialQueue = DispatchQueue.global()
    var titleImageFetched: (() -> ())?
    private(set) var titleEntity: TitleEntity? {
        didSet {
            guard let titleEntity = titleEntity else { return }
            imageManager.fetchImage(from: titleEntity.imageURL) { result in
                switch result {
                case .success(let data):
                    titleEntity.setImage(data: data)
                    self.titleImageFetched?()
                case .failure(let error):
                    os_log(.error, log: .default, "%@", error as CVarArg)
                }
            }
        }
    }
    
    private(set) var newFeatureEntity: NewFeatureEntity? {
        didSet {
            let dateGap = dateManager.findDateGap(date: newFeatureEntity?.currentVersionDate ?? "")
            newFeatureEntity?.setCurrentVersionDate(dateGap)
        }
    }
    var previewImageUpdated: ((Int) -> ())?
    private(set) var previewEntity: PreviewEntity? {
        didSet {
            guard let urls = previewEntity?.imageURLs else { return }
            for url in urls {
                imageManager.fetchImage(from: url) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        self.serialQueue.sync {
                            self.previewEntity?.appendImage(data: data)
                            self.previewImageUpdated?(self.previewEntity?.imageIndex ?? 0)
                            self.previewEntity?.increaseImageIndex()
                        }
                    case .failure(let error):
                        os_log(.error, log: .default, "%@", error as CVarArg)
                    }
                }
            }
        }
    }
    
    var tappedPreviewImage: ((Int) -> ())?
    func collectionCellTapped(index: IndexPath) {
        guard let section = DetailSection(rawValue: index.section) else { return }
        switch section {
        case .title: return
        case .newFeature: return
        case .preview:
            tappedPreviewImage?(index.item)
        }
    }
    
    func setDetailDTO(_ detailDTO: DetailDTO) {
        self.titleEntity = detailDTO.convertTitleEntity()
        self.newFeatureEntity = detailDTO.convertNewFeatureEntity()
        self.previewEntity = detailDTO.convertPreviewEntity()
    }
}
