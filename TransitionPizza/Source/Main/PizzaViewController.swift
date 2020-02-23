//
//  PizzaViewController.swift
//  TransitionPizza
//
//  Created by Ricardo Tokashiki on 28/01/2020.
//  Copyright © 2020 Nodes ApS. All rights reserved.
//

import UIKit

final class PizzaViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "PizzaViewCell", bundle: nil), forCellWithReuseIdentifier: "PizzaCell")

            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }

    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - Variables
    let viewModel = PizzaViewModel()

    // MARK: - Init
    class func instantiate() -> PizzaViewController {
        let name = "\(PizzaViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! PizzaViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self

        viewModel.delegate = self
        viewModel.getPizzas()
    }
}

// MARK: - UICollectionViewDataSource
extension PizzaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pizzas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PizzaCell", for: indexPath) as! PizzaViewCell
        if let image = UIImage(named: viewModel.pizzas[indexPath.row].title) {
            cell.configure(with: image, color: viewModel.pizzas[indexPath.row].hexBackgroundColor.hexColor)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PizzaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        viewModel.indexPath = indexPath
        let pizza = viewModel.pizzas[indexPath.row]

        let detailVC = PizzaDetailViewController.instantiate()
        detailVC.pizza = pizza

        navigationController?.modalPresentationStyle = .custom
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PizzaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
    }
}

// MARK: - ScrollViewDidScroll
extension PizzaViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
}

extension PizzaViewController: PizzaViewModelDelegate {
    func pizzasDidLoad() {
        collectionView.reloadData()

        pageControl.numberOfPages = viewModel.pizzas.count
        pageControl.currentPage = 0
    }
}

// MARK: - UINavigationControllerDelegate
extension PizzaViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return AnimationManager(animationDuration: 1.3, animationType: .present)
        case .pop:
            return AnimationManager(animationDuration: 1.3, animationType: .dismiss)
        default:
            return nil
        }
    }
}

// MARK: - PizzaTransitionable
extension PizzaViewController: PizzaTransitionable {
    var backgroundView: UIView {
        guard
            let indexPath = viewModel.indexPath,
            let pizzaCell = collectionView.cellForItem(at: indexPath) as? PizzaViewCell
        else {
            return UIView()
        }
        return pizzaCell.containerView
    }

    var pizzaImage: UIImageView {
        guard
            let indexPath = viewModel.indexPath,
            let pizzaCell = collectionView.cellForItem(at: indexPath) as? PizzaViewCell
        else {
            return UIImageView()
        }
        return pizzaCell.pizzaImage
    }
}
