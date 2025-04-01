//
//  Comic.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Foundation

public protocol HasThumbnailImage {
    var thumbnailURL: URL? { get }
}

public struct Comic: Identifiable, Sendable, Equatable, Hashable, HasThumbnailImage, HasTitle {
    public let id: Int
    public let title: String
    public let description: String?
    public let pageCount: Int
    public let thumbnailURL: URL?
    public let images: [URL]
    
    public init(id: Int, title: String, description: String?, pageCount: Int, thumbnailURL: URL?, images: [URL]) {
        self.id = id
        self.title = title
        self.description = description
        self.pageCount = pageCount
        self.thumbnailURL = thumbnailURL
        self.images = images
    }
}
