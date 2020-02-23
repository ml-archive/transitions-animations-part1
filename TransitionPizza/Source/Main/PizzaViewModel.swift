//
//  PizzaViewModel.swift
//  TransitionPizza
//
//  Created by Ricardo Tokashiki on 29/01/2020.
//  Copyright © 2020 Nodes ApS. All rights reserved.
//

import Foundation

protocol PizzaViewModelDelegate: class {
    func pizzasDidLoad()
}

final class PizzaViewModel {

    weak var delegate: PizzaViewModelDelegate?

    var pizzas: [Pizza] = []
    var indexPath: IndexPath?

    private let fileManager = FileManager.default
    private let jsonDecoder = JSONDecoder()
    private var pizzaResponse: PizzaResponse?

    func getPizzas() {
        // Try to get the file and decode the data into a discovery response object.
        do {
            guard
                let path = Bundle.main.path(forResource: "Pizzas", ofType: "json"),
                fileManager.fileExists(atPath: path),
                let data = fileManager.contents(atPath: path)
            else {
                return
            }

            pizzaResponse = try jsonDecoder.decode(PizzaResponse.self, from: data)

        } catch {
            fatalError("Unexpected error: \(error)")
        }

        guard let result = pizzaResponse?.results else { return }
        pizzas = result
        delegate?.pizzasDidLoad()
    }

}
