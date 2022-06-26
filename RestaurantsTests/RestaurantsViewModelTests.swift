//
//  RestaurantsViewModelTests.swift
//  RestaurantsTests
//
//  Created by Nilaakash Singh on 22/06/22.
//

import XCTest
@testable import Restaurants

class RestaurantsViewModelTests: XCTestCase {

    private var viewModel: RestaurantsViewModel?
    private let testSuite = UserDefaults(suiteName: UserDefaultsKey.testSuite) ?? UserDefaults.standard
    private var userDefaultManager: UserDefaultsManager!

    override func setUpWithError() throws {
        userDefaultManager = UserDefaultsManager(userDefaults: testSuite)
        viewModel = RestaurantsViewModel(dataProvider: DataProviderMock(),
                                         userDefaultsManager: userDefaultManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        userDefaultManager = nil
    }

    // Testing computed property
    func testSortTitle() throws {
        XCTAssertEqual(try XCTUnwrap(viewModel?.sortTitle), .empty)

        userDefaultManager?.setValue(value: SortOption.newest.rawValue,
                                     key: UserDefaultsKey.sort)
        viewModel = RestaurantsViewModel(dataProvider: DataProviderMock(),
                                         userDefaultsManager: userDefaultManager)
        XCTAssertEqual(try XCTUnwrap(viewModel?.sortTitle),
                       .colon + .space + SortOption.newest.rawValue)
    }
}

