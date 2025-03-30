import Foundation
import Testing
@testable import Data

struct MarvelRepositoryTests {
    let sessionMock: URLSessionMock
    let sut: MarvelRepository
    let networkManager: NetworkManager
    
    // MARK: - Initializer
    init() throws {
        sessionMock = URLSessionMock()
        networkManager = NetworkManager(session: sessionMock)
        sut = MarvelRepository(
            baseURL: "",
            networkManager: networkManager
        )
    }
    
    // MARK: - Tests
    @Test func getHeroesSuccessfully() async throws {
        guard let url = Bundle.module.url(forResource: "Characters", withExtension: "json") else {
            throw TestError(message: "Could not find Characters.json in test bundle")
        }
        
        let sut = makeSUT(
            data: try Data(contentsOf: url),
            response: HTTPURLResponse(url: URL(string: "https://www.test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        )
        
        let heroes = try await sut.getHeroes(page: 1)
        
        #expect(!heroes.characters.isEmpty)
    }
    
    @Test func getErrorOnBadServerReponse() async throws {
        let sut = makeSUT(error: URLError(.badServerResponse))
        
        do {
            let _ = try await sut.getHeroes(page: 1)
            throw TestError(message: "Unexpected response. Expected error.")
        } catch let error as URLError {
            #expect(error.code == .badServerResponse)
        } catch {
            throw TestError(message: "Unexpected Error. Expected URLError.")
        }
    }
}

private extension MarvelRepositoryTests {
    func makeSUT(error: URLError? = nil, data: Data? = nil, response: HTTPURLResponse? = nil) -> MarvelRepository {
        sessionMock.data = data
        sessionMock.response = response
        sessionMock.error = error
        
        return MarvelRepository(baseURL: "", networkManager: networkManager)
    }
}
