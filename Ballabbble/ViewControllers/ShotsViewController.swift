//
//  ShotsViewController.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class ShotsViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Properties
    var viewModel: ShotsViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ShotsViewModel()

        viewModel.load()

        collectionView.reloadData()
    }
}

extension ShotsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shots.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShotCell = collectionView.dequeueReusableCell(for: indexPath)
//        cell.configure(with: viewModel.shots[indexPath.row])
        return cell
    }
}
