//
//  RestaurantsApp.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import SwiftUI

@main
struct RestaurantsApp: App {
    var body: some Scene {
        WindowGroup {
            RestaurantsList(viewModel: RestaurantsViewModel(dataProvider: DataProvider()))
        }
    }
}
