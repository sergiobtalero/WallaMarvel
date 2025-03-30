//
//  CharacterDataContainerDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain

struct CharacterDataContainerDTO: Decodable {
    let count: Int
    let limit: Int
    let offset: Int
    let characters: [CharacterDataModelDTO]
    
    enum CodingKeys: String, CodingKey {
        case data
        case count, limit, offset, characters = "results"
    }
    
    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = try data.decode(Int.self, forKey: .count)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.offset = try data.decode(Int.self, forKey: .offset)
        
        self.characters = try data.decode([CharacterDataModelDTO].self, forKey: .characters)
    }
    
    // MARK: - Domain
    func toDomainModel() -> CharacterDataContainer {
        return CharacterDataContainer(
            count: count,
            limit: limit,
            offset: offset,
            characters: characters.map { $0.toDomainModel() }
        )
    }
}
