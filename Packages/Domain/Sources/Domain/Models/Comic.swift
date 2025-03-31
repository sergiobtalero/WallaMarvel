//
//  Comic.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Foundation

public protocol HasThumbnailImage {
    var thumbailImage: URL? { get }
}

public struct Comic: Identifiable, Sendable, Equatable, Hashable, HasThumbnailImage, HasTitle {
    public let id: Int
    public let title: String
    public let description: String?
    public let pageCount: Int
    public let thumbnail: Thumbnail
    public let images: [Thumbnail]
    
    public var thumbailImage: URL? {
        thumbnail.imageURL
    }
    
    public init(id: Int, title: String, description: String?, pageCount: Int, thumbnail: Thumbnail, images: [Thumbnail]) {
        self.id = id
        self.title = title
        self.description = description
        self.pageCount = pageCount
        self.thumbnail = thumbnail
        self.images = images
    }
}
