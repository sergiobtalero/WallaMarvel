//
//  DTOConvertible.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 1/4/25.
//

import Foundation

protocol DTOConvertible: Decodable {
    associatedtype DomainModel: Sendable
    func toDomainModel() -> DomainModel
}
