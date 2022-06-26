//
//  RestaurantsList.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import SwiftUI

struct RestaurantsList: View {

    // MARK: - Variables
    @State private var navigateToSort = false
    @ObservedObject private var viewModel: RestaurantsViewModel

    // MARK: - Initialiser
    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        // Ideally we can use localisation for all the copy text, but for saving time i am hardcoding it
        NavigationView {
            VStack {
                sortView
                List {
                    ForEach(viewModel.restaurantList, id: \.name) { restaurant in
                        VStack(alignment: .leading) {
                            Text(restaurant.name)
                            Text("Status: \(restaurant.status.rawValue)")
                            Text("Best Match: \(restaurant.sortingValues.bestMatch)")
                            Text("Newest: \(restaurant.sortingValues.newest)")
                            Text("Rating Average: \(restaurant.sortingValues.ratingAverage)")
                            Text("Average Product Price: \(restaurant.sortingValues.averageProductPrice)")
                            Text("Popularity: \(restaurant.sortingValues.popularity)")
                        }
                    }
                }
                .searchable(text: $viewModel.searchedName)
                .listStyle(.plain)
                .navigationTitle("Restaurants")
            }
        }
        .onChange(of: viewModel.searchedName, perform: { _ in
            withAnimation { viewModel.updateRestaurantList() }
        })
    }

    // MARK: - Supporting view
    private var sortView: some View {
        HStack(spacing: .zero) {
            Spacer()
            Button("Sort by\(viewModel.sortTitle)") { navigateToSort.toggle() }
                .overlay(NavigationLink(destination: SortView(viewModel: viewModel.sortViewModel()),
                                        isActive: $navigateToSort) { })
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsList(viewModel: RestaurantsViewModel(dataProvider: DataProvider()))
    }
}
