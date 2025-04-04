//
//  MarvelRepository.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol MarvelRepositoryProtocol {
    func getHeroes(page: Int) async throws -> DataContainer<Character>
    func getDetailsOfHero(id: Int) async throws -> Character
    func getComicsOfHero(id: Int) async throws -> [Comic]
    func getSeriesOfHero(id: Int) async throws -> [Series]
}
