//
//  CharacterDataContainer.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public struct DataContainer<T: Sendable>: Sendable {
    public let count: Int
    public let limit: Int
    public let offset: Int
    public let total: Int
    public let results: [T]
    
    public init(count: Int, limit: Int, offset: Int, total: Int, results: [T]) {
        self.count = count
        self.limit = limit
        self.offset = offset
        self.total = total
        self.results = results
    }
}
