//
//  RxMoyaProvider+Dribbble.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Moya

class Provider {
    static let sharedDribbble: RxMoyaProvider<Dribbble> = {
        let TESTING = true

        guard !TESTING else {
            print("TEST MODE API (with logger & stubs)")
            return RxMoyaProvider<Dribbble>(stubClosure: MoyaProvider<Dribbble>.delayedStub(1),
                                            plugins: [NetworkLoggerPlugin()])
        }

        #if DEBUG
            print("DEBUG MODE API (with logger)")
            return RxMoyaProvider<Dribbble>(plugins: [NetworkLoggerPlugin()])
        #else
            return RxMoyaProvider<Dribbble>()
        #endif
    }()

    private init() {}
}
