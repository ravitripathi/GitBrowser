//
//  Storage.swift
//  GitBrowser
//
//  Created by Ravi Tripathi on 25/07/20.
//

import Foundation

@propertyWrapper
public struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults(suiteName: "group.io.github.ravitripathi.Arcadia")?.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }
            
            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults(suiteName: "group.io.github.ravitripathi.Arcadia")!.set(data, forKey: key)
        }
    }
}
