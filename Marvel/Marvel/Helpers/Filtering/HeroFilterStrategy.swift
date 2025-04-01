//
//  HeroFilterStrategy.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 1/4/25.
//

import Domain
import Foundation

protocol HeroFilterStrategy {
    func filter(heroes: [Hero], withSearchText searchText: String) -> [Hero]
}

final class NameFilter: HeroFilterStrategy {
    func filter(heroes: [Hero], withSearchText searchText: String) -> [Hero] {
        heroes.filter { $0.name.contains(searchText.trimmingCharacters(in: .whitespaces)) }
    }
}
