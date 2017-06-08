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
import RxDataSources

// MARK: - Declarations
fileprivate struct SectionOfShots {
    var items: [Item]
}

extension SectionOfShots: SectionModelType {
    typealias Item = Shot

    init(original: SectionOfShots, items: [Item]) {
        self = original
        self.items = items
    }
}

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
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfShots>()

        dataSource.configureCell = { (dataSource, collectionView, indexPath, item) in
            let cell: ShotCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: item)
            return cell
        }

        viewModel.provideShots()
            .map({ SectionOfShots(items: $0) })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

//        viewModel.provideShots()
//            .map({ SectionOfShots(items: $0) })
//            .drive(collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
    }
}
