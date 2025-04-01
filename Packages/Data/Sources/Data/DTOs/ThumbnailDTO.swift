//
//  ThumbnailDTO.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import Foundation

struct ThumbnailDTO: Decodable {
    let path: String
    let `extension`: String
    
    var url: URL? {
        URL(string: "\(path).\(`extension`)")
    }
}
