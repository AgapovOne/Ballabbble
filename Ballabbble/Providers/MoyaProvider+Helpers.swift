//
//  MoyaProvider+Helpers.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation
import Swift

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

extension Data {
    init(fileName: String) {
        let path = Bundle.main.url(forResource: fileName, withExtension: "json")
        // swiftlint:disable:next force_try
        try! self.init(contentsOf: path!)
    }
}
