//
//  URLSessionProtocol.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
