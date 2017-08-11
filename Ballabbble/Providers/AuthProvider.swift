//
//  AuthProvider.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 10/08/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Moya
import RxSwift
import Result

public typealias AuthenticationClosure = (_ done: () -> Void) -> Void
public typealias RxExpiredTokenClosure = (Response) -> Bool
public typealias ExpiredTokenClosure = (MoyaError) -> Bool

public enum Error: Swift.Error {
    case missingAuthenticationBlock
    case failedReauthentication
}

public class RxAuthProvider<Target>: RxMoyaProvider<Target> where Target: TargetType {

    private let disposeBag = DisposeBag()

    private var authenticationClosure: AuthenticationClosure
    private var expiredTokenCheckClosure: RxExpiredTokenClosure

    // Reauthentication state to manage privately
    private var isReauthenticationInProgress: Bool = false
    private var requestsToRetryStack = [Target]()

    init(authenticationClosure: @escaping AuthenticationClosure,
         expiredTokenCheckClosure: @escaping RxExpiredTokenClosure,
         endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        self.authenticationClosure = authenticationClosure
        self.expiredTokenCheckClosure = expiredTokenCheckClosure

        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosure,
                   stubClosure: stubClosure,
                   manager: manager,
                   plugins: plugins,
                   trackInflights: trackInflights)
    }

    public override func request(_ token: Target) -> Observable<Response> {
        return _request(token)
    }

    private func _request(_ token: Target, isSecondTryAfterAuth: Bool = false) -> Observable<Response> {
        return super.request(token)
            .flatMap { [unowned self] response -> Observable<Response> in

                // Check that token is expired
                if self.expiredTokenCheckClosure(response) {

                    // Check if me second try fail return error and move to login view
                    if isSecondTryAfterAuth {
                        return Observable<Response>.error(Error.failedReauthentication)
                    }

                    if self.isReauthenticationInProgress {
                        self.requestsToRetryStack.append(token)
                    }

                    //i think is here where my old request is execute
                    return Observable.create { observer in
                        self.authenticationClosure {
                            self._request(token, isSecondTryAfterAuth: true)
                                .subscribe { event in
                                    observer.on(event)
                                }.addDisposableTo(self.disposeBag)
                        }
                        return Disposables.create()
                    }
                } else {
                    return Observable.just(response)
                }
        }
    }
}

public class AuthProvider<Target>: MoyaProvider<Target> where Target: TargetType {

    private var authenticationClosure: AuthenticationClosure
    private var expiredTokenCheckClosure: ExpiredTokenClosure

    // Reauthentication state to manage privately
    private var isReauthenticationInProgress: Bool = false
    private var requestsToRetryQueue = [(Target, Completion)]()

    init(authenticationClosure: @escaping AuthenticationClosure,
         expiredTokenCheckClosure: @escaping ExpiredTokenClosure,
         endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        self.authenticationClosure = authenticationClosure
        self.expiredTokenCheckClosure = expiredTokenCheckClosure

        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosure,
                   stubClosure: stubClosure,
                   manager: manager,
                   plugins: plugins,
                   trackInflights: trackInflights)
    }

    public override func request(_ target: Target, completion: @escaping Completion) -> Cancellable {
        return _request(target, completion: completion)
    }

    private func _request(_ target: Target, isSecondTryAfterAuth: Bool = false, completion: @escaping Completion) -> Cancellable {
        return super.request(target) { result in
            switch result {
            case .failure(let error):
                if self.expiredTokenCheckClosure(error) {

                    // Check if me second try after reauth fail return error.
                    guard isSecondTryAfterAuth == false else {
                        completion(Result.failure(MoyaError.underlying(Error.failedReauthentication)))
                        return
                    }

                    // If reauthenticating, should be added to stack
                    if self.isReauthenticationInProgress {
                        self.requestsToRetryQueue.append((target, completion))
                    } else {
                        self.isReauthenticationInProgress = true
                        self.authenticationClosure {
                            self.isReauthenticationInProgress = false
                            _ = self._request(target, isSecondTryAfterAuth: true) { result in
                                completion(result)
                                self.requestsToRetryQueue.forEach { _ = self.request($0.0, completion: $0.1) }
                            }
                        }
                    }
                } else {
                    completion(result)
                }
            case .success:
                completion(result)
            }
        }
    }
}
