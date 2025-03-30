import Testing
import Foundation
@testable import Domain

struct GetHeroesUseCaseTests {
    let repositoryMock: MarvelRepositoryMock
    
    init() {
        repositoryMock = MarvelRepositoryMock()
    }
    
    @Test func executeWithSuccess() async throws {
        let sut = GetHeroesUseCase(repository: repositoryMock)
        let heroes = try await sut.execute(page: 1)
        #expect(heroes.count == 100)
    }
    
    @Test func executeWithError() async throws {
        let sut = GetHeroesUseCase(repository: repositoryMock)
        repositoryMock.error = NSError(domain: "", code: 500, userInfo: nil)
        do {
            let _ = try await sut.execute(page: 1)
            throw TestError(message: "Unexpected response. Expected error")
        } catch let error as NSError {
            #expect(error.code == 500)
        }
    }
}
