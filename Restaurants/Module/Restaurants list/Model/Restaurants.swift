//
//  Restaurants.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import Foundation

// MARK: - Restaurants
struct Restaurants: Decodable {
    let restaurants: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Decodable {
    let name: String
    let status: Status
    let sortingValues: SortingValues
}

// MARK: - SortingValues
struct SortingValues: Decodable {
    let bestMatch, newest, popularity, averageProductPrice: Int
    let ratingAverage: Float
}

// MARK: - Logic
extension Restaurants {
    func restaurants(of status: Status,
                     for searchedName: String,
                     sortOption: SortOption) -> [Restaurant] {

        let localRestaurants = restaurants.filter( { $0.status == status && (searchedName.isEmpty ? true : $0.name.contains(searchedName)) })
        return sort(restaurants: localRestaurants, option: sortOption)
    }

    func allRestaurants(for searchedName: String, sortOption: SortOption) -> [Restaurant] {
        var localRestaurants = [Restaurant]()
        Status.allCases.forEach {
            localRestaurants.append(contentsOf: restaurants(of: $0,
                                                            for: searchedName,
                                                            sortOption: sortOption))
        }
        return localRestaurants
    }

    // We can use partial keypaths here, but kept it simple
    private func sort(restaurants: [Restaurant], option: SortOption) -> [Restaurant] {
        switch option {
        case .none: return restaurants
        case .byNameAscending: return restaurants.sorted(by: \.name, ascending: true)
        case .byNameDescending: return restaurants.sorted(by: \.name)
        case .bestMatch: return restaurants.sorted(by: \.sortingValues.bestMatch)
        case .newest: return restaurants.sorted(by: \.sortingValues.newest)
        case .popularity: return restaurants.sorted(by: \.sortingValues.popularity)
        case .ratingAverage: return restaurants.sorted(by: \.sortingValues.ratingAverage)
        case .priceLowerToHigher: return restaurants.sorted(by: \.sortingValues.averageProductPrice, ascending: true)
        case .priceHigherToLower: return restaurants.sorted(by: \.sortingValues.averageProductPrice)
        }
    }
}
