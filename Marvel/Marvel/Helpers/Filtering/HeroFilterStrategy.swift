//
//  HeroFilterStrategy.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 1/4/25.
//

import Domain
import Foundation

protocol HeroFilterStrategy {
    func filter(heroes: [Character], withSearchText searchText: String) -> [Character]
}

final class NameFilter: HeroFilterStrategy {
    func filter(heroes: [Character], withSearchText searchText: String) -> [Character] {
        heroes.filter { $0.name.contains(searchText.trimmingCharacters(in: .whitespaces)) }
    }
}
