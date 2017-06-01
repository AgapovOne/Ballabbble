//
//  DribbbleService.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 31/05/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation
import Moya

enum Dribbble {
    case
    shots(type: ShotType),
    shot(id: Int)
}

enum ShotType: String {
    case
    all,
    animated,
    attachments,
    debuts,
    playoffs,
    rebounds,
    teams
}

// MARK: - TargetType Protocol Implementation
extension Dribbble: TargetType {
    var baseURL: URL { return URL(string: "https://api.dribbble.com/v1")! }

    var path: String {
        switch self {
        case .shots:
            return "/shots"
        case .shot(let id):
            return "/shots/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .shots, .shot:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .shots(let type):
            if type == .all {
                return nil
            } else {
                return ["list": type]
            }
        case .shot:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .shots, .shot:
            return URLEncoding.default
        }
    }

    var sampleData: Data {
        switch self {
        case .shots:
            return Data()
        case .shot:
            return Data()
        }
    }

    var task: Task {
        switch self {
        case .shots, .shot:
            return .request
        }
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

public func url(route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

let endpointClosure = { (target: Dribbble) -> Endpoint<Dribbble> in
    return Endpoint<Dribbble>(url: url(route: target), sampleResponseClosure: {
        .networkResponse(200, target.sampleData)
    }, method: target.method, parameters: target.parameters)
}
