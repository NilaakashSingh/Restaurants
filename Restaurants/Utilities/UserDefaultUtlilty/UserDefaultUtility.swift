//
//  UserDefaultUtility.swift
//  Restaurants
//
//  Created by Nilaakash Singh on 24/06/22.
//

import Foundation

final class UserDefaultsManager {

    // MARK: - Variable
    private let userDefaults: UserDefaults

    // MARK: - Initialiser
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = UserDefaults.standard
    }

    // MARK: - Methods
    func setValue(value: String, key: String) {
        userDefaults.set(value, forKey: key)
    }

    func getValue(for key: String) -> String? {
        userDefaults.object(forKey: key) as? String
    }
}
