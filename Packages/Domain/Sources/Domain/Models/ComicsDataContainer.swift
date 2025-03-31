//
//  ComicsDataContainer.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

public struct ComicsDataContainer {
    public let count: Int
    public let limit: Int
    public let offset: Int
    public let total: Int
    public let comics: [Comic]
    
    public init(count: Int, limit: Int, offset: Int, total: Int, comics: [Comic]) {
        self.count = count
        self.limit = limit
        self.offset = offset
        self.total = total
        self.comics = comics
    }
}
