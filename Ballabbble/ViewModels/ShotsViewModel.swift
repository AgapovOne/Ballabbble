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
    init(provider: RxMoyaProvider<Dribbble>) {
        self.provider = provider
    }

    convenience init() {
        self.init(provider: Provider.sharedDribbble)
    }

    // MARK: - Public interface
    lazy var shots: Driver<[SectionOfShots]> = {
        return self.provider.request(.shots(type: nil))
            .filterSuccessfulStatusCodes()
            .mapArray(of: Shot.self)
            .map({ [SectionOfShots(items: $0)] })
            .asDriver(onErrorJustReturn: [])
    }()

    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfShots> = {
        return RxCollectionViewSectionedReloadDataSource<SectionOfShots>()
    }()
}
