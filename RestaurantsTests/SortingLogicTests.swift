//
//  SortingLogicTests.swift
//  RestaurantsTests
//
//  Created by Nilaakash Singh on 26/06/22.
//

import XCTest
@testable import Restaurants

class SortingLogicTests: XCTestCase {

    var restaurants: Restaurants?

    override func setUp() async throws {
        restaurants = try DataProviderMock().mockData(forName: String(describing: Restaurants.self))
    }

    override func tearDownWithError() throws {
        restaurants = nil
    }

    // Testing all the sorting logic available
    func testSortOptions() throws {
        // We will not be testing search here because we have already tested search in viewModel
        try SortOption.allCases.forEach { option in
            let name = try XCTUnwrap(restaurants?.allRestaurants(for: .empty,
                                                             sortOption: option).first?.name)
            switch option {
            case .none:
                XCTAssertEqual(name, "Tanoshii Sushi")
            case .byNameAscending:
                XCTAssertEqual(name, "Aarti 2")
            case .byNameDescending:
                XCTAssertEqual(name, "Tanoshii Sushi")
            case .bestMatch:
                XCTAssertEqual(name, "Lunchpakketdienst")
            case .newest:
                XCTAssertEqual(name, "Indian Kitchen")
            case .popularity:
                XCTAssertEqual(name, "Roti Shop")
            case .ratingAverage:
                XCTAssertEqual(name, "Tanoshii Sushi")
            case .priceLowerToHigher:
                XCTAssertEqual(name, "De Amsterdamsche Tram")
            case .priceHigherToLower:
                XCTAssertEqual(name, "Lunchpakketdienst")
            }
        }
    }
}
