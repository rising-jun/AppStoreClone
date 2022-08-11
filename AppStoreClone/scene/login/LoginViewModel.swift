//
//  LoginViewModel.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation
import OSLog

final class LoginViewModel {
    private let repository = ServiceRepository(session: URLSession.shared)
    
    var fetchSuccess: ((DoodleDTO) -> Void)?
    var fetchFailed: (() -> Void)?
    
    private var networkResult: Result<DoodleDTO, APIError>? {
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
extension LoginViewModel {
    func checkButtonTapped(id: String) {
        repository.requestAPI(api: AppStoreAPI.search(id: id), decodeType: DoodleDTO.self) { [weak self] result in
            guard let self = self else { return }
            self.networkResult = result
        }
    }
}
