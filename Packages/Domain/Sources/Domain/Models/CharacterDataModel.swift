//
//  CharacterDataModel.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public struct CharacterDataModel: Identifiable, Equatable, Sendable, Hashable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    public var comics: [Comic] = []
    
    public var imageURL: URL? {
        let path = thumbnail.path + "." + thumbnail.extension
        return URL(string: path)
    }
    
    public init(id: Int, name: String, description: String, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}
