//
//  DetailViewModel.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation
import OSLog

final class DetailViewModel {
    private let imageManager: ImageManagable
    private let dateManager: DateManagable
    private let stringManager: StringManagable
    private let decimicalManager: DecimalManagable
    private let serialQueue = DispatchQueue.global()
    var titleImageFetched: (() -> ())?
    
    init(imageManager: ImageManagable,
         dateManager: DateManagable,
         stringManager: StringManagable,
         decimicalManager: DecimalManagable) {
        self.imageManager = imageManager
        self.dateManager = dateManager
        self.stringManager = stringManager
        self.decimicalManager = decimicalManager
    }
    
    private(set) var detailEntity: DetailEntityUsable?
    
    private(set) var titleEntity: TitleEntityUsable? {
        didSet {
            guard let titleEntity = titleEntity else { return }
            imageManager.fetchImage(from: titleEntity.getImageURL()) { result in
                switch result {
                case .success(let data):
                    titleEntity.setTitleImage(data: data)
                    self.titleImageFetched?()
                case .failure(let error):
                    os_log(.error, log: .default, "%@", error as CVarArg)
                }
            }
        }
    }
    
    private(set) var newFeatureEntity: NewFeatureEntityUsable? {
        didSet {
            guard let newFeatureEntity = newFeatureEntity else { return }
            let dateGap = dateManager.findDateGap(date: newFeatureEntity.getCurrentVersionDate())
            newFeatureEntity.setCurrentVersionDate(dateGap)
        }
    }
    
    var previewImageUpdated: ((Int) -> ())?
    private(set) var previewEntity: PreviewEntityUsable? {
        didSet {
            guard let previewEntity = previewEntity else { return }
            let urls = previewEntity.getImageURLs()
            for url in urls {
                imageManager.fetchImage(from: url) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        self.serialQueue.async {
                            self.previewEntity?.appendImage(data: data)
                            self.previewImageUpdated?(self.previewEntity?.getImageIndex() ?? 0)
                            self.previewEntity?.increaseImageIndex()
                        }
                    case .failure(let error):
                        os_log(.error, log: .default, "%@", error as CVarArg)
                    }
                }
            }
        }
    }
    
    var tappedDescriptioinMore: ((Int) -> ())?
    private(set) var descriptionEntity: DescriptionEntityUsable? {
        didSet {
            descriptionEntity?.setMoreDescriptionAction { [weak self] in
                guard let self = self else { return }
                self.descriptionEntity?.expendDescription()
                guard let descriptionLine = self.descriptionEntity?.getDescription().numberOfLines else { return }
                self.tappedDescriptioinMore?(descriptionLine)
            }
        }
    }
    
    var tappedSurpportDeviceMore: ((Int) -> ())?
    private(set) var infoEntity: InfoEntityUsable? {
        didSet {
            guard let infoEntity = infoEntity else { return }
            let processedAppSize = decimicalManager.convertAppSize(infoEntity.getFileSize())
            infoEntity.setProcessedAppSize("\(processedAppSize)MB")
            let processedReviewRating = decimicalManager.convertReview(infoEntity.getUserRating())
            infoEntity.setProcessedReviewRating(processedReviewRating)
            let allDevice = stringManager.stringAppender(strings: infoEntity.getSupportDevice())
            infoEntity.setAllDevice(allDevice)
            infoEntity.setMoreSupportDeviceAction { [weak self] in
                guard let self = self else { return }
                self.infoEntity?.expendSupportDevice()
                guard let deviceKind = self.infoEntity?.getSupportDevice().count else { return }
                self.tappedSurpportDeviceMore?(deviceKind)
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
        case .description: return
        case .info: return
        }
    }
    
    
}
extension DetailViewModel: DetailViewModelType {
    func setDetailDTO(_ detailEntity: DetailEntityUsable) {
        self.detailEntity = detailEntity
        self.titleEntity = detailEntity.getTitleEntityUsable()
        self.newFeatureEntity = detailEntity.getNewFeatureEntityUsable()
        self.previewEntity = detailEntity.getPreviewEntityUsable()
        self.descriptionEntity = detailEntity.getDescriptionEntityUsable()
        self.infoEntity = detailEntity.getInfoEntityUsable()
    }
}

typealias DetailViewModelType = DetailViewModelInput & DetailViewModelOutput & DetailViewBinding
protocol DetailViewModelInput {
    func setDetailDTO(_ detailEntity: DetailEntityUsable)
    func collectionCellTapped(index: IndexPath)
}
protocol DetailViewModelOutput {
    var detailEntity: DetailEntityUsable? { get }
    var titleEntity: TitleEntityUsable? { get }
    var newFeatureEntity: NewFeatureEntityUsable? { get }
    var previewEntity: PreviewEntityUsable? { get }
    var descriptionEntity: DescriptionEntityUsable? { get }
    var infoEntity: InfoEntityUsable? { get }
    
    
}
protocol DetailViewBinding {
    var titleImageFetched: (() -> ())? { get set }
    var previewImageUpdated: ((Int) -> ())? { get set }
    var tappedDescriptioinMore: ((Int) -> ())? { get set }
    var tappedSurpportDeviceMore: ((Int) -> ())? { get set }
    var tappedPreviewImage: ((Int) -> ())? { get set }
}
