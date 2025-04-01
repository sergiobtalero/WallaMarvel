//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 1/4/25.
//

import Domain
import SwiftUI

enum Screen: Identifiable, Hashable {
    case charactersList
    case characterDetail(_ character: Character)
    
    var id: Self { return self }
}

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    
    func push(_ screen: Screen)
    func pop()
    func popToRoot()
}

final class AppCoordinator: AppCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    
    // MARK: - Navigation Functions
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .charactersList:
            CharactersListView()
        case .characterDetail(let character):
            CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
        }
    }
}

struct CoordinatorView: View {
    @StateObject var appCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.charactersList)
                .navigationDestination(for: Screen.self) { screen in
                    appCoordinator.build(screen)
                }
        }
        .environmentObject(appCoordinator)
    }
}
