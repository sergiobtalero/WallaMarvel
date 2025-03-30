//
//  NetworkManager.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation

public final class NetworkManager {
    private let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
//        printResponse(data: data)
        try validateResponse(response)
        let jsonDecoder = JSONDecoder()
        let decodedObject = try jsonDecoder.decode(T.self, from: data)
        return decodedObject
    }
    
//    func printResponse(data: Data) {
//        do {
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
//            if let prettyJSON = String(data: prettyData, encoding: .utf8) {
//                print(prettyJSON)
//            }
//        } catch {
//            print("Error parsing JSON for pretty-print: \(error.localizedDescription)")
//        }
//    }
}

// MARK: - Private
private extension NetworkManager {
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
