//
//  RestaurantStatus.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import Foundation

enum Status: String, Decodable, CaseIterable {
    case open = "open"
    case orderAhead = "order ahead"
    case closed = "closed"
}
