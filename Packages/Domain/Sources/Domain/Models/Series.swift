//
//  Series.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Foundation

public struct Series: Sendable, Equatable, Hashable {
    public let id: Int
    public let title: String
    public let description: String?
    public let startYear: Int
    public let endYear: Int
    public let thumbnail: Thumbnail?
    
    public init(id: Int, title: String, description: String?, startYear: Int, endYear: Int, thumbnail: Thumbnail?) {
        self.id = id
        self.title = title
        self.description = description
        self.startYear = startYear
        self.endYear = endYear
        self.thumbnail = thumbnail
    }
}
