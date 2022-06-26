//
//  Sort.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import Foundation

final class SortViewModel: ObservableObject {

    // MARK: - Variable
    @Published private(set) var selectedSortOption: SortOption = .none
    let sortOptions: [SortOption]
    private let sortAction: (SortOption) -> Void

    // MARK: - Initialiser
    init(sortOptions: [SortOption],
         selectedSortOption: SortOption = .none,
         sortAction: @escaping (SortOption) -> Void) {
        self.sortOptions = sortOptions
        self.selectedSortOption = selectedSortOption
        self.sortAction = sortAction
    }

    // MARK: - Methods
    func handleSortOptionChange(sortOption: SortOption) {
        selectedSortOption = sortOption
        sortAction(sortOption)
    }

    func imageName(for option: SortOption) -> String {
        option == selectedSortOption ? "circle.inset.filled" : "circle"
    }
}
