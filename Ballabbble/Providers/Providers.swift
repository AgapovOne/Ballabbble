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
        #if DEBUG
            print("DEBUG MODE API (with logger)")
            return RxMoyaProvider<Dribbble>(plugins: [NetworkLoggerPlugin()])
        #else
            return RxMoyaProvider<Dribbble>()
        #endif
    }()

    private init() {}
}
