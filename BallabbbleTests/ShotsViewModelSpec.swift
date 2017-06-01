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

class ShotsViewModelSpec: QuickSpec {
    override func spec() {
        describe("Shots View Model") {
            var viewModel = ShotsViewModel!

            beforeEach {
                viewModel = ShotsViewModel()
            }

            it("has no shots") {
                expect(viewModel.shots).to(beEmpty())
            }

            context("when loads") {
                beforeEach {
                    viewModel.load()
                }

                it("update shots") {

                }
            }
        }
    }
}
