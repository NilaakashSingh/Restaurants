//
//  DataProviderMock.swift
//  RestaurantsTests
//
//  Created by Nilaakash Singh on 24/06/22.
//

import Foundation
@testable import Restaurants

enum TestError: Error {
    case mock
}

class DataProviderMock: DataProviderProtocol {

    // MARK: - Show Error Variable
    var showError = false

    // MARK: - Implementation
    func mockData<T>(forName name: String) throws -> T? where T : Decodable {
        if !showError {
            do {
                guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                      let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
                else { return nil }
                let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                return decodedData
            } catch {
                throw error
            }
        } else {
            throw TestError.mock
        }
    }
}
