//
//  ShotCell.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit
import Kingfisher

class ShotCell: UICollectionViewCell, NibLoadableView {
    // MARK: - UI Outlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var shotImageView: UIImageView!

    // MARK: - Public interface
    func configure(with shot: Shot) {
        titleLabel.text = shot.title
        descriptionLabel.text = shot.description

        shotImageView.kf.setImage(with: shot.image.hidpi ?? shot.image.normal)
    }
}
