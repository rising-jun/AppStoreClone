//
//  DetailPreviewModel.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import Foundation

final class DetailPreviewModel {
    private(set) var state: DetailPreviewState?
    func setPreviewState(_ state: DetailPreviewState?) {
        self.state = state
    }
    
    var dismissPreviewController: (() -> ())?
    func completeButtonTapped() {
        dismissPreviewController?()
    }
    
    var scrollCollectionItem: (() -> ())?
    func viewDidLoad() {
        scrollCollectionItem?()
    }
}
struct DetailPreviewState {
    let imageData: [Data]?
    let itemIndex: Int
}
