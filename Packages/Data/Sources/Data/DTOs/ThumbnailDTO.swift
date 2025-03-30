//
//  ThumbnailDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain

struct ThumbnailDTO: Decodable {
    let path: String
    let `extension`: String
    
    func toDomainModel() -> Thumbnail {
        return Thumbnail(path: path, extension: `extension`)
    }
}
