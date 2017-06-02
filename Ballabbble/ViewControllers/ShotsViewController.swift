//
//  ShotsViewController.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShotsViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    var viewModel: ShotsViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ShotsViewModel()

        setupCollectionView()
    }

    private func setupCollectionView() {

        viewModel.provideShots()
            .drive(collectionView.rx.items(cellIdentifier: String(describing:ShotCell.self),
                                        cellType: ShotCell.self)) { (_, model, cell) in
                cell.configure(with: model)
            }.disposed(by: disposeBag)
    }
}
