//
//  ComicsDataContainerDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Foundation

protocol DTOConvertible: Decodable {
    associatedtype DomainModel: Sendable
    func toDomainModel() -> DomainModel
}

struct ContainerDTO<T: DTOConvertible>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case data
        case total
        case count, limit, offset, results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = try data.decode(Int.self, forKey: .count)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.offset = try data.decode(Int.self, forKey: .offset)
        self.total = try data.decode(Int.self, forKey: .total)
        self.results = try data.decode([T].self, forKey: .results)
    }
    
    func toDomain() -> DataContainer<T.DomainModel> {
        let models = results.map { $0.toDomainModel() }
        return DataContainer(count: count, limit: limit, offset: offset, total: total, results: models)
    }
}
