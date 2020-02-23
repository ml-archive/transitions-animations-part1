//
//  PizzaViewCell.swift
//  TransitionPizza
//
//  Created by Ricardo Tokashiki on 29/01/2020.
//  Copyright © 2020 Nodes ApS. All rights reserved.
//

import UIKit

protocol PizzaViewConfigure {
    func configure(with image: UIImage, color: UIColor)
}

final class PizzaViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .red
            containerView.layer.cornerRadius = 8
        }
    }

    @IBOutlet weak var pizzaImage: UIImageView! {
        didSet {
            pizzaImage.layer.cornerRadius = pizzaImage.bounds.width / 2
            pizzaImage.contentMode = .scaleAspectFill
        }
    }
}

extension PizzaViewCell: PizzaViewConfigure {
    func configure(with image: UIImage, color: UIColor) {
        pizzaImage.image = image
        containerView.backgroundColor = color.withAlphaComponent(0.3)
    }
}
