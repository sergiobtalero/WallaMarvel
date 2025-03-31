//
//  Comic.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

public struct Comic {
    public let id: Int
    public let title: String
    public let description: String?
    public let pageCount: Int
    public let thumbnail: Thumbnail
    public let images: [Thumbnail]
    
    public init(id: Int, title: String, description: String?, pageCount: Int, thumbnail: Thumbnail, images: [Thumbnail]) {
        self.id = id
        self.title = title
        self.description = description
        self.pageCount = pageCount
        self.thumbnail = thumbnail
        self.images = images
    }
}
