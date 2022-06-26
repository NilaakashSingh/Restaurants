//
//  SortByView.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import SwiftUI

struct SortView: View {

    // MARK: - Variable
    @ObservedObject private var viewModel: SortViewModel

    // MARK: - Initialiser
    init(viewModel: SortViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                ForEach(viewModel.sortOptions, id: \.self) { sortOption in
                    sortOptionView(sortOption: sortOption)
                    .padding(.horizontal)
                    Divider()
                }
                .padding(.vertical, 5)
                Spacer()
            }
        }
        .navigationTitle("Sort By")
    }

    private func sortOptionView(sortOption: SortOption) -> some View {
        HStack(spacing: .zero) {
            Text(sortOption.rawValue)
            Spacer()
            Image(systemName: viewModel.imageName(for: sortOption))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.handleSortOptionChange(sortOption: sortOption)
        }
    }
}
