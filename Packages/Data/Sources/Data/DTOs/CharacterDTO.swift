//
//  CharacterDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain

struct CharacterDTO: DTOConvertible {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailDTO
    
    func toDomainModel() -> Character {
        return Character(
            id: id,
            name: name,
            description: description,
            thumbnail: thumbnail.toDomainModel()
        )
    }
}
