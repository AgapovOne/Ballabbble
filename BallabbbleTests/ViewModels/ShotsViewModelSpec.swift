//
//  ShotsViewModelSpec.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Quick
import Nimble

@testable
import Ballabbble
import Moya

class ShotsViewModelSpec: QuickSpec {
    override func spec() {
        describe("Shots View Model") {
            var viewModel: ShotsViewModel!
            var provider: RxMoyaProvider<Dribbble>!

            beforeEach {
                provider = RxMoyaProvider(endpointClosure: ShotsViewModelSpec.fakeEndpointsClosure,
                                          stubClosure: MoyaProvider<Dribbble>.immediatelyStub)
                viewModel = ShotsViewModel(provider: provider)
            }

            it("has no shots") {
                expect(viewModel.shots).to(beEmpty())
            }

            context("when loads") {
                beforeEach {
                    viewModel.load()
                }

                it("update shots") {
                    expect(viewModel.shots).toEventually(haveCount(3))
                }
            }
        }
    }

    // MARK: - Helpers
    static let fakeEndpointsClosure = { (target: Dribbble) -> Endpoint<Dribbble> in
        return Endpoint<Dribbble>(url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                                  sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                  method: target.method,
                                  parameters: target.parameters)
    }
}
