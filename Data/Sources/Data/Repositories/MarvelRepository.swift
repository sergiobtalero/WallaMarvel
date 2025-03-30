//
//  MarvelRepository.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import Foundation

final class MarvelRepository {
    private let baseURL: String
    private let session: URLSession
    
    init(baseURL: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
}

// MARK: - Constants
private extension MarvelRepository {
    enum Constant {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
    }
    
    enum Endpoint {
        case heroes
        
        var path: String {
            switch self {
            case .heroes: return "/characters"
            }
        }
    }
}

// MARK: - MarvelRepositoryProtocol
extension MarvelRepository: MarvelRepositoryProtocol {
    func getHeroes() async throws -> CharacterDataContainer {
        let url = try buildURL(for: .heroes)
        let (data, response) = try await session.data(from: url)
        try validateResponse(response)
        let jsonDecoder = JSONDecoder()
        let dataContainer = try jsonDecoder.decode(CharacterDataContainerDTO.self, from: data)
        return dataContainer.toDomainModel()
    }
}

// MARK: - Private
private extension MarvelRepository {
    func buildURL(for endpoint: Endpoint) throws -> URL {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash]
        guard var urlComponent = URLComponents(string: "\(baseURL)\(endpoint.path)") else {
            throw URLError(.badURL)
        }
        urlComponent.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = urlComponent.url else {
            throw URLError(.badURL)
        }
        return url
    }
    
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
