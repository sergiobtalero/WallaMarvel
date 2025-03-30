//
//  CharacterDataModel.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public struct CharacterDataModel {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    
    public init(id: Int, name: String, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
    }
}
