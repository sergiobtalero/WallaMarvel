//
//  ComicDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Foundation

struct ComicDTO: DTOConvertible {
    let id: Int
    let title: String
    let description: String?
    let pageCount: Int
    let thumbnail: ThumbnailDTO
    let images: [ThumbnailDTO]
    
    // MARK: - Domain
    func toDomainModel() -> Comic {
        return Comic(
            id: id,
            title: title,
            description: description,
            pageCount: pageCount,
            thumbnailURL: thumbnail.url,
            images: images.compactMap { $0.url }
        )
    }
}
