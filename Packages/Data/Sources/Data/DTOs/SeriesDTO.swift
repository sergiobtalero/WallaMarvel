//
//  SeriesDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Foundation

struct SeriesDTO: DTOConvertible {    
    let id: Int
    let title: String
    let description: String?
    let startYear: Int
    let endYear: Int
    let thumbnail: ThumbnailDTO?

    // MARK: - Domain
    func toDomainModel() -> Series {
        Series(
            id: id,
            title: title,
            description: description,
            startYear: startYear,
            endYear: endYear,
            thumbnailURL: thumbnail?.url
        )
    }
}
