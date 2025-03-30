//
//  MarvelRepository.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import Foundation

public final class MarvelRepository {
    private let baseURL: String
    private let networkManager: NetworkManager
    
    public init(baseURL: String, networkManager: NetworkManager) {
        self.baseURL = baseURL
        self.networkManager = networkManager
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
    public func getHeroes(page: Int) async throws -> CharacterDataContainer {
        let url = try buildURL(for: .heroes, page: page)
        let entities: CharacterDataContainerDTO = try await networkManager.fetch(from: url)
        return entities.toDomainModel()
    }
}

// MARK: - Private
private extension MarvelRepository {
    func buildURL(for endpoint: Endpoint, page: Int, limit: Int = 20) throws -> URL {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let safePage = max(1, page)
        let offset = (safePage - 1) * limit
        let parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash,
                                            "limit": String(limit),
                                            "offset": String(offset)]
        guard var urlComponent = URLComponents(string: "\(baseURL)\(endpoint.path)") else {
            throw URLError(.badURL)
        }
        urlComponent.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponent.url else {
            throw URLError(.badURL)
        }
        return url
    }
}
