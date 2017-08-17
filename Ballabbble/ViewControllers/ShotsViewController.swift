//
//  ShotsViewController.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import RxCocoa
import RxDataSources

class ShotsViewController: UIViewController {

    // MARK: - Declarations
    private enum Constant {
        fileprivate enum Size {
            static let margin: CGFloat = 16.0
        }
    }

    // MARK: - UI Outlets
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width / 2 - (Constant.Size.margin), height: 300)
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constant.Size.margin, bottom: 0, right: Constant.Size.margin)
        layout.minimumInteritemSpacing = Constant.Size.margin
        layout.minimumLineSpacing = Constant.Size.margin
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .white
        return c
    }()

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    private let viewModel: ShotsViewModel

    // MARK: - Lifecycle
    init(viewModel: ShotsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        setupCollectionView()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(collectionView)

        constrain(collectionView) { collection in
            collection.edges == collection.superview!.edges
        }
    }

    private func setupCollectionView() {
        collectionView.register(ShotCell.self)

        viewModel.dataSource.configureCell = { (dataSource, collectionView, indexPath, item) in
            let cell: ShotCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: item)
            return cell
        }

        viewModel.shots
            .drive(collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
//            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource))
//            .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension ShotsViewController: UICollectionViewDelegate {
    
}
