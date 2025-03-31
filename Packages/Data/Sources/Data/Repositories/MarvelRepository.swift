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
        case heroes(page: Int, limit: Int)
        case heroDetail(id: Int)
        case comics(id: Int)
        case series(id: Int)
        
        var path: String {
            switch self {
            case .heroes: return "/characters"
            case .heroDetail(let id): return "/characters/\(id)"
            case .comics(let id): return "/characters/\(id)/comics"
            case .series(let id): return "/characters/\(id)/series"
            }
        }
    }
}

// MARK: - MarvelRepositoryProtocol
extension MarvelRepository: MarvelRepositoryProtocol {
    public func getHeroes(page: Int) async throws -> DataContainer<Hero> {
        let responseLimit = 20
        let url = try buildURL(for: .heroes(page: page, limit: responseLimit))
        let entities: ContainerDTO<HeroDTO> = try await networkManager.fetch(from: url)
        return entities.toDomain()
    }
    
    public func getDetailsOfHero(id: Int) async throws -> Hero {
        let url = try buildURL(for: .heroDetail(id: id))
        let entities: ContainerDTO<HeroDTO> = try await networkManager.fetch(from: url)
        if let details = entities.results.first?.toDomainModel() {
            return details
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    public func getComicsOfHero(id: Int) async throws -> [Comic] {
        let url = try buildURL(for: .comics(id: id))
        let entities: ContainerDTO<ComicDTO> = try await networkManager.fetch(from: url)
        return entities.results.compactMap { $0.toDomainModel() }
    }
    
    public func getSeriesOfHero(id: Int) async throws -> [Series] {
        let url = try buildURL(for: .series(id: id))
        let entities: ContainerDTO<SeriesDTO> = try await networkManager.fetch(from: url)
        return entities.results.compactMap { $0.toDomainModel() }
    }
}

// MARK: - Private
private extension MarvelRepository {
    func buildURL(for endpoint: Endpoint) throws -> URL {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
        var parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash]
        switch endpoint {
        case .heroes(let page, let limit):
            let safePage = max(1, page)
            let offset = (safePage - 1) * limit
            parameters["limit"] = String(limit)
            parameters["offset"] = String(offset)
        default:
            break
        }
        
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
