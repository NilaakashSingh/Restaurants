//
//  DataProvider.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 22/06/22.
//

import Foundation

protocol DataProviderProtocol {
    func mockData<T: Decodable>(forName name: String) throws -> T?
}

class DataProvider: DataProviderProtocol {
    func mockData<T: Decodable>(forName name: String) throws -> T? {
        do {
            guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                  let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            else { return nil }
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        } catch {
            throw error
        }
    }
}
