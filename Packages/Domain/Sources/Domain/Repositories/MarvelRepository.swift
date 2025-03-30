//
//  MarvelRepository.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol MarvelRepositoryProtocol {
    func getHeroes() async throws -> CharacterDataContainer
}
