//
//  CharacterDataModelDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain

struct CharacterDataModelDTO: Decodable {
    let id: Int
    let name: String
    let thumbnail: ThumbnailDTO
    
    func toDomainModel() -> CharacterDataModel {
        return CharacterDataModel(
            id: id,
            name: name,
            thumbnail: thumbnail.toDomainModel()
        )
    }
}
