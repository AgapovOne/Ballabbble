//
//  ShotsViewModel.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation
import Moya
import Marshal
import RxSwift
import RxCocoa
import RxDataSources

// MARK: - Declarations
struct SectionOfShots {
    var items: [Item]
}

extension SectionOfShots: SectionModelType {
    typealias Item = Shot

    init(original: SectionOfShots, items: [Item]) {
        self = original
        self.items = items
    }
}

class ShotsViewModel {
    // MARK: - Private properties
    private let disposeBag = DisposeBag()

    private let provider: RxMoyaProvider<Dribbble>

    // MARK: - Lifecycle
    init(provider: RxMoyaProvider<Dribbble> = Provider.sharedDribbble) {
        self.provider = provider

        let _refresh = PublishSubject<Void>()
        self.refresh = _refresh.asObserver()

        self.shots = _refresh
            .flatMap {
                provider.request(.shots(type: nil))
                    .filterSuccessfulStatusCodes()
                    .mapArray(of: Shot.self)
                    .catchError { error in
                        print(error)
                        return Observable.empty()
                    }
            }
            .map({ [SectionOfShots(items: $0)] })
            .asDriver(onErrorJustReturn: [])
    }

    // MARK: - Public interface

    // MARK: Inputs
    /// Call to reload repositories.
    let refresh: AnyObserver<Void>

    // MARK: Outputs
    var shots: Driver<[SectionOfShots]>

    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfShots> = {
        return RxCollectionViewSectionedReloadDataSource<SectionOfShots>()
    }()
}
