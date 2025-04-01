//
//  Series.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Foundation

public protocol HasTitle {
    var title: String { get }
}

public struct Series: Identifiable, Sendable, Equatable, Hashable, HasThumbnailImage, HasTitle {
    public let id: Int
    public let title: String
    public let description: String?
    public let startYear: Int
    public let endYear: Int
    public let thumbnailURL: URL?
    
    public init(id: Int, title: String, description: String?, startYear: Int, endYear: Int, thumbnailURL: URL?) {
        self.id = id
        self.title = title
        self.description = description
        self.startYear = startYear
        self.endYear = endYear
        self.thumbnailURL = thumbnailURL
    }
}
