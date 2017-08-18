//
//  ShotCell.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit
import Kingfisher

protocol ShotCellDataType {
    var image: URL { get }
    var title: String { get }
    var description: String { get }
}

extension Shot: ShotCellDataType {
    var image: URL { return complexImage.hidpi ?? complexImage.normal }
}

class ShotCell: UICollectionViewCell, NibLoadableView {
    // MARK: - UI Outlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var shotImageView: UIImageView!

    // MARK: - Public interface
    func configure(with shot: ShotCellDataType) {
        titleLabel.text = shot.title
        descriptionLabel.text = shot.description

        shotImageView.kf.setImage(with: shot.image)
    }
}
