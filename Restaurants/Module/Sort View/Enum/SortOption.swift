//
//  SortCase.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import Foundation

enum SortOption: String, CaseIterable {
    case none = "None"
    case byNameAscending = "Name ascending"
    case byNameDescending = "Name descending"
    case bestMatch = "Best match"
    case newest = "Newest"
    case popularity = "Popularity"
    case ratingAverage = "Rating average"
    case priceLowerToHigher = "Price lower to higher"
    case priceHigherToLower = "Price higher to lower"
}
