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
    
    func setDetailDTO(_ detailDTO: DetailDTO) {
        self.titleEntity = detailDTO.convertTitleEntity()
        self.newFeatureEntity = detailDTO.convertNewFeatureEntity()
    }
}
