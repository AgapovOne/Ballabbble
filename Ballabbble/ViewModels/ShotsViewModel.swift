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

    func provideShots() -> Driver<[Shot]> {
        return provider.request(.shots(type: nil))
            .filterSuccessfulStatusCodes()
            .mapArray(of: Shot.self)
            .asDriver(onErrorJustReturn: [])
    }
}
