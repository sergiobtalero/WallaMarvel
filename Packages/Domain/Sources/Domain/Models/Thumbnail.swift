//
//  Thumbnail.swift
//  Domain
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public struct Thumbnail: Equatable, Sendable {
    public let path: String
    public let `extension`: String
    
    public init(path: String, extension: String) {
        self.path = path
        self.extension = `extension`
    }
}
