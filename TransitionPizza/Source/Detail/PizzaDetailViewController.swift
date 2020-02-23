//
//  PizzaDetailViewController.swift
//  TransitionPizza
//
//  Created by Ricardo Tokashiki on 02/02/2020.
//  Copyright © 2020 Nodes ApS. All rights reserved.
//

import UIKit

final class PizzaDetailViewController: UIViewController {

    @IBOutlet weak var detailBackgroundView: UIView!
    @IBOutlet weak var detailPizzaImage: UIImageView! {
        didSet {
            detailPizzaImage.layer.cornerRadius = detailPizzaImage.bounds.width / 2
            detailPizzaImage.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            closeButton.layer.cornerRadius = closeButton.bounds.width / 2
        }
    }

    // MARK: - Variables
    var pizza: Pizza?

    // MARK: - Init
    class func instantiate() -> PizzaDetailViewController {
        let name = "\(PizzaDetailViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! PizzaDetailViewController
        return vc
    }

    override func viewDidLoad() {

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        self.view.addGestureRecognizer(tapGesture)

        guard let pizza = pizza else { return }
        detailBackgroundView.backgroundColor = pizza.hexBackgroundColor.hexColor.withAlphaComponent(0.3)
        detailPizzaImage.image = UIImage(named: pizza.title)
    }
}

extension PizzaDetailViewController {
    @objc func viewDidTap() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - PizzaTransitionable
extension PizzaDetailViewController: PizzaTransitionable {
    var backgroundView: UIView {
        return detailBackgroundView
    }

    var pizzaImage: UIImageView {
        return detailPizzaImage
    }
}
