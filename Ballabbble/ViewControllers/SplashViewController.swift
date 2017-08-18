//
//  SplashViewController.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 17/08/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import RxSwift
import RxCocoa
import Cartography

class SplashViewController: UIViewController {

    private lazy var stackView = UIStackView()
    private lazy var shotsButton: UIButton = {
        $0.setTitle("Go to Shots", for: .normal)
        return $0
    }(UIButton(type: .system))

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        setupActions()
    }

    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)

        view.addSubview(stackView)

        stackView.addArrangedSubview(shotsButton)

        constrain(stackView) { stack in
            stack.center == stack.superview!.center
        }
    }

    private func setupActions() {
        shotsButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.openShots()
            })
            .disposed(by: disposeBag)
    }

    private func openShots() {
        let viewModel = ShotsViewModel()
        let shotsVC = ShotsViewController(viewModel: viewModel)

        navigationController?.pushViewController(shotsVC, animated: true)
    }
}
