//
//  CharacterDataContainer.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public struct CharacterDataContainer {
    let count: Int
    let limit: Int
    let offset: Int
    let characters: [CharacterDataModel]
    
    public init(count: Int, limit: Int, offset: Int, characters: [CharacterDataModel]) {
        self.count = count
        self.limit = limit
        self.offset = offset
        self.characters = characters
    }
}
