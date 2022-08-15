//
//  DependencyFactory.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/15.
//

import Foundation

final class DependencyFactory { }
extension DependencyFactory: DependencyInjectable {
    func injectDetailDependency() -> DetailDependency {
        return DetailDependency(detailViewModel: DetailViewModel(dateManager: DateManager(), stringManager: StringManager(), decimicalManager: DecimalManager()))
    }
    
    func injectSearchDependency() -> SearchDependency {
        return SearchDependency(searchViewModel: SearchViewModel(repository: ServiceRepositoryImpl(session: URLSession.shared)),
                                detailDependency: self)
    }
}
typealias DependencyInjectable = SearchDependencyInjectable & DetailDependencyInjectable

protocol SearchDependencyInjectable {
    func injectSearchDependency() -> SearchDependency
}

protocol DetailDependencyInjectable {
    func injectDetailDependency() -> DetailDependency
}

struct SearchDependency {
    let searchViewModel: SearchViewModelType
    let detailDependency: DetailDependencyInjectable
}

struct DetailDependency {
    var detailViewModel: DetailViewModelType
}
