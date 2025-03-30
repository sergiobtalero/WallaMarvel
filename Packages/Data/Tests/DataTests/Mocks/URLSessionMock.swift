//
//  URLSessionMock.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation
import Data

final class URLSessionMock: URLSessionProtocol {
    var error: URLError?
    var response: URLResponse?
    var data: Data?
    
    private(set) var lastURL: URL?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        lastURL = url
        try await Task.sleep(nanoseconds: 1_000_000)
        
        if let error {
            throw error
        }
        guard let data, let response else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
