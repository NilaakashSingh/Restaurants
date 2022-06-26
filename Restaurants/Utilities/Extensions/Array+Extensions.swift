//
//  Array+Extensions.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 24/06/22.
//

import Foundation

extension Array {
    func sorted<T: Comparable>(by compare: (Element) -> T, ascending order: Bool = false) -> Array {
        sorted { order ? compare($0) < compare($1) : compare($0) > compare($1) }
    }
}
