//
//  PizzaResponse.swift
//  TransitionPizza
//
//  Created by Ricardo Tokashiki on 30/01/2020.
//  Copyright © 2020 Nodes ApS. All rights reserved.
//

import Foundation

struct PizzaResponse: Codable {
    let count: Int
    let results: [Pizza]
}
