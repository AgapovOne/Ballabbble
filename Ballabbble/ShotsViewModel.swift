//
//  ShotsViewModel.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class ShotsViewModel {

    // MARK: - Private properties
    private let disposeBag = DisposeBag()


    // MARK: - Lifecycle
    init() {

    }

    // MARK: - Public interface
    let shots: Driver<Shot>

    func load() {
        let provider = RxMoyaProvider<Dribbble>()

        provider.request(.shots(type(of: .all)))
            .filterSuccessfulStatusCodes()
            .map(Shot.self)
            .asSingle()
            .subscribe { (event) in
                switch event {
                case .error(let error):
                    break
                case .success(let shot):
                    break
                }
        }
    }
}
