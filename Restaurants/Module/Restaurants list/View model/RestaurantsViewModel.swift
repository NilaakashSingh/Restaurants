//
//  RestaurantsViewModel.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import Combine

final class RestaurantsViewModel: ObservableObject {

    // MARK: - Variables
    @Published private(set) var restaurantList = [Restaurant]()
    @Published private(set) var selectedSortOption: SortOption = .none
    @Published var searchedName = StringLiteralType.empty
    private var restaurants = Restaurants(restaurants: [])
    private let userDefaultsManager: UserDefaultsManager

    // MARK: - Computed Properties
    var sortTitle: String {
        selectedSortOption == .none ? .empty : .colon + .space + selectedSortOption.rawValue
    }

    // MARK: - Initialiser
    init(dataProvider: DataProviderProtocol,
         userDefaultsManager: UserDefaultsManager = UserDefaultsManager()) {
        self.userDefaultsManager = userDefaultsManager
        if let restaurants = restaurantList(for: dataProvider) {
            selectedSortOption = persistedSortValue()
            self.restaurants = restaurants
            restaurantList = computeRestaurantList()
        }
    }

    // MARK: - Internal Methods
    func computeRestaurantList() -> [Restaurant] {
        restaurants.allRestaurants(for: searchedName,
                                   sortOption: selectedSortOption)
    }

    func updateRestaurantList() {
        restaurantList = restaurants.allRestaurants(for: searchedName,
                                                    sortOption: selectedSortOption)
    }

    func sortViewModel() -> SortViewModel {
        SortViewModel(sortOptions: SortOption.allCases,
                      selectedSortOption: selectedSortOption) { [weak self] sortOption in
            guard let self = self else { return }
            self.selectedSortOption = sortOption
            self.userDefaultsManager.setValue(value: sortOption.rawValue,
                                              key: UserDefaultsKey.sort)
            self.restaurantList = self.computeRestaurantList()
        }
    }

    // MARK: - Private Method
    private func restaurantList(for dataProvider: DataProviderProtocol) -> Restaurants? {
        do {
            guard let restaurants: Restaurants = try dataProvider.mockData(forName: String(describing: Restaurants.self)) else { return nil }
            return restaurants
        } catch {
            print(error) // Either handle error here or show it in alert on View
            return nil
        }
    }

    private func persistedSortValue() -> SortOption {
        guard let savedSortOption = userDefaultsManager.getValue(for: UserDefaultsKey.sort)
        else { return .none }
        return SortOption(rawValue: savedSortOption) ?? .none
    }
}
