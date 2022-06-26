//
//  ViewModelTests.swift
//  RestaurantsTests
//
//  Created by Nilaakash Singh on 22/06/22.
//

import XCTest
@testable import Restaurants

class ViewModelTests: XCTestCase {

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

    /// Testing computed property
    func testSortTitle() throws {
        XCTAssertEqual(try XCTUnwrap(viewModel?.sortTitle), .empty)

        userDefaultManager?.setValue(value: SortOption.newest.rawValue,
                                     key: UserDefaultsKey.sort)
        viewModel = RestaurantsViewModel(dataProvider: DataProviderMock(),
                                         userDefaultsManager: userDefaultManager)
        XCTAssertEqual(try XCTUnwrap(viewModel?.sortTitle),
                       .colon + .space + SortOption.newest.rawValue)
    }

    /// Test for checking restaraunt list update when searched
    func testUpdateRestaurantList() throws {
        // When searched for "Indian" on the below method.
        viewModel?.searchedName = "Indian"
        viewModel?.updateRestaurantList()
        // Then result should have 1 value
        XCTAssertEqual(try XCTUnwrap(viewModel?.restaurantList.count), 1)

        // When searched for "Su" on the below method.
        viewModel?.searchedName = "Su"
        viewModel?.updateRestaurantList()
        // Then result should have 4 value
        XCTAssertEqual(try XCTUnwrap(viewModel?.restaurantList.count), 4)
        viewModel?.searchedName = .empty
    }

    /// Test sort viewModel method with action in it
    func testSortViewModelMethod() throws {
        let sortViewModel = viewModel?.sortViewModel()
        // When user changes sorting method
        sortViewModel?.handleSortOptionChange(sortOption: .newest)
        // Then "RestaurantsViewModel" should update selected sortOption value
        XCTAssertEqual(try XCTUnwrap(viewModel?.selectedSortOption), .newest)
        // Also restaraunt list should be updated with latest value
        XCTAssertEqual(try XCTUnwrap(viewModel?.restaurantList.first?.name), "Indian Kitchen")

        // If user tries to search something in sorted state
        viewModel?.searchedName = "Ro"
        viewModel?.updateRestaurantList()
        // Then the result should be returned in sorted state aswell
        XCTAssertEqual(try XCTUnwrap(viewModel?.restaurantList.first?.name), "Roti Shop")

        viewModel?.searchedName = .empty
        sortViewModel?.handleSortOptionChange(sortOption: .none)
    }

    /// testFailFetching case
    func testFailFetchCase() {
        let dataProviderMock = DataProviderMock()
        dataProviderMock.showError = true
        do {
            guard let _: Restaurants = try dataProviderMock.mockData(forName: String(describing: Restaurants.self)) else {
                return XCTFail()
            }
            XCTFail()
        } catch {
            XCTAssertEqual(error as! TestError, TestError.mock)
        }
    }

    /// Testing image name on sort view model
    func testImageName() throws {
        let sortViewModel = viewModel?.sortViewModel()
        // When user changes sorting method
        sortViewModel?.handleSortOptionChange(sortOption: .newest)
        // Then selected image should be filled circle and non selected should be half filled circle
        XCTAssertEqual(try XCTUnwrap(sortViewModel?.imageName(for: .none)),
                       "circle")
        XCTAssertEqual(try XCTUnwrap(sortViewModel?.imageName(for: .newest)),
                       "circle.inset.filled")

        viewModel?.searchedName = .empty
        sortViewModel?.handleSortOptionChange(sortOption: .none)
    }
}
