//
//  CharacterDataModel.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public struct Character: Identifiable, Equatable, Sendable, Hashable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnailURL: URL?
    public var comics: [Comic] = []
    public var series: [Series] = []
    
    public init(id: Int, name: String, description: String, thumbnailURL: URL?) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnailURL = thumbnailURL
    }
}
