//
//  LoginViewModel.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation
import OSLog

final class SearchViewModel {
    private let repository: ServiceRepository
    var fetchSuccess: ((DoodleDTO) -> Void)?
    var fetchFailed: (() -> Void)?
    
    init(repository: ServiceRepository) {
        self.repository = repository
    }
    
    var networkResult: Result<DoodleDTO, APIError>? {
        didSet {
            switch networkResult {
            case .success(let doodleDTO):
                doodleDTO.resultCount != 0 ? self.fetchSuccess?(doodleDTO) : self.fetchFailed?()
            case .failure(let error):
                self.fetchFailed?()
                os_log(.error, log: .default, "%@", error as CVarArg)
            case .none:
                self.fetchFailed?()
            }
        }
    }
}
extension SearchViewModel: SearchViewModelType {
    func checkButtonTapped(id: String) {
        repository.requestAPI(api: AppStoreAPI.search(id: id), decodeType: DoodleDTO.self) { [weak self] result in
            guard let self = self else { return }
            self.networkResult = result
        }
    }
}

typealias SearchViewModelType = SearchViewModelInput & SearchViewModelOutput & SearchViewModelBinding

protocol SearchViewModelInput {
    func checkButtonTapped(id: String)
}
protocol SearchViewModelOutput {
    var networkResult: Result<DoodleDTO, APIError>? { get set }
}
protocol SearchViewModelBinding {
    var fetchSuccess: ((DoodleDTO) -> Void)? { get set }
    var fetchFailed: (() -> Void)? { get set }
}
