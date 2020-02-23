//
//  Pizza.swift
//  TransitionPizza
//
//  Created by Ricardo Tokashiki on 30/01/2020.
//  Copyright © 2020 Nodes ApS. All rights reserved.
//

import Foundation

struct Pizza: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let currency: String
    let hexBackgroundColor: String
}
